#!/bin/bash

## . env.sh

start_keosd(){
    killall keosd 2>/dev/null
    rm -rf ${wallet_dir} 2>/dev/null
    mkdir -p ${wallet_dir}
    nohup keosd --wallet-dir ${wallet_dir} --unlock-timeout 90000 1>/dev/null  2>/dev/null &
}
start_keosd


create_wallet(){
    cleos wallet create -f ${wallet_dir}/password.txt
    cleos wallet import --private-key 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3
}
create_wallet


new_keys(){
    str=`cleos create key --to-console`
    pri_key=`echo $str | cut -d' ' -f 3`
    pub_key=`echo $str | cut -d' ' -f 6`
}


import_key(){
    cleos wallet import --private-key $1
}
