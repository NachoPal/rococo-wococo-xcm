#!/bin/bash

./stop.sh

. ./config.sh

mkdir bin || true
mkdir data || true
mkdir logs || true
mkdir resources/parachains || true
mkdir resources/chain-specs || true
rm -rf data/*
rm -rf resources/parachains/*
rm -rf resources/chain-specs/*
rm -rf logs/*
rm -rf bin/src/*

yarn

if ! $DEVELOPMENT
then
  yarn build
fi  

. ./scripts/build/polkadot-node.sh
. ./scripts/build/substrate-relay.sh
. ./scripts/build/parachain-collator.sh

. ./scripts/run/rococo-relaychain.sh
. ./scripts/run/rococo-parachain.sh

. ./scripts/run/wococo-relaychain.sh
. ./scripts/run/wococo-parachain.sh

. ./scripts/run/headers-messages-relayer.sh

. ./scripts/run/register-parachains.sh