# How to change the binary

# 1) By using --halt-height

We start the tgrade process with the flag **--halt-height**

The given Block height at which to gracefully halt the chain and shutdown the node

Example:

`tgrade start --halt-height 1250000 --rpc.laddr tcp://0.0.0.0:26657`

The node will stop at block height 125000

And then, you change/swap the binary from the version **v1.0.1** to **v2.0.0**

Finishing with starting the tgrade process as normal:

`tgrade start --rpc.laddr tcp://0.0.0.0:26657`

I know some validators are running tgrade in a bash script, systemd service unit, docker container, running tgrade in the background, etc

# 2) By using Cosmovisor

If we are using cosmovisor it will automatically change the binary when it is needed, but we have to keep a few points in mind.

- If you have to change/swap the binary after we have a passed and executed proposal.
- You cannot drop/copy the binary before the proposal has been passed and executed. Otherwise, once the proposal gets executed, it will swap the binary before its time.

## 2.a) Install Cosmovisor - If you don&#39;t have Cosmosvisor

Cosmovisor is currently located in the Cosmos SDK repo, so you will need to download that, build cosmovisor, and add it to you PATH.

```
git clone https://github.com/cosmos/cosmos-sdk
cd cosmos-sdk
git checkout v0.45.8
make cosmovisor
cp cosmovisor/cosmovisor /usr/local/bin
```

After this, you must make the necessary folders for cosmosvisor in your daemon home directory (~/.tgrade).

```
mkdir -p ~/.tgrade
mkdir -p ~/.tgrade/cosmovisor
mkdir -p ~/.tgrade/cosmovisor/genesis
mkdir -p ~/.tgrade/cosmovisor/genesis/bin
mkdir -p ~/.tgrade/cosmovisor/upgrades
```

Cosmovisor requires some ENVIRONMENT VARIABLES be set in order to function properly. We recommend setting these in your `.profile` so it is automatically set in every session.

```
echo "# Setup Cosmovisor" >> ~/.profile
echo "export DAEMON_NAME=tgrade" >> ~/.profile
echo "export DAEMON_HOME=/home/user/.tgrade" >> ~/.profile
echo 'export PATH="$DAEMON_HOME/cosmovisor/current/bin:$PATH"' >> ~/.profile
source ~/.profile
```

Finally, you should move ( or copy ) the tgrade binary into the cosmovisor/genesis folder.

```
mv /usr/local/bin/tgrade ~/.tgrade/cosmovisor/genesis/bin
```

You need to keep the process always running. If you&#39;re on a Linux machine, you can use a systemd service unit to achieve this:

`sudo vim /etc/systemd/system/tgrade.service` or nano

```
[Unit]
Description=Tgrade
After=network-online.target

[Service]
User=user
ExecStart=/usr/local/bin/cosmovisor start
Restart=always
RestartSec=3
LimitNOFILE=infinity

Environment="DAEMON_HOME=/home/user/.tgrade"
Environment="DAEMON_NAME=tgrade"
Environment="DAEMON_ALLOW_DOWNLOAD_BINARIES=false"
Environment="DAEMON_RESTART_AFTER_UPGRADE=true"

[Install]
WantedBy=multi-user.target

```

Then update and start the tgrade service

```
sudo systemctl daemon-reload
sudo systemctl enable tgrade
sudo systemctl start tgrade
```

**NOTE:** be aware you may need to change the PATH according to your system, on this scenario, I was using the user called `user` with home directory `/home/user` and app_home directory `/home/user/.tgrade`

## 2.b) Copy the new Binary ( tgrade v2.0.0 ) in its place

Once the proposal has been passed and executed.

We can create the directory for the new binary and copy the file.

Example:

```
mkdir -p /home/user/.tgrade/cosmovisor/upgrades/v2/bin
cp /tmp/tgrade/build/tgradeV2 /home/user/.tgrade/cosmovisor/upgrades/v2/bin/tgrade
```
