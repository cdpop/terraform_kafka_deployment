#!/bin/bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
TERRAFORM_DIR=${DIR}/terraform

# Verify terraform is installed and correct version
source ${DIR}/../env_check/version_check.sh



# check all required variables are set
source ${DIR}/../env_check/variables_check.sh

cp ${DIR}/terraform.tfvars $TERRAFORM_DIR

# Starting terraform
# ${TERRAFORM_DIR}/terraform init

# ${TERRAFORM_DIR}/terraform apply -auto-approve