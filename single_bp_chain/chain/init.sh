#!/usr/bin/env bash

. ../../env.sh

program_dir=./programs
if [ -d ${program_dir} ]; then
    rm -rf ${program_dir}
fi

mkdir -p ${program_dir}/nodeos
cp $nodeos ${program_dir}/nodeos/nodeos
