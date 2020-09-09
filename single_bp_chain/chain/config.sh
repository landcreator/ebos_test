#!/usr/bin/env bash

read -d '' config_bios_common << EOF
enable-stale-production = true
plugin = eosio::producer_plugin
plugin = eosio::producer_api_plugin
plugin = eosio::chain_api_plugin
plugin = eosio::net_plugin
contracts-console = true
max-transaction-time = 2000
p2p-max-nodes-per-host = 20

producer-name = eosio
signature-provider = EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV=KEY:5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3
EOF

read -d '' config_bios_chain_a << EOF
p2p-server-address = localhost:4001
p2p-listen-endpoint = 0.0.0.0:4001
http-server-address = 127.0.0.1:4002
wasm-runtime = eos-vm-jit
EOF

read -d '' logging << EOF
{
  "includes": [],
  "appenders": [{
      "name": "stderr",
      "type": "console",
      "args": {
        "stream": "std_error",
        "level_colors": [{
            "level": "debug",
            "color": "green"
          },{
            "level": "warn",
            "color": "brown"
          },{
            "level": "error",
            "color": "red"
          }
        ]
      },
      "enabled": true
    },{
      "name": "stdout",
      "type": "console",
      "args": {
        "stream": "std_out",
        "level_colors": [{
            "level": "debug",
            "color": "green"
          },{
            "level": "warn",
            "color": "brown"
          },{
            "level": "error",
            "color": "red"
          }
        ]
      },
      "enabled": true
    }
  ],
  "loggers": [{
      "name": "default",
      "level": "debug",
      "enabled": true,
      "additivity": false,
      "appenders": [
        "stderr"
      ]
    }
  ]
}
EOF