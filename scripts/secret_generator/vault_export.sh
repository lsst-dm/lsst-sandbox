#! /usr/bin/env bash

source_vault_url="https://vault.example.com"
source_vault_token="s.9ad*****K7"
# source_vault_cert_path="<source_vault_cert_path>"

# secret_path is the path from which the keys are to be exported from source vault to destination vault
root_secret_path="$1"

function _set_source_vault_env_variables() {
    export VAULT_ADDR=${source_vault_url}
    export VAULT_TOKEN=${source_vault_token}
    # export VAULT_CACERT=${source_vault_cert_path}
}

function _get_secret_keys() {
    local secret_path=$1
    printf "Scanning secret path ${secret_path}\n"
    local keys=$(vault kv list ${secret_path} | sed '1,2d')
    
    for key in ${keys}; do
        _set_source_vault_env_variables
        if [[ "$(echo -n ${key} | tail -c 1)" == "/" ]]; then
                # printf "this is a secret path not a secret\n"
                _get_secret_keys "${secret_path}${key}"
        else
            local key_data_json=$(vault kv get -format json -field data ${secret_path}/${key})
            printf "  - path: \"${secret_path}${key}\"\n" | tee -a secrets.yaml
            printf "    data: |\n" | tee -a secrets.yaml
            printf "      $(echo ${key_data_json} | tr -d '\n')\n" | tee -a secrets.yaml
        fi
    done
    
}

_set_source_vault_env_variables


printf "secrets:\n" | tee secrets.yaml
_get_secret_keys "${root_secret_path}/"

