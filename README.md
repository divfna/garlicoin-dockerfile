# garlicoin-dockerfile
Dockerfile for Garlicoin daemon under Linux

:moneybag: Donations welcomed at `GTGrDXcusqnvXhXhGBJEFwpwhXrSftAHcw` :bow:
    
See [garlicoin.conf](garlicoin.conf) for an example configuration file.  

### Run Docker image
    $ docker volume create garlicoin_data
    $ docker run -d \
        -p 42068:42068 \
        -p 42069:42069 \
        -v garlicoin_data:/data/garlicoin \
        --restart=always \
        --name garlicoin \
        ewrogers/garlicoin:latest -rescan -txindex
        
**NOTE:** The `-rescan` and `-txindex` args are optional. Any args after the docker image are passed to `garlicoind` directly.
        
### Copy existing wallet file to data directory (Optional)
    # cp wallet.dat /var/lib/docker/volumes/garlicoin_data/_data
    
A new wallet will be created automatically if you do not have an existing one you wish to use.

### Update garlicoin.conf (Recommended)
    $ nano garlicoin.conf
    # cp garlicoin.conf /var/lib/docker/volumes/garlicoin_data/_data
    
It is **highly recommended** that you change the `rpcpassword` field.

### Restart Docker container (for wallet/config changes)
    $ docker restart garlicoin

### Testing via CLI
    $ docker exec -it garlicoin /bin/bash
    # garlicoin-cli -datadir=${GARLICOIN_DATA_DIR} getblockchaininfo
    # garlicoin-cli -datadir=${GARLICOIN_DATA_DIR} getaddressesbyaccount ""
    # garlicoin-cli -datadir=${GARLICOIN_DATA_DIR} getbalance
    
You should see `getblockchaininfo` return a non-zero `blocks` field. This indicators which block your local wallet is on when syncing (it should eventually match the current head block number).
