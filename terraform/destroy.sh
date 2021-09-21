#!/bin/bash

if [[ -z "$1" ]]; then
  echo ""
  echo "You have not provided Terraform path"
  echo "SYNTAX = ./destroy.sh <PATH>"
  echo ""
  exit
fi

cd "./$1"

terraform init

terraform get

terraform destroy -auto-approve
