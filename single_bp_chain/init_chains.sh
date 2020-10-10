#!/usr/bin/env bash

cpath=`pwd`
bn=`basename $cpath`

if [ "$bn" != "single_bp_chain" ]; then
    echo "error! you must run this command in directory 'single_bp_chain'"
    return
fi

. ./../env.sh
. ./../init.sh
. ./../init_system_contracts.sh






