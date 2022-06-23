pragma circom 2.0.0;
include "./merkle.circom";

component main { public [root] } = Mkt2Verifier(3);
