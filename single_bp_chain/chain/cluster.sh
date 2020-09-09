#!/bin/bash

cluster_init(){
    . init.sh
    . config.sh

    cluster_clear

    cName=config.ini
    lName=logging.json

    path=staging/etc/eosio/node_bios_chain_a
    mkdir -p $path
    echo "$config_bios_common"              > $path/$cName
    echo "$config_bios_chain_a"            >> $path/$cName
    echo "$logging"                         > $path/$lName
}

cluster_clear(){
    killall nodeos 2>/dev/null
    rm *.json *.dot *.ini *.log topology* 2>/dev/null
    rm -rf staging
    rm -rf etc/eosio/node_*
    rm -rf var/lib
}

case "$1"
in
    "init"  )   cluster_init;;
    "clear" )   cluster_clear;;
    *) echo "usage: cluster.sh init|clear" ;;
esac


# Please do not execute this function, each of the following command groups can start a node,
# open four bash shells and execute the following four commands in each one.
nodes_managment(){

    ## ---------  start bios node  ---------
    bios_chain_data=var/lib/node_bios_chain_a
    bios_chain_conf=staging/etc/eosio/node_bios_chain_a
    ./programs/nodeos/nodeos -e -p eosio -d $bios_chain_data --config-dir $bios_chain_conf

}

