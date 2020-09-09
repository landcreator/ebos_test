#!/usr/bin/env bash

## ./init.sh

setup_system_contracts_and_issue_token(){
    char=`echo $1 | cut -c 7`
    cleos=cleos_${char}
    sym=${core_token_sym}

    # step 1: set contract eosio.bios
    ${!cleos} set contract eosio ${sys_contracts_dir}/eosio.bios -p eosio

    # step 2: create system accounts
    sleep .5
    for account in eosio.token eosio.msig eosio.stake eosio.bpay eosio.vpay eosio.saving
    do
        echo -e "\n creating $account \n";
        ${!cleos} create account eosio ${account} EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV -p eosio -x 1000
        sleep .2
    done

    # step 3: set contract
    echo step 3
    ${!cleos} set contract eosio.token ${sys_contracts_dir}/eosio.token -p eosio.token
    ${!cleos} set contract eosio.msig ${sys_contracts_dir}/eosio.msig -p eosio.msig

    # step 4: create and issue token
    echo step 4
    ${!cleos} push action eosio.token create '["eosio", "10000000000.0000 '$sym'"]' -p eosio.token
    ${!cleos} push action eosio.token issue '["eosio",  "1000000000.0000 '$sym'", "memo"]' -p eosio

    #setp 5: setting privileged account for eosio.msig
    ${!cleos} push action eosio setpriv '{"account": "eosio.msig", "is_priv": 1}' -p eosio

    # step 6: set contract eosio.system
    sleep .5
    ${!cleos} set contract eosio ${sys_contracts_dir}/eosio.system -x 1000 -p eosio
    ${!cleos} push action eosio init '[0, "4,'$sym'"]' -p eosio

}
setup_system_contracts_and_issue_token chain_a


sleep .2
upgrade_consensus(){
    char=`echo $1 | cut -c 7`
    cleos=cleos_${char}

    head_num=`${!cleos} get info |jq .head_block_num`
    target_num=$((head_num+110))
    ${!cleos} push action eosio setupgrade '{"up":{"target_block_num":'${target_num}'}}' -p eosio

}
upgrade_consensus chain_a


sleep .2
create_firstaccount(){
    char=`echo $1 | cut -c 7`
    cleos=cleos_${char}
    sym=${core_token_sym}


    echo "create first user account."
    new_keys
    ${!cleos} system newaccount \
         --stake-net "10000.0000 "$sym --stake-cpu "10000.0000 "$sym --buy-ram "100.0000 "$sym \
         eosio firstaccount $pub_key $pub_key -p eosio --transfer
    ${!cleos} transfer eosio firstaccount "10000000.0000 "$sym
    import_key $pri_key
}
create_firstaccount chain_a


create_account(){
    char=`echo $1 | cut -c 7`
    cleos=cleos_${char}
    sym=${core_token_sym}

    name=$2
    new_keys
    ${!cleos} system newaccount \
        --stake-net "10000.0000 "$sym --stake-cpu "10000.0000 "$sym --buy-ram "100.0000 "$sym \
        firstaccount $name $pub_key $pub_key -p firstaccount
    ${!cleos} transfer firstaccount $name "10000.0000 "$sym
    import_key $pri_key
}

create_account_by_pub_key(){
    char=`echo $1 | cut -c 7`
    cleos=cleos_${char}
    sym=${core_token_sym}

    name=$2
    pub_key=$3
    ${!cleos} system newaccount \
        --stake-net "10000.0000 "$sym --stake-cpu "10000.0000 "$sym --buy-ram "100.0000 "$sym \
        firstaccount $name $pub_key $pub_key -p firstaccount
    ${!cleos} transfer firstaccount $name "10000.0000 "$sym
}