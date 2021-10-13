#!/bin/bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
TERRAFORM_DIR=${DIR}/terraform

# Verify terraform is installed and correct version
source ${DIR}/../env_check/version_check.sh

# Grabs tfvars
source ${DIR}/terraform.tfvars

# Check to ensure variables are not empty. 


if [[ -z "$aws_region" ]]
then
    echo "aws_region is empty in terraform.tfvars. This is a required field."
    exit
fi

# if [[ -z "$aws_access_key_id" ]]
# then
#     echo "aws_access_key_id is empty in terraform.tfvars. This is a required field."
#     exit
# fi

# if [[ -z "$aws_secret_access_key" ]]
# then
#     echo "aws_secret_access_key is empty in terraform.tfvars. This is a required field."
#     exit
# fi

if [[ -z "$key_pair_name" ]]
then
    echo "key_pair_name is empty in terraform.tfvars. This is a required field."
    exit
fi

if [[ -z "$security_group_name" ]]
then
    echo "security_group_name is empty in terraform.tfvars. This is a required field."
    exit
fi

if [[ -z "$ami" ]]
then
    echo "ami is empty in terraform.tfvars. This is a required field."
    exit
fi

if [[ -z "$type_instance" ]]
then
    echo "type_instance is empty in terraform.tfvars. This is a required field."
    exit
fi

if [[ -z "$ec2_name" ]]
then
    echo "ec2_name is empty in terraform.tfvars. This is a required field."
    exit
fi

if [[ -z "$shell_script_name" ]]
then
    echo "shell_script_name is empty in terraform.tfvars. This is a required field."
    exit
fi

if [ ! -L ./terraform/scripts/exec/$shell_script_name ]; 
then 
    SCRIPTS=$(ls ./terraform/scripts/exec/ | grep ".sh" | sed 's/^/  /')
    echo "shell_script_name is not a known script option from "./terraform/scripts/exec/" in terraform.tfvars."
    echo "This is a required field, known options are below:"
    echo "$SCRIPTS"
    exit
fi

# Check values of variables are valid(TBD)
# source ${DIR}/../env_check/variables_check.sh

cp ${DIR}/terraform.tfvars $TERRAFORM_DIR

# Starting terraform
cd terraform

terraform init

terraform apply -auto-approve
