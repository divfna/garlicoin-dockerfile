# garlicoin-dockerfile
Dockerfile for Garlicoin Daemon Linux

:moneybag: Donations welcomed at `GZkqkLUXsWG7qT9aT9SPmKkZFxcbb7YrMx` :bow:
    
### Create data directory on host
    # mkdir -p /var/lib/garlicoin

### Copy Garlicoin configuration to data directory
    # cp garlicoin.conf /var/lib/garlicoin
    
See [garlicoin.conf](garlicoin.conf) for an example configuration file.  
**It is recommended that you change the `rpcpassword` field before running!**

### Copy existing wallet file to data directory (Optional)
    # cp wallet.dat /var/lib/garlicoin
    
A new wallet will be created automatically if you do not have an existing one you wish to use.

### Run Docker image
    $ docker run -d \
        -p 42068:42068 \
        -p 42069:42069 \
        -v /var/lib/garlicoin:/mnt/garlicoin \
        --restart=always \
        --name garlicoin \
        ewrogers/garlicoin:latest

### Testing via CLI
    $ docker exec -it garlicoin /bin/bash
    # garlicoin-cli -datadir=${GARLICOIN_DATA_DIR} getblockchaininfo
    # garlicoin-cli -datadir=${GARLICOIN_DATA_DIR} getaddressesbyaccount ""
    # garlicoin-cli -datadir=${GARLICOIN_DATA_DIR} getbalance
    
You should see `getblockchaininfo` return a non-zero `blocks` field. This indicators which block your local wallet is on when syncing (it should eventually match the current head block number).
