#!/bin/bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# Verify terraform is installed and correct version

rm terraform_deployment_output.log
cd terraform
rm terraform.tfvars
rm terraform.tfstate*
rm -rf .terraform