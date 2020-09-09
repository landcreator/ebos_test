#!/usr/bin/env bash

## . init_system_contracts.sh

# Create ibc.chain ibc.token and relay accounts
create_some_accounts(){
    char=`echo $1 | cut -c 7`

#    create_account            chain_${char} ${admin_account}
#    create_account_by_pub_key chain_${char} ${proxy_account}  ${proxy_c_pubkey}
}
create_some_accounts chain_a

#import_key ${token_c_prikey}



