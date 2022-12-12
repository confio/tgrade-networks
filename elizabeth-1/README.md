# Tgrade: elizabeth-1 Testnet

Elizabeth-1 is our long term testnet.  It is an enviroment for the community to build and test their Trusted Circle and applications on.

## Hardware Requirements
For running a tgrade validator. We tested successfully with the following Architecture:

- Ubuntu 20.04 LTS
- go version 1.19.1 [1] or newer
- Installed packages make and build-essential [2] [3]
- 2 or more CPU cores Intel or AMD chipset
- At least 40GB of disk storage
- At least 4GB of memory (RAM)

## Prerequists

Update Go to a recent version 

```
sudo rm -rf /usr/local/go && cd ~/ && \
sudo wget https://go.dev/dl/go1.19.1.linux-amd64.tar.gz && \
sudo tar -C /usr/local -xvf go1.19.1.linux-amd64.tar.gz && \
sudo chown -R $USER:$USER /usr/local/go && rm -f go1.19.1.linux-amd64.tar.gz
```
Add the following to the end of your `.bashrc` and run

```
nano ~/.bashrc
```
```
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export GO111MODULE=on
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
```
```
source .bashrc
```

## Build the tgrade binary
The tgrade binary is the backbone of the platform. 
```
cd ~
git clone https://github.com/confio/tgrade
cd tgrade
git checkout v2.0.2
make build
```

Move the binary to an executable path
```
sudo mv build/tgrade /usr/bin
```
Check that you have the right `tgrade` version installed
```
tgrade version --long
```
This should return:
```
name: tgrade
server_name: tgrade
version: 2.0.2
commit: a990225d4b92f09d7b6fad3d6147d71c3711ece4
build_tags: netgo,ledger
go: go version go1.19.1 linux/amd64
```

## Setting up a Testnet Tgrade Validator

### Initialize your genesis and configuration files
Initialize your genesis and configuration files for your validator node

```
tgrade tendermint unsafe-reset-all --home $HOME/.tgrade
tgrade init "<NAME_OF_MY_VALIDATOR>" --chain-id elizabeth-1
```

#### Get the genesis file ####
```
cd $HOME/.tgrade/config
rm genesis.json
wget https://github.com/lightiv/tgrade/raw/main/Elizabeth-1/genesis.json -O ~/.tgrade/config/genesis.json
```

Verify Genesis sha256 hash
```
sha256sum "${HOME}/.tgrade/config/genesis.json"
# cd9501ec12e001ecaa4659f7e67b30ad48d0d4f96e95e2c3bea7f334690ed6a4
```

Create an Address
```
tgrade keys add <KEY_NAME> 
```

If using a Ledger Nano (Very much optional for testnet)
```
tgrade keys add <KEY_NAME> --ledger
```
## ***It is critical that you stop now and backup the mnemonic just created.*** ##  
  
This is the only way to recover your validator key/address.  Additionally you need to back up the following files now.  
This is your validator's identity.  
```
$HOME/.tgrade/config/node_key.json (Not mandatory.)
$HOME/.tgrade/config/priv_validator_key.json **(Critical!!!)**
```

### Starting Your Full Node  

Add peers to the `persistent_peers =` in .tgrade/config/config.toml.  You can find those here:  
  
https://github.com/lightiv/tgrade/raw/main/Elizabeth-1/peers.txt

```
nano .tgrade/config/config.toml
```
**Open the p2p firewall port for optimal network performance**
```
sudo ufw allow from any to any port 26656 [<- or custom port] proto tcp
```

Create a service to run tgrade
```
sudo nano /lib/systemd/system/tgrade.service
```
Add the following
```
Description=Tgrade daemon
After=network-online.target

[Service]
User=$USER
ExecStart=/usr/bin/tgrade start
Restart=on-failure
RestartSec=3
LimitNOFILE=4096

[Install]
WantedBy=multi-user.target
```
Enable, start, and monitor the service
```
sudo systemctl enable tgrade
sudo systemctl restart tgrade; sudo journalctl --no-hostname -fu tgrade -o cat
```  

## Starting Your Node With Cosmovisor
Set up cosmovisor to ensure any future upgrades happen flawlessly. To install Cosmovisor:
```
go install github.com/cosmos/cosmos-sdk/cosmovisor/cmd/cosmovisor@v1.0.0
```
Create the required directories:
```
mkdir -p ~/.tgrade/cosmovisor
mkdir -p ~/.tgrade/cosmovisor/genesis
mkdir -p ~/.tgrade/cosmovisor/genesis/bin
mkdir -p ~/.tgrade/cosmovisor/upgrades
```
Set the environment variables:
```
echo "# Setup Cosmovisor" >> ~/.profile
echo "export DAEMON_NAME=tgrade" >> ~/.profile
echo "export DAEMON_HOME=$HOME/.tgrade" >> ~/.profile
echo "export DAEMON_ALLOW_DOWNLOAD_BINARIES=false" >> ~/.profile
echo "export DAEMON_LOG_BUFFER_SIZE=512" >> ~/.profile
echo "export DAEMON_RESTART_AFTER_UPGRADE=true" >> ~/.profile
echo "export UNSAFE_SKIP_BACKUP=true" >> ~/.profile
source ~/.profile
```
You may leave out UNSAFE_SKIP_BACKUP=true, however the backup takes a decent amount of time and public snapshots of old states are available.

Copy the current `tgrade` binary into the cosmovisor/genesis folder:
```
cp $GOPATH/bin/tgrade ~/.tgrade/cosmovisor/genesis/bin
```
To check your work, ensure the version of `cosmovisor` and `tgrade` are the same:
```
cosmovisor version
tgrade version
```
#### If all goes well you should be syncing.  *Allow the node to fully sync:*

## Create Your Validator

Get Tokens:

Visit the Discord Faucet `elizabeth-1-faucet` channel and receive 10 utgd:
```
$request tgrade1...<your validator address>
```

Verify you received tokens:
```
$balance tgrade1...<your validator address>
```
You should see the follow in the faucet channel:
```
{
  "denom": "utgd",
  "amount": "10000000"
}
```

Create the validator:

```
tgrade tx staking create-validator -o text \
  --amount=9000000utgd \
  --pubkey=$(tgrade tendermint show-validator) \
  --moniker="<VALIDATOR_NAME>" \
  --chain-id=elizabeth-1 \
  --commission-rate="0.10" \
  --commission-max-rate="0.20" \
  --commission-max-change-rate="0.01" \
  --min-self-delegation="1" \
  --fees 5000utgd \
  --from=skynet \
  --details="<DESCRIPTION_OF_YOUR_ORGANIZATION" \ <- OPTIONAL***
  --security-contact="<SECURITY_CONTACT_EMAIL_ADDRESS" \ <- OPTIONAL***
  --website="<YOUR_WEBSIT" \  <- OPTIONAL***
  --identity=<YOUR_KEYBASE_ID>  <- OPTIONAL***

```  

