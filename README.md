# Zero Knowledge Proof of Membership

*The code is not for production. It's just an academic proof of concept*

## Description
Template for *Proof of Set Membership* on the Ethereum blockchain with zkSNARKs, using Circom and SnarkJS

## Status
- [x] Circuits
- [x] Smart-contract (Verifier)
- [x] Input and witness generator
- [x] Tests
- [x] Usage instruction

___

## Requirements (Rust + Circom + npm) on Ubuntu ^20
```bash
npm install -g npm
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env
git clone https://github.com/iden3/circom.git
cargo build --release
cargo install --path circom
```

## Usage
```bash
git clone git@github.com:curryrasul/pom-template.git && cd pom-template
npm install

node js/inputgen.js ./temp/proof.json ./temp/public.json ./temp/circuit_js/circuit.wasm ./temp/keys.zkey # Write proof to proof.json and publicSignals to public.json

snarkjs groth16 verify temp/verification_key.json temp/public.json temp/proof.json # Proof verification
```

## Local testing
```bash
chmod a+x tests/script.sh
tests/script.sh
```

## Smart - Contract usage/testing
* Deploy [smart-contract](contract/Verifier.sol) through [Remix](https://remix-project.org/) 
* Call verifyProof() with args generated by snarkjs. 

Example:
```bash
snarkjs generatecall temp/public.json temp/proof.json
["0x0ad2a9d8eaa25e9cf807ef95a4fb8c82d3749beeed925c4bfec32e3aa1d1c9d7", "0x0a659f28104f691b59e63328e526f8520630ad8d0a67b032d5376b0173e9b36e"],[["0x0348f16f62ebd201e6924221b4d8f4091b30190197918d51ae4fc8c90521d87d", "0x00c209e4096cd7d1b0edd0c095e11fb493034ade6ba596b85adc12b1e8779520"],["0x26c4c1da532673f86b67c7689fdb8e446005dc742308e237897e29da85732238", "0x0284df53198e33603565973f7e09f330ce0aa2bfad7031cae1f142e66256e4be"]],["0x060f662187a0e668c8b31c5a0b9e5693f0e034deaf910eb345a8c58d22054ad8", "0x26423d6156888d0c625bfc451e6b2f6eae3478e63b4f10c56592e002fb27629f"],["0x29476bed3540082e98941f25c01bdc4df71ce35ca6d3e67787e8495777dd9bd3"]
```

* Copy and paste generated data to the verifyProof() args. If everything's fine, it will return True.