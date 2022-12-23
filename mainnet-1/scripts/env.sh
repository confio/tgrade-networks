:
# Endpoints

export tgradeTag="v1.0.0"
export chainId="tgrade-mainnet-1"

export password="1234567890"
export stakeToken="utgd"
export feeToken="utgd"

export moniker=$(uname -n)

# Non-temporary home
export TGRADE_HOME="$HOME/.tgrade"
export homeDir="$TGRADE_HOME"
# Temporary home
tempWorkDir=$(mktemp -d)
export tempHomeDir="$tempWorkDir/home"

export chainSuffix="${chainId//tgrade-/}"
export key="validator-$chainSuffix"
export nodeUrl="https://rpc.$chainSuffix.tgrade.confio.run:443"
# Archiving node
export archUrl="http://78.47.157.145:26657"

# Local vs remote (client) stuff
export keyringBackend=""
if echo "$nodeUrl" | grep -v -q "localhost"
then
  export homeDir="$tempHomeDir"
  export keyringBackend="--keyring-backend=test"
fi
