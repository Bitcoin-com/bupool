# Bitcoin.com Mining Pool Proxy (based on Ckpool)

CKPOOL by Con Kolivas and Andrew Smith.

## System requirements

* HP Proliant DL360 G6 or better (Intel® Xeon® Processor L5520, at least 8Gb of RAM)
* Debian 8 or Ubuntu 16.04 or better (required systemd for install)

### Prerequisites

On Ubuntu and Debian, install the build essentials and git

```
sudo apt-get install build-essential yasm git sudo
```

### Build Ckpool without ckdb

```
git clone https://github.com/Bitcoin-com/bupool
cd bupool
./configure --without-ckdb
make
sudo make install
```

### Install the single user proxy

```
sudo ./install-proxy.sh
```

Enter the local static IP you want to bind the proxy daemon to, then the pool domain or IP address, don't forget to add the stratum port. For this install script, it won't matter which user you specify in the miner, all users will be overwritten by the proxy. If you want to run multiple users, then use the multi user install script.

### Start restart the proxy

The proxy should start automatically when booting. It should also restart automatically in case it crashes. All logs can be found in /var/log/ckpool/ .

To reload the proxy:
```
systemctl reload ckpool
```

To (hard) restart the proxy:
```
systemctl restart ckpool
```

To start/stop the proxy:

```
systemctl stop ckpool
systemctl start ckpool
```

Verify it's running properly

```
tail -f /var/log/ckpool/ckproxy.log
```
