## Query the total balance of an account:
This will show you your available/liquidity balance plus delegatable vesting
Syntax:
```bash
tgrade query bank [address] [flags]

# Example
tgrade query bank balances tgrade17h2x3j7u44qkrq0sk8ul0r2qr440rwgjca5y25 \
  --node https://rpc.mainnet-1.tgrade.confio.run:443
balances:
- amount: "70600669000"
  denom: utgd
pagination:
  next_key: null
  total: "0"

```
## Query delegated free, delegated vesting and original vesting
Syntax:
```bash
tgrade query account [address] [flags]

# Example
tgrade query account tgrade17h2x3j7u44qkrq0sk8ul0r2qr440rwgjca5y25 \
  --node https://rpc.mainnet-1.tgrade.confio.run:443
'@type': /cosmos.vesting.v1beta1.ContinuousVestingAccount
base_vesting_account:
  base_account:
    account_number: "87"
    address: tgrade17h2x3j7u44qkrq0sk8ul0r2qr440rwgjca5y25
    pub_key:
      '@type': /cosmos.crypto.secp256k1.PubKey
      key: A2hYGyV4rZnlm2wWfKnCFKH3RLMxWhuFzbGDthShXmnP
    sequence: "14"
  delegated_free:
  - amount: "767236"
    denom: utgd
  delegated_vesting:
  - amount: "215112232764"
    denom: utgd
  end_time: "1703435178"
  original_vesting:
  - amount: "285000000000"
    denom: utgd
start_time: "1641027600"
```

## Query delegations that are unbonding
Syntax:
```bash
tgrade query poe unbonding-delegations [validator-addr] [flags]

# Example
tgrade query poe unbonding-delegations tgrade1admh0ft2553aw6u9hxn7v2vw488r0yyg6u345u \
  --node https://rpc.mainnet-1.tgrade.confio.run:443
entries:
- balance: "0"
  completion_time: "2022-08-15T10:30:56.587443684Z"
  creation_height: "413317"
  initial_balance: "0"
- balance: "25000000000"
  completion_time: "2022-09-12T16:43:38.264256454Z"
  creation_height: "830471"
  initial_balance: "25000000000"
pagination: null
```

## Unbond an amount of bonded shares from a validator:
Syntax:
```bash
tgrade tx poe unbond [amount] --from [validator_address/keyname] [flags]
tgrade tx poe unbond 1tgd --from miguel --fees 16000utgd \
  --gas-adjustment 1.4 \
  --gas auto \
  --node https://rpc.mainnet-1.tgrade.confio.run:443 \
  --chain-id tgrade-mainnet-1
```

## Execute and/or run a Claim
After an amount balance has completed its unbonding period, you have to run a claim to make available and be part of the liquidity
Syntax:
```bash
tgrade tx wasm execute "tgrade17p9rzwnnfxcjp32un9ug7yhhzgtkhvl9jfksztgw5uh69wac2pgsmsjtzp" '{"claim": {}}' \
  --amount 601000utgd \
  --from miguel \
  --broadcast-mode block \
  --chain-id="tgrade-mainnet-1" \
  --node "https://rpc.mainnet-1.tgrade.confio.run:443" \
  --fees 12500utgd \
  --gas=auto \
  --gas-adjustment=1.4 \
  --node "https://rpc.mainnet-1.tgrade.confio.run:443" \
  --chain-id="tgrade-mainnet-1"
```

## Claim distribution and engagement rewards: ( This is just available on 2.0.0 )
Syntax:
```bash
tgrade tx poe claim-rewards --engagement --from [validator_address] [flags]
tgrade tx poe claim-rewards --distribution --from [validator_address] [flags]
```

