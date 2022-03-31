# Tgrade - Spotnet

You can see the live network via our [block explorer](https://testnet.tgrade.aneka.io) or [Tgrade application](https://try.tgrade.finance).
When you are ready to build a node, follow the instructions below:

## Hardware Requirements
For running a tgrade validator. We tested successfully with the following Architecture:

- Ubuntu 20.04 LTS
- go version 1.18 [1] or newer
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
git checkout v0.7.0
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
tgrade init my-validator --chain-id tgrade-testnet-4 --home /opt/validator/.tgrade
```

### Import your Validator Key
We already have assigned a few external validators from this task. Therefore use the tgrade address YOU provided on the `\#spotnet-validators`

Usage:
```bash
tgrade keys add <name> --recover
tgrade keys add my-validator --recover --home /opt/validator/.tgrade
```

Gathering the mnemonic(s) and save it(them) in a safe place

### Get the pre-genesis file
Get the genesis file and moved to the right location
```bash
wget https://raw.githubusercontent.com/confio/public-testnets/main/spotnet/config/pre-genesis.json -O ~/opt/validator/.tgrade/config/genesis.json
```
( this will be the case the APP Home directory is /opt/validator/.tgrade , please change it accordingly to your system/validator)

## Create genesis txs - PHASE 2

### Collect tendermint node-ids and validator info
We need to collect from the genesis validators:
* node-id    ```tgrade tendermint show-node-id```
* pubkey     ```tgrade tendermint show-validator```
* IP and port to be used

### Create genesis txs
On each validator we need to create a genesis tx, by running:
```bash
tgrade gentx my-validator 1000000000utgd \
  --chain-id tgrade-spotnet \
  --ip <public_ip> 
  --moniker my-validator \
  --node-id $(tgrade tendermint show-node-id) \
  --home /opt/validator/.tgrade
```
node-idm pubkey and home values are just examples, please change it accordingly to your system/validator

### Upload your Gen_TX
The above will create a gentx file. We are going to need it for the genesis collect.
1. Clone the public-testnets repo.
2. Copy the gentx file into `../spotnet/config/gentx/`
3. Commit and push the repo
4. Create a pull request
5. Inform us on the discord channel

```bash
git clone https://github.com/confio/public-testnets.git
cd public-testnets
git add public-testnets/spotnet/config/gentx/
git push origin master
```

## PHASE 3


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

