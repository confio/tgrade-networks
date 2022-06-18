If you find this Repo, this is for the Tgrade mainnet preparation. \
We have already assigned external validators for the task and not accepting newcomers. Thank you

# Tgrade - MainNet-1

You can see the live network via our [block explorer](). \
When you are ready to build a node, follow the instructions below:

## Hardware Requirements
For running a tgrade validator. We tested successfully with the following Architecture:

- Ubuntu 20.04 LTS
- go version 1.18.1 [1] or newer
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
The tgrade binary is the backbone of the platform. \
It is both blockchain node and interaction client. Therefore we use git to clone tgrade repo into our running validator
```bash
git clone https://github.com/confio/tgrade
cd tgrade
git checkout v0.10.0-rc2
```

Run GO install and build for the upcoming binary
```bash
make build
```

Move the binary to an executable path
```bash
sudo mv build/tgrade /usr/local/bin
```

At last, Thank you \
As an official announcement, we can start the process at the moment:
- gathering the correct info,
- getting the pre-genesis file ready,
- and submitting a gen tx in a few days.

But we will ask you to recompile the binary once the final version of tgrade 0.10.0 is available.

## Setting up a Genesis Tgrade Validator - PHASE 1
( to be announced ) - within 14.06 - 17.06

### Initialize your genesis and configuration files
Initialize your genesis and configuration files for all validators nodes

Usage:
```bash
tgrade init [moniker] [flags]
tgrade init my-validator --chain-id tgrade-mainnet-1 --home /opt/validator/.tgrade
```

### Import your Validator Key
We already have assigned the genesis validators for the upcoming blockchain. Therefore use the tgrade address YOU provided via Email.

Usage:
```bash
tgrade keys add <name> --recover
tgrade keys add my-validator --recover --home /opt/validator/.tgrade
```

Into the mnemonic(s) used for your tgrade address

### Get the pre-genesis file
Get the genesis file and moved to the right location
```bash
wget https://raw.githubusercontent.com/confio/public-testnets/main/mainnet-1/config/pre-genesis.json -O ~/opt/validator/.tgrade/config/genesis.json
```
( this will be the case if the APP Home directory is /opt/validator/.tgrade , please change it accordingly to your system/validator)

### Setup the right parameters and values on the TOML files
Please edit the `config/app.toml` and `config/config.toml` accordingly

```
- app.toml: set minimum-gas-prices
  minimum-gas-prices = "0.05utgd"

- config.toml: set persistent_peers and other suggested changes
  moniker = "<your validator name>"
  persistent_peers = "387ea7136c50b3849006f3146cc0d96492acc1e9@142.132.226.137:26656,4a319eead699418e974e8eed47c2de6332c3f825@167.235.255.9:26656,6918efd409684d64694cac485dbcc27dfeea4f38@49.12.240.203:26656"
```

## Create genesis txs - PHASE 2

### Collect tendermint node-ids and validator info
You need to know some specifs info for your gen TX
* node-id    ```tgrade tendermint show-node-id```
* Public IP exposed to the Internet

### Create genesis txs
Each validator needs to create a genesis tx, by running:
```bash
tgrade gentx my-validator 0utgd 285000000000utgd \
  --amount 0utgd \
  --vesting-amount 285000000000utgd \
  --fees 10000utgd \
  --moniker my-validator \
  --ip "<public ip>" \
  --node-id $(sudo tgrade tendermint show-node-id --home /opt/validator/.tgrade) \
  --chain-id tgrade-mainnet-1 \
  --home /opt/validator/.tgrade
```
vesting-amount, node-id, and home values are just examples, please change it accordingly to your system/validator

### Upload your Gen_TX
The above will create a gentx file. We are going to need it for the genesis collect.
1. Fork the repo: https://github.com/confio/public-testnets , clicking on fork, and choose your account
2. Clone your fork copy to your local machine
3. Copy the gentx file into `../mainnet-1/config/gentx/`
4. Commit and push the repo
5. Create a pull request from your fork to the main repo
6. Inform us on the discord channel

```bash
git clone https://github.com/<your_github_username>/public-testnets
cd public-testnets
git add public-testnets/mainnet-1/config/gentx/
git commit -am "<your validator name> - gentx - comment"
git push origin master
```

## Start your Validator - PHASE 3
( to be announced ) - within 22.06 - 24.06

