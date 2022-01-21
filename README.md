# Announcement

The network's goals have far exceeded our expectations, and we have reached the **limit of 100 validators** set in the Genesis file.🎉
No more can join. 
- [Reference](https://twitter.com/TgradeFinance/status/1483063414570328072)

# Tgrade - Testnet-3

You can see the live network via our [block explorer](https://testnet.tgrade.aneka.io) or [Tgrade application](https://try.tgrade.finance).
When you are ready to build a node, follow the instructions below:

* [Hardware Requirements](#hardware-requirements)
* [Build the tgrade binary](#build-the-tgrade-binary)
* [How to join the public testnet](#how-to-join-the-public-testnet)

## Hardware Requirements
For running a tgrade validator. We tested successfully with the following Architecture:

- Ubuntu 20.04 LTS
- go version 1.17.4 [1] or newer
- Installed packages make and build-essential [2] [3]
- 2 or more CPU cores Intel or AMD chipset
- At least 40GB of disk storage
- At least 4GB of memory (RAM)

Ref - \
[1] https://github.com/golang/go/wiki/Ubuntu \
[2] https://packages.ubuntu.com/focal/make \
[3] https://packages.ubuntu.com/focal/build-essential

You can use a physical infrastructure (baremetal) or wellknown cloud providers like: DigitalOcean, AWS, Google Cloud Platform, among others

## Build the tgrade binary
The tgrade binary is the backbone of the platform. It is both blockchain node and interaction client. Therefore we use git to clone tgrade repo into our running validator
```bash
git clone https://github.com/confio/tgrade
cd tgrade
git checkout v0.5.1
```

Run GO install and build for the upcoming binary
```bash
make build
```

Move the binary to an executable path
```bash
sudo mv build/tgrade /usr/local/bin
```

## How to join the public testnet

### Initialize your genesis and configuration files
Initialize your genesis and configuration files for all validators nodes

Usage:
```bash
tgrade init [moniker] [flags]
tgrade init my-validator --chain-id tgrade-testnet-3 --home /mnt/data/.tgrade
```

### Create validators addresses/keys
Generated new addresses/keys for the validators

Usage:
```bash
tgrade keys add <name> [flags]
tgrade keys add my-validator --home /mnt/data/.tgrade
```

Gathering the mnemonic(s) and save it(them) in a safe place

### Setup the right parameters and values on the TOML files
Please edit the `config/app.toml` and `config/config.toml` accordingly

```
- app.toml: set minimum-gas-prices
  minimum-gas-prices = "0.05utgd"

- config.toml: set persistent_peers and other suggested changes
  moniker = "<your validator name>"
  persistent_peers = "604fd705a28d7abd903a813e2a1bfdb631f7b713@65.108.167.158:26656,abe2378e5053e8b9dd3a22691b4cb54ff8303004@65.108.167.160:26656,19cc3229b361d2c684dc89c3938c65d2dc67d063@116.203.251.45:26656"
```
Recommended, We have a few volunteers as seed nodes located in London, Singapore, East Coast US and elsewhere
You could add the to your persistent_peers parameter
```
95e7eba78b895763ba53198f0019820a77aec28f@178.128.169.146:26656
0936197ae12be2a23114dbd32296c790c0bea405@206.189.85.24:26656
fe0682fbe72af8193676cb0cb41adfe94a551e72@5.161.64.239:26656
b00f8de43d515d9b966f0758ebfa22fb1d98a977@137.184.105.178:26656
```

### Get the lastest genesis file
Get the genesis file and moved to the right location
```bash
wget https://raw.githubusercontent.com/confio/public-testnets/main/testnet-3/config/genesis.json -O ~/.tgrade/config/genesis.json
```
( this will be the case the APP Home directory is ~/.tgrade , please change it accordingly to your system/validator)

### Start the syncing
There are different ways to manage the tgrade binary on your validator,
1. Setting up such binary to be managed by systemd, or
2. Open a tmux or screen session and run tgrade start

The synstax is:
```bash
tgrade start --rpc.laddr tcp://127.0.0.1:26657
```
( or just tgrade start )

if you are using a docker container: **--rpc.laddr tcp://0.0.0.0:26657**

### Get some tokens
You can get tokens by login for first time into the Tgrade WebApp: [Tgrade application](https://try.tgrade.finance), or on the discord channel: [testnet-3-faucet](https://discord.com/channels/844486286445903872/875001092495269938)

### Upgrade to a validator
Once your validator is in sync with the current height and blockchain_db, you can upgrade to be an active validator in the blockchain
```bash
tgrade tx poe create-validator \
  --amount 5000000utgd \
  --from <validator-address> \
  --pubkey $(tgrade tendermint show-validator)  \
  --chain-id tgrade-testnet-3 \
  --moniker "<your-validator-name>" \
  --fees 15000utgd \
  --node https://rpc.testnet-3.tgrade.io:443
```

Wait for a few blocks to be validate and your validator will appears as active in the block-explorer:
https://testnet.tgrade.aneka.io/

### ( Optional 1 )
If you want to delegate an amount of liquid coins from your wallet to a validator:
```bash
tgrade tx poe self-delegate 5000000000utgd \
  --from <validator-address> \
  --chain-id tgrade-testnet-3 \
  --fees 15000utgd \
  --node https://rpc.testnet-3.tgrade.io:443
```

### ( Optional 2 )
If you decided to managed the tgrade binary by a systemd service file, please find an the example below:
```bash
[Unit]
Description=tgrade blockchain
Wants=network-online.target
After=network-online.target

[Service]
TimeoutStartSec=5
Restart=always
User=root
Group=root
ExecStart=/usr/local/bin/tgrade start --rpc.laddr tcp://0.0.0.0:26657

[Install]
WantedBy=multi-user.target
```

