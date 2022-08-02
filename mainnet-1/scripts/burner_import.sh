#!/usr/bin/env bash

source ./scripts/env.sh

# Burner keys.
declare -A burner
burner[$key]=$(tgrade keys show "$key" "$keyringBackend" | grep address: | awk '{print $2}')

# Got these from keybase (import them using their keyphrases)
burner[burner1-$chainSuffix]="tgrade14eh7wjxtk6n8lhz777xr4m627dckgctaw3mah8"
burner[burner2-$chainSuffix]="tgrade1pu56eey9zysaw2tgnr43e97wkw79hmpn6mr07p"
burner[burner3-$chainSuffix]="tgrade1heuekrcyx73v8gumt529gr89l0wcacvvlcrccs"

for val in "${!burner[@]}"
do
  if [ "$val" != "$key" ]
  then
    echo "Importing $val:"
    tgrade keys add "$val" --recover "$keyringBackend"
  fi
  address="${burner[$val]}"
  echo "Tokens for $val ($address):"
  tgrade query bank balances "$address" --node="$nodeUrl"
done
