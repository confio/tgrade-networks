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
wget https://raw.githubusercontent.com/confio/public-testnets/main/testnet-4/config/pre-genesis.json -O ~/opt/validator/.tgrade/config/genesis.json
```
( this will be the case the APP Home directory is /opt/validator/.tgrade , please change it accordingly to your system/validator)

### Create genesis txs
On each validator we need to create a genesis tx, by running:
```bash
tgrade gentx my-validatpr 1000000000utgd \
  --chain-id tgrade-testnet-4 \
  --ip <public_ip> 
  --moniker my-validator 
  --node-id b285e300e5bc66fc369f8676cfb6aa92bd6dd354 \
  --pubkey tgradevalconspub1zcjduepqz4y6jj7495parjq3q7jnne4yglptkh3y4dmpxku9rr705723kqcqlvdt4d \
```
node-id and pubkey vaues are just examples, please change it accordingly to your system/validator

Once this is done we can suggest the genesis validators to upload their gentx to a github repo and comminicate this via discord 

### Run Collect gentx ( This is going to be from our end )
We gather all the genesis txs and run:
```bash
tgrade collect-gentxs --home ~/opt/validator/.tgrade
```
It will create the final version of the genesis file to be used on the netwrok

### Get the final genesis file
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

