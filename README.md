# x1eco-amm-dex

Experimental AMM-based decentralized exchange built on X1 EcoChain testnet featuring ERC20 token swaps, liquidity pools, and USDZ stablecoin infrastructure.

---

## Contracts

### USDZ.sol

Contract Address: 0xA23B64498B1Dd0fAC3f5249c62Ecf4491dB76BB1

ERC20 stablecoin contract used for DEX liquidity and swap testing.

Features:
- OpenZeppelin ERC20
- Fixed supply
- Burn function
- DEX-compatible approvals

---

### MiniSwapDEXV1.sol

Contract Address: 0x8CDB37A2729b8546a7D941de765291dEdEd76641

Basic Automated Market Maker (AMM) decentralized exchange contract.

Features:
- ERC20 ↔ ERC20 swaps
- Liquidity pools
- Reserve tracking
- Dynamic AMM pricing
- Add/remove liquidity

---

## Ecosystem Architecture

EcoTokenV2
      ↕
 MiniSwapDEXV1
      ↕
     USDZ

---

## AMM Formula

The DEX uses a simplified constant-product AMM model:

x * y = k

Where:
- x = ECO reserve
- y = USDZ reserve
- k = constant liquidity product

---

## Tested Features

- Token approvals
- transferFrom mechanics
- Liquidity deposits
- Token swaps
- Dynamic reserve updates
- Price calculation

---

## Network

Built and tested on X1 EcoChain testnet.

---

## License

MIT
