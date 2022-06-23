pragma circom 2.0.0;
include "./merkle.circom";

// "Main" function, that initialize Circuit, where Merkle Root is public input
component main { public [root] } = Mkt2Verifier(3);
