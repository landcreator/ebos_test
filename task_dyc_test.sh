#!/usr/bin/env bash

. env.sh

# test contents


${!cleos} push action eosio awlset "[add ,firstaccoun2]" -p dyadmin
${!cleos} push action eosio setacntype "[firstaccoun1,company]" -p dyadmin
${!cleos} push action eosio setacntype "[firstaccoun2,company]" -p dyadmin
${!cleos} push action eosio setacntype "[firstaccoun1,government]" -p dyadmin
${!cleos} push action eosio setacntype "[firstaccoun1,none]" -p dyadmin

${!cleos} push action eosio regproducer

name=firstaccoun5
pub_key=EOS5CuGSsDBTmdwd6sXiC5wTwYvStFKaxVnwxHyEWvzzq6TE58C5t
${!cleos} system newaccount --stake-cpu "10000.0000 "$sym --stake-net "0 "$sym --buy-ram "0 "$sym firstaccount $name $pub_key $pub_key -p firstaccount


