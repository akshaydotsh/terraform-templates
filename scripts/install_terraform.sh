#!/usr/bin/env bash
expected_version='Terraform v0.12.19'

install_tf() {
  echo "Installing $expected_version ..."
  sudo apt-get install unzip
  sudo mkdir -p /tmp/aws_tf
  sudo wget https://releases.hashicorp.com/terraform/0.12.19/terraform_0.12.19_linux_amd64.zip /tmp/aws_tf
  sudo unzip terraform_0.12.19_linux_amd64.zip
  sudo mv terraform /usr/local/bin
  echo "Terraform $expected_version installed!"
}

if [ -x "$(command -v terraform)" ]; then
    version="$(terraform -v | grep 'v0.*')"
    if [ "$version" = "$expected_version" ]; then
      echo "Terraform is installed and in correct version"
      exit
    else
      echo "$version installed but expected version is $expected_version ; Please install correct version if you face issues"
    fi
else
  echo "Not found!"
  install_tf
fi
