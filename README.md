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

## Requirements (Rust + Circom)
```bash
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env
git clone https://github.com/iden3/circom.git
cargo build --release
cargo install --path circom
```

## Usage
```bash
git clone git@github.com:curryrasul/pom-template.git
npm install
```
