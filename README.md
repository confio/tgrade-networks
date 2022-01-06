# Tgrade - Testnet-3

## Hardware Requirements
For running a tgrade validator. We tested successfully with the following Architecture:

- Ubuntu 20.04 LTS
- go version 1.17.4 [1] or newer
- Installed packages make and build-essential [2] [3]
- 2 or more CPU cores Intel or AMD chipset
- At least 40GB of disk storage
- At least 4GB of memory (RAM)

Ref -
[1] https://github.com/golang/go/wiki/Ubuntu \
[2] https://packages.ubuntu.com/focal/make \
[3] https://packages.ubuntu.com/focal/build-essential \

You can use a physical infrastructure (baremetal) or wellknown cloud providers like: DigitalOcean, AWS, Google Cloud Platform, among others

## Build the tgrade binary
The tgrade binary is the backbone of the platform. It is both blockchain node and interaction client. Therefore we use git to clone tgrade repo into our running validator
```bash
git clone https://github.com/confio/tgrade.git
cd tgrade
git tag ( and search for the latest stable release )
git checkout [latest version]
```

Run GO install for the upcoming binary
```bash
make install
```

Build the binary
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
Please edit the app/toml and config.toml accordingly
```
- app.toml: set minimum-gas-prices
  minimum-gas-prices = "0.05utgd”

- config.toml: set persistent_peers and other suggested changes
  moniker = “<your validator name>”
  persistent_peers = “604fd705a28d7abd903a813e2a1bfdb631f7b713@65.108.167.158:26656,abe2378e5053e8b9dd3a22691b4cb54ff8303004@65.108.167.160:26656”
```

### Get the lastest genesis file
