pragma circom 2.0.0;
include "../circuits/merkle.circom";

component main { public [root] } = Mkt2Verifier(3);
