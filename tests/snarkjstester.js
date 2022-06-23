const snarkjs = require("snarkjs");
const fs = require("fs");
const chai = require("chai");
const assert = chai.assert;

const vKeyPath = process.argv[3];
const proofPath = process.argv[4];
const publicPath = process.argv[5];

describe("SnarkJS tester", function() {
    this.timeout(1000);

    it("It should test final SnarkJS evaluation", async () => {
        const vKey = JSON.parse(fs.readFileSync(vKeyPath));
        const proof = JSON.parse(fs.readFileSync(proofPath));
        const publicSignals = JSON.parse(fs.readFileSync(publicPath));

        const res = await snarkjs.groth16.verify(vKey, publicSignals, proof);

        await assert(res);
    });
});
