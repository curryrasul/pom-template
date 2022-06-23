const hash = require("circomlibjs").poseidon;
const { merkelize, getMerkleProof } = require("../js/merkle.js");
const F = require("circomlibjs").babyjub.F;
const fsPromises = require("fs").promises;
const snarkjs = require("snarkjs");

const m = merkelize(F, hash, [11, 22, 33, 44, 55, 66, 77, 88], 3);
const root = m[0];
const mp = getMerkleProof(m, 2, 3);

const input = {
    key: F.e(2),
    value: F.e(33),
    root: root,
    siblings: mp
};

const proofOutputPath = process.argv[2];
const publicOutputPath = process.argv[3];
const witnessGenPath = process.argv[4];
const setupPath = process.argv[5];

async function run() {
    const { proof, publicSignals } = await snarkjs.groth16.fullProve(input, witnessGenPath, setupPath);

    const jsonedProof = JSON.stringify(proof, null, 1);
    const jsonedPublic = JSON.stringify(publicSignals, null, 1);

    // console.log(jsonedProof);
    // console.log(jsonedPublic);

    await fsPromises.writeFile(proofOutputPath, jsonedProof, 'utf8', function (err) {
        if (err) {
            console.log("An error occured while writing JSON Object to File.");
            return console.log(err);
        }
    
        console.log("Proof has been saved.");
    });

    await fsPromises.writeFile(publicOutputPath, jsonedPublic, 'utf8', function (err) {
        if (err) {
            console.log("An error occured while writing JSON Object to File.");
            return console.log(err);
        }
    
        console.log("Public file has been saved.");
    });
}

run().then(() => {
    process.exit(0);
});
