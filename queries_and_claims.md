## Query the total balance of an account
This will show you your available balance plus delegatable vesting
Syntax:
```bash
tgrade query bank [address] [flags]

# Example
tgrade query bank balances tgrade17h2x3j7u44qkrq0sk8ul0r2qr440rwgjca5y25 --node https://rpc.mainnet-1.tgrade.confio.run:443
balances:
- amount: "70600669000"
  denom: utgd
pagination:
  next_key: null
  total: "0"

```
## Query delegated free, delegated vesting and original vesting:
```bash
tgrade query account [address] [flags]

# Example
tgrade query account tgrade17h2x3j7u44qkrq0sk8ul0r2qr440rwgjca5y25 --node https://rpc.mainnet-1.tgrade.confio.run:443
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

