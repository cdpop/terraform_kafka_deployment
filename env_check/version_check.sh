#!/bin/bash

# Verify we have the correct version of terraform. 
set -e

REQ_TERRAFORM_VERSION="1.0.8"



if ! command -v terraform &> /dev/null
then
    echo "Terraform CLI could not be found on your machine. To download/install the latest version visit the following page: https://www.terraform.io/downloads.html"
    exit
fi

function version_lt() { test "$(echo "$@" | tr " " "\n" | sort -rV | head -n 1)" != "$1"; }

LOCAL_VERSION="$(terraform --version | head -n1 | cut -d " " -f2 | cut -c2-)"

if version_lt $LOCAL_VERSION $REQ_TERRAFORM_VERSION; then
   echo "Terraform version is lower than $REQ_TERRAFORM_VERSION. You will need to upgrade terraform to $REQ_TERRAFORM_VERSION."
   exit
else
    echo "The installed version of terraform is >= $REQ_TERRAFORM_VERSION"   
fi

