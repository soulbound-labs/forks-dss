## Foundry

## Dev env
* DAI is a system of smart conrtracts tha allow you to draw stablecoins against a Collateralized Debt Position (CDP). To mint Dai, you need the following core DSS contracts:
  * Vat: The core accounting contract that tracks collateral and debt.
  * Dai: The ERC-20 token representing Dai.
  * DaiJoin: An adapter to move Dai between the Vat (internal accounting) and the Dai token (external ERC-20).
  * GemJoin: An adapter to lock collateral (e.g., ETH) into the Vat
  * Jug: Manages stability fees for collateral types
  * Vow: Handles system surplus and debt
  * Spotter: Provides price feeds for collateral (via an oracle)
  * End: Handles system shutdown (optional for local testing but included for completeness)
  * Collateral (ETH): For local testing, we’ll use ETH as collateral, which doesn’t require a separate token contract since Anvil supports native ETH.

```shell
# build contracts
forge build

# Set env vars in .env; check version controlled .env.local to see necessary vars
touch .env

# Deploy to anvil instance
forge script script/deploy.s.sol --rpc-url http://localhost:8545 --broadcast -vvv

# mint DAI
cast send <DAI_CONTRACT_ADDRESS> "mint(address,uint256)" <RECEIVER> "1000000000000000000000" --private-key <DEPLOYER_PRIVATE_KEY>
```


**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
