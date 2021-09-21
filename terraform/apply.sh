#!/bin/bash

if [[ -z "$1" ]]; then
  echo ""
  echo "You have not provided Terraform path"
  echo "SYNTAX = ./apply.sh <PATH>"
  echo ""
  exit
fi

cd "./$1"

terraform init

terraform get

terraform apply -auto-approve
