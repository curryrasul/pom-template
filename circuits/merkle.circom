pragma circom 2.0.0;

// Takes as input 0 || 1 and two values (left and right)
// If 0 as input, then returns values as passed; else left, right = right, left
include "../node_modules/circomlib/circuits/switcher.circom";

// SNARK-Friendly hash-function Poseidon. Takes number as input at initialization
// This number defines how many arguments will be the preimage of it.
include "../node_modules/circomlib/circuits/poseidon.circom";

// Converts number to binary
include "../node_modules/circomlib/circuits/bitify.circom";


// One level Merkle Tree check
template Mkt2VerifierLevel() {
    signal input sibling;
    signal input low;
    signal input selector;
    signal output root;

    component sw = Switcher();

    // On higher levels we need to take Poseidon(a || b)
    component hash = Poseidon(2);

    // By current bit value, we can understand how we need to call
    // hash function: Poseidon(L || R) or Poseidon(R || L)
    sw.sel <== selector;
    sw.L <== low;
    sw.R <== sibling;

    log(11111111111111111111111111111111)
    log(sw.outL)
    log(sw.outR)
    
    hash.inputs[0] <== sw.outL;
    hash.inputs[1] <== sw.outR;

    root <== hash.out;
}

// Full Merkle Tree check
template Mkt2Verifier(nLevels) {
    // Private. Ключ - порядок элемента среди листьев дерева меркла
    signal input key;
    // Private. Value (preimage of hash-function)
    signal input value;
    // Private. Root of Merkle Tree
    signal input root;
    // Leaf's siblings, necessary for merkle proof
    signal input siblings[nLevels];

    // Object
    component n2b = Num2Bits(nLevels);
    component levels[nLevels];

    // Object of hash-function that takes only one argument
    component hashV = Poseidon(1);
    
    // Poseidong(value)
    hashV.inputs[0] <== value;

    // Converting key to binary representation
    n2b.in <== key;

    for (var i = nLevels - 1; i >= 0; i--) {
        // Making a "check" on every level
        levels[i] = Mkt2VerifierLevel();
        levels[i].sibling <== siblings[i];
        levels[i].selector <== n2b.out[i];
        if (i == nLevels - 1) {
            levels[i].low <== hashV.out;
        } else {
            levels[i].low <== levels[i + 1].root;
        }

        // Here we also calculating "root" on every level
    }

    // Constraint that calculated root is equal to root (input)
    root === levels[0].root;
}
