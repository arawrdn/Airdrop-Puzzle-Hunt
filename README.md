# Airdrop Puzzle / Hunt

## Overview
Interactive on-chain airdrop game where users claim rewards using secret codes.  
Owner can deposit reward pool and add more codes anytime.

## How to Use
1. Deploy `CodeAirdrop.sol` on Remix (Solidity 0.8.30+).  
2. Owner deposits ETH into the contract using `deposit()` or directly sending ETH.  
3. User claims reward by calling `claimCode("CODE")` with one of the valid codes.  
4. Reward distribution: 90% user, 10% owner.  
5. Each user can claim only once.  

## Initial Codes (Example)
solana
celo
base
bitcoin
trivia
blackmail
lewis
apple
lock
marine
aero
hope
red
flower
sun

# User manually write code Using (") Example "solana" and then Claim.


## Features
- Owner can add more codes.  
- User interaction: claim reward via code.  
- Fully on-chain, no external libraries.  
- Reward pool deposited manually by owner.  

