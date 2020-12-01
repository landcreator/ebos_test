#!/usr/bin/env bash

# config
github_account=landcreator
github_repo_node=ebos
github_repo_syscontrct=ebos.contracts.bos

local_base_dir=~/Code/github.com

#nodeos=${src_base_dir}/bins/ebos_v1.0.0
eosio_build_dir=${local_base_dir}/${github_account}/${github_repo_node}/build
nodeos=${eosio_build_dir}/programs/nodeos/nodeos
eosio_launcher=${eosio_build_dir}/programs/eosio-launcher/eosio-launcher
cleos=${eosio_build_dir}/programs/cleos/cleos

sys_contracts_dir=${local_base_dir}/${github_account}/${github_repo_syscontrct}/build/contracts

core_token_sym=DYC

wallet_dir=~/tmp/eosio/eosio-wallet

cleos="${cleos} -u http://127.0.0.1:4002"
