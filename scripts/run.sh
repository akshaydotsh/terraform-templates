#!/usr/bin/env bash

dirpath=$(pwd)/$1

# shellcheck disable=SC2164
cd "$dirpath"
terraform init
terraform plan --out="tfplan"
terraform apply "tfplan"