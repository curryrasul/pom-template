# Proof of set membership template with zkSNARKs

## Description
We want to prove membership in defined set of people without revealing any information about us.

- [] CLI
- [] Smart-contract

## How that works
Implemented in Rust, it works using Groth16 proving system (arkworks-rs/groth16). Verifier implemented as a smart-contract on NEAR Protocol; proofs can be generated using CLI.

---
