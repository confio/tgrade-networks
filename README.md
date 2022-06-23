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
git checkout v1.0.0
```

Run GO install and build for the upcoming binary
```bash
make build
```

Move the binary to an executable path
```bash
sudo mv build/tgrade /usr/local/bin
```

## Setting up a Genesis Tgrade Validator - PHASE 1

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
wget https://raw.githubusercontent.com/confio/tgrade-networks/main/mainnet-1/config/pre-genesis.json -O ~/opt/validator/.tgrade/config/genesis.json
```
( this will be the case if the APP Home directory is /opt/validator/.tgrade , please change it accordingly to your system/validator)

### Setup the right parameters and values on the TOML files
Please edit the `config/app.toml` and `config/config.toml` accordingly

```
- app.toml: set minimum-gas-prices
  minimum-gas-prices = "0.05utgd"

- config.toml: set persistent_peers and other suggested changes
  moniker = "<your validator name>"
  persistent_peers = "0a63421f67d02e7fb823ea6d6ceb8acf758df24d@142.132.226.137:26656,4a319eead699418e974e8eed47c2de6332c3f825@167.235.255.9:26656,6918efd409684d64694cac485dbcc27dfeea4f38@49.12.240.203:26656"
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
1. Fork the repo: https://github.com/confio/tgrade-networks , clicking on fork, and choose your account
2. Clone your fork copy to your local machine
3. Copy the gentx file into `../mainnet-1/config/gentx/`
4. Commit and push the repo
5. Create a pull request from your fork to the main repo
6. Inform us on the discord channel

```bash
git clone https://github.com/<your_github_username>/tgrade-networks
cd tgrade-networks
git add tgrade-networks/mainnet-1/config/gentx/
git commit -am "<your validator name> - gentx - comment"
git push origin master
```

## Start your Validator - PHASE 3

### Recap
As mentioned before:
1. Recompile the tgrade binary again. This time using the latest stable version [v1.0.0](#build-the-tgrade-binary)
2. Review and do the necessary changes for the first [persistent_peer](#setup-the-right-parameters-and-values-on-the-toml-files)

### Get the final genesis file

Get the genesis file and moved to the right location
```bash
wget https://raw.githubusercontent.com/confio/tgrade-networks/main/mainnet-1/config/genesis.json -O ~/.tgrade/config/genesis.json
```
( this will be the case if the APP Home directory is ~/.tgrade , please change it accordingly to your system/validator)

### Start the syncing
There are different ways to manage the tgrade binary on your validator,
1. Setting up such binary to be managed by systemd, or
2. Open a tmux or screen session and run tgrade start

The syntax is:
```bash
tgrade start --rpc.laddr tcp://0.0.0.0:26657 --home /opt/validator/.tgrade
```
( this will be the case if the APP Home directory is /opt/validator/.tgrade , please change it accordingly to your system/validator)

## Upgrade to a validator after Genesis - PHASE 4 ( Optional )

### Upgrade to a validator
Once your validator is in sync with the current height and blockchain_db, you can upgrade to be an active validator in the blockchain.

If you don't have engagement points previosly assigned, you need to ask for a Proposal to the Oversight Community for `Grant Engagement Points` \
and when the above condition is completed, you run the following command syntax:
```bash
tgrade tx poe create-validator \
  --amount 0utgd \
  --vesting-amount 900000000utgd \
  --from <validator-address> \
  --pubkey $(tgrade tendermint show-validator) \
  --chain-id tgrade-mainnet-1 \
  --moniker "<your-validator-name>" \
  --fees 20000utgd \
  --node https://rpc.mainnet-1.tgrade.confio.run:443
```

Wait for a few blocks to be validate and your validator will appears as active in the block-explorer:
( soon to be available )

### ( Optional )
If you want to delegate an amount of liquid and/or vesting coins from your wallet to a validator:
```bash
tgrade tx poe self-delegate 100000000utgd 900000000utgd \
  --from <validator-address> \
  --chain-id tgrade-mainnet-1 \
  --fees 10000utgd \
  --node https://rpc.mainnet-1.tgrade.confio.run:443


