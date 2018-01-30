#!/bin/bash -e

echo "Starting Garlicoin daemon..."
exec garlicoind -datadir=${GARLICOIN_DATA_DIR} "$@"
