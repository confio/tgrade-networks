If you find this Repo, be aware it is a semi-public testnet. \
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
git checkout v0.10.0-rc1
```

Run GO install and build for the upcoming binary
```bash
make build
```

Move the binary to an executable path
```bash
sudo mv build/tgrade /usr/local/bin
```

At last, Thank you \
As an official announcement, we can start the process at the moment:
- gathering the correct info,
- getting the pre-genesis file ready,
- and submitting a gen tx in a few days.

But we will ask you to recompile the binary once the final version of tgrade 0.10.0 is available.

## Setting up a Genesis Tgrade Validator - PHASE 1
( to be announced ) - within 14.06 - 17.06
