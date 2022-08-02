:

source ./scripts/env.sh

[ -d "$TGRADE_HOME" ] && echo "$TGRADE_HOME already exists. Aborting." && exit 1

tgrade init $moniker --chain-id $chainId 2>&1 | jq . | tee $moniker.json

tgrade keys add $key $keyringBackend 2>&1 | tee $key.txt

# Set minimum gas
sed -i 's/minimum-gas-prices = ".*"/minimum-gas-prices = "0.05utgd"/' $TGRADE_HOME/config/app.toml

# Set genesis file
cp ./config/genesis.json $TGRADE_HOME/config/genesis.json
