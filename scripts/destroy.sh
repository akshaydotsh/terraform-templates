#!/usr/bin/env bash

dirpath=$(pwd)/$1

# shellcheck disable=SC2164
cd "$dirpath"
terraform destroy -auto-approve