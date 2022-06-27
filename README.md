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
  seeds = "0c3b7d5a4253216de01b8642261d4e1e76aee9d8@45.76.202.195:26656,1e1fc55291968f97b7c9016ebd244fa186050a6f@138.201.16.60:26656"
  persistent_peers = "0a63421f67d02e7fb823ea6d6ceb8acf758df24d@142.132.226.137:26656,4a319eead699418e974e8eed47c2de6332c3f825@167.235.255.9:26656,6918efd409684d64694cac485dbcc27dfeea4f38@49.12.240.203:26656"
```

### Adding extra persistent_peers for the beginning of the network ( Optional )
This is Optional, but very important for a smooth seed phase, you could add an extra list of persisten_peers including the official published above.
At the moment with have: ( if you find your validator in here, please omit your entry node-id@ip:port , where? just locally in your validator/system )
```
00c89c4c75ee272180f7d607e3e6632b3724349c@139.59.106.241:26656,09deda8a085c0513df276484b7505d698f49aeab@162.55.133.237:26656,0ecff7b4ca77fc15aa6f4736b0a237a2e87e8e5b@104.248.203.84:26656,2602fe3ebdca818024b2764d2d531d956f49a9b3@18.119.139.116:26656,2df762919720bca5f46042f77148de73c06049d8@161.97.147.148:26656,2fd4c9c027f29f99636f2434c8fd151d22a22787@88.99.243.241:26656,30bf9c7f134039526e33dc982d9a49584efc332e@104.149.139.170:26656,32e439375102eddb4ee44bffa0ae7765fec2a7a9@142.132.151.35:26656,33ed5ffc8ae453f07e2e14f6ae6a53f8c90fc03f@168.119.89.31:26656,355032c24928789a58fcfe1c403fc6965c3f35ce@199.115.119.232:26656,37c217073b9161180999ea89c38fc31c354bac0b@89.58.45.83:26656,3aee9fd460b687a5622b6c2e3c5067eb221f8f8d@5.9.88.252:26656,4bd4fb232f83c32ea58d68e9a2ec6eb4c643f4bd@164.92.121.127:26656,54c7802af1a32ba9f15a0c95e792cfb344af05d9@20.223.155.236:26656,55627c14b5419a7cf942711d35dbd4d9efe5d048@65.21.199.148:26656,5c189bb73ae43a6fee13794d5833f131c227985c@35.182.104.45:26656,5e5fa8724e0b4061849a1c0733226250c80830ff@13.57.222.49:26656,6270fd07c1deec6da08f0e88bc14b0dead35700b@62.171.137.163:26656,71f3af6f19afb33e2728bc2f26babc2e7cf01bd9@146.19.24.163:26656,7383b50b4db8634be6a94fdb033e58e250d0745d@161.35.124.144:26656,783b62e8782c2102fc379a6f42c4a7aeed0c7175@54.197.151.167:26656,7bb53cdbc6dba7f23219ba3166db86ad184bfd7d@54.212.93.102:26656,825d6a7d2d3a41006d18a292aa593a30e6f632ba@45.56.117.254:26656,845bfae805eafd35ac18b774c5a085dac7922d94@146.59.81.204:26656,96f19f78beaa02b0b4c490a22c393568e8677bf7@78.47.88.58:26656,9b0a22a0303de39d1fc5e3acb4af46a8c30d139f@185.182.187.80:26656,a261b544ec5486d0c9af618e0a7f9d54e75d6148@195.201.197.168:26656,a51fee7392e189083cf6d741ec6ea0abf83d20c3@213.239.204.104:26656,a74ad2288a872a0f9848d6ec6af44014660cc93b@5.161.134.184:26656,a97207e8546552c457485953ccc0596c5292f9d3@167.99.24.122:26656,ae4cfb8e52f4f3d6e08557506c85c2984367d23e@173.212.229.120:26656,b138159552389dc9f34b6c96539668a109c4444e@185.182.186.192:26656,b1c83b39f6903b5c35ca0f3b5c87adb0e9119d39@168.119.15.254:26656,b5f8e7d87b9a2d74e61d40c6fdd935bef06a825f@54.199.171.19:26656,b5ff1acf52a3e4cda6bf54651a897aa503453120@65.108.199.26:26656,beeb51ffc526857b8a3c2d977b83bcae04109491@80.64.208.105:26656,bf4314963280c0ccbf6f986a72a2f1adf5e1806d@144.76.19.103:26656,c5107e3b96601b8aff750562961e096221f8bc40@3.137.136.10:26656,c5d22968ef0e9203e5593010ae3169d6cb10d1d0@185.70.199.181:26656,c6f42abd5556cc60261b3e10a8251f7d15190995@185.144.99.245:26656,c9c1e9eb5310feb85f950858ab71a5939e2d8bac@3.133.191.108:26656,cee665be41690b73de47d32958c0e658e501c87b@38.242.255.189:26656,d56533cfe069904c32d59ae3eb432c9ec30ac389@54.37.7.123:26656,d6aba72517bb6772719940caf761f7b4e8118d0a@64.227.180.154:26656,d6d66f22234378a3e5d4f7e7667d4327448d16e1@137.184.88.231:26656,e42988cd52104af871a9bb394e072a32cbb556e2@203.238.191.195:26656,e47fc19a517fe835acaf789518271409cd2497b3@88.198.77.173:26656,e5109b67d91a1a3f1c9c5272182bc39ed1847305@54.169.85.109:26656,ef183b92e7fd406838d397849c21110feeb59fb5@193.187.129.243:26656,f9bb321e7edc1225e4e9b42e48712c0f011e569b@202.55.85.82:26656,fa453528a13f6d96667ec1da76744c7a29845afa@136.243.105.182:26656
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
In case you missed [PHASE 2](#Create-genesis-txs---PHASE-2). You can still become a validator.

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
If you want to delegate an amount of liquid and/or vesting coins from your wallet to your validator:
```bash
tgrade tx poe self-delegate 100000000utgd 900000000utgd \
  --from <validator-address> \
  --chain-id tgrade-mainnet-1 \
  --fees 10000utgd \
  --node https://rpc.mainnet-1.tgrade.confio.run:443


