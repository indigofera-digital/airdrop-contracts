# Gamified Quiz Contracts
---
The game stores quiz airdrops on the blockchain. 

This will use:
* [Solidity](https://docs.soliditylang.org/)
* [Foundry](https://github.com/foundry-rs/foundry)

---
```
# Start new Foundry project
❯ forge init airdrop-smartcontracts

# Run tests
❯ forge test -vv

# Install dependencies
❯ forge install openzeppelin/openzeppelin-contracts

# Build
❯ forge build

# To deploy and verify contract
❯ forge script script/NFT.s.sol:MyScript --rpc-url $RPC_URL  --private-key $PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_KEY -vvvv
```

### Notes
---

Put `remappings = ['@ds-test=lib/ds-test/src/','@openzeppelin=lib/openzeppelin-contracts/', '@chainlink=lib/chainlink/']` into `foundry.toml` for imports.

Create your `.env`:
```
RPC_URL=
PRIVATE_KEY=
ETHERSCAN_KEY=
```

