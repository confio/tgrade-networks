# tgrade-patchnet-1

- Chain ID: tgrade-patchnet-1
- app: tgrade
- version: "v0.7.0" commit ce773d2bdb02c8becd5fc63563471a88d390121b 
- Staking, Fee token: utgd
- Min Fee: 0.05utgd
- Date Deployed: 2022-02-22T16:00:01Z

# Endpoints

- RPC: https://rpc.patchnet-1.tgrade.io/
- REST (former LCD): https://lcd.patchnet-1.tgrade.io/
- Aneka Block-Explorer: https://patchnet.aneka.io/


## Hardware Requirements

For running a tgrade validator. We tested successfully with the following Architecture:

- Ubuntu 20.04 LTS
- go version 1.17.7 [1] or newer
- Installed packages make and build-essential [2] [3]
- 2 or more CPU cores Intel or AMD chipset
- At least 40GB of disk storage
- At least 4GB of memory (RAM)

Ref - \
[1] https://github.com/golang/go/wiki/Ubuntu \
[2] https://packages.ubuntu.com/focal/make \
[3] https://packages.ubuntu.com/focal/build-essential

You can use a physical infrastructure (baremetal) or wellknown cloud providers like: DigitalOcean, AWS, Google Cloud Platform, among others


## Tgrade versions

The current blockchain `tgrade-patchnet-1` started with version `v0.6.2`, and on block-heights `219999-220000`, we swapped to `v0.7.0`.  
Therefore, in order to sync your validator you need to conduct the syncronization process in 2 stages, first with the older version and later with version `v0.7.0`


## Build the tgrade binary

The tgrade binary is the backbone of the platform. It is both blockchain node and interaction client.  
Therefore we use git to clone tgrade repo into our running validator
```bash
git clone https://github.com/confio/tgrade
cd tgrade
git checkout v0.6.2
```

Run GO install and build for the upcoming binary
```bash
make build
```

Move the binary to an executable path
```bash
sudo mv build/tgrade /usr/local/bin
```

## Setting up a Genesis Tgrade Validator

### Initialize your genesis and configuration files
Initialize your genesis and configuration files for all validators nodes

Usage:
```bash
tgrade init [moniker] [flags]
tgrade init my-validator --chain-id tgrade-patchnet-1 --home /opt/validator/.tgrade
```

### Create validators addresses/keys
Generated new addresses/keys for the validators

Usage:
```bash
tgrade keys add <name> [flags]
tgrade keys add my-validator --home /opt/validator/.tgrade
```

Gathering the mnemonic(s) and save it(them) in a safe place

### Setup the right parameters and values on the TOML files
Please edit the `config/app.toml` and `config/config.toml` accordingly

```
- app.toml: set minimum-gas-prices
  minimum-gas-prices = "0.05utgd"

- config.toml: set persistent_peers and other suggested changes
  moniker = "<your validator name>"
  persistent_peers = "4c9d298d06e33360afd3d35cabe6519a19f90059@142.132.235.202:26656,50328b10a7c9911fe20ae141ad916161f3743c0c@142.132.235.203:26656,dfe718f7235e663e74bf23c67193d2fa29e8e59a@142.132.226.241:26656"
```
### Get the latest genesis file
Get the genesis file and moved to the right location
```bash
wget http://142.132.226.240/genesis.json -O ~/opt/validator/.tgrade/config/genesis.json
```
( this will be the case the APP Home directory is /opt/validator/.tgrade , please change it accordingly to your system/validator)

### Start the syncing
As mentioned above, we start to sync with version `v0.6.2` and stop at `219999`

**stage 1**
We wait till it reaches block `219999` it will output as error and/or with a message saying instructed to stop
The synstax is:
```bash
tgrade start --rpc.laddr tcp://0.0.0.0:26657 --halt-height 219999
```

**stage 2**
We build a new tgrade binary, now with tag `v0.7.0`
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

Verify
```bash
tgrade version
```

Now, restart the process
```bash
tgrade start --rpc.laddr tcp://0.0.0.0:26657
```

**NOTE**
There are different ways to manage the tgrade binary on your validator,
1. Setting up such binary to be managed by systemd, or
2. Open a tmux or screen session and run tgrade start

### Get some tokens
You can get tokens by login for first time into the Tgrade WebApp:  
1. [Tgrade application](https://try.tgrade.finance),
2. or ask on the discord channel: [core-validators](https://discord.com/channels/844486286445903872/849315687843233792)

### Upgrade to a validator
Once your validator is in sync with the current height and blockchain_db, you can upgrade to be an active validator in the blockchain.  

First, in case you don't have engagement points previosly assigned, you need to ask for a Proposal to the Oversight Community for `Grant Engagement Points`  
Second, when the first condition is done, you run the following command syntax:
```bash
tgrade tx poe create-validator \
  --amount 5000000utgd \
  --from <validator-address> \
  --pubkey $(tgrade tendermint show-validator) \
  --chain-id tgrade-patchnet-1 \
  --moniker "<your-validator-name>" \
  --fees 10000utgd \
  --node https://rpc.patchnet-1.tgrade.io:443
```

Wait for a few blocks to be validate and your validator will appears as active in the block-explorer:
https://patchnet.aneka.io/

### ( Optional 1 )
If you want to delegate an amount of liquid coins from your wallet to a validator:
```bash
tgrade tx poe self-delegate 5000000000utgd \
  --from <validator-address> \
  --chain-id tgrade-patchnet-1 \
  --fees 10000utgd \
  --node https://rpc.patchnet-1.tgrade.io:443
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

