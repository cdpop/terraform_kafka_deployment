#!/bin/bash
set -e

BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
LIME_YELLOW=$(tput setaf 190)
YELLOW=$(tput setaf 3)
POWDER_BLUE=$(tput setaf 153)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BRIGHT=$(tput bold)
NORMAL=$(tput sgr0)
BLINK=$(tput blink)
REVERSE=$(tput smso)
UNDERLINE=$(tput smul)

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
TERRAFORM_DIR=${DIR}/terraform

# Verify terraform is installed and correct version
source ${DIR}/env_check/version_check.sh

# Grabs tfvars
source ${DIR}/terraform.tfvars

# Check to ensure variables are not empty. 
function exit_if_var_does_not_exist {
    local TMP_NAME=$1
    local TMP_VALUE="${!TMP_NAME}"
    if ! declare -p $1 >/dev/null 2>&1 ; then
        [ -z "${!TMP_NAME}" ] && {
            echo "${RED}Variable key_pair_name is unset in terraform.tfvars. This is a required field. Exiting,${NORMAL}"
            echo "Variable [${TMP_NAME}] is unset. Exiting."
            return 1
        }
    elif [ "$TMP_VALUE" = "" ]; then
        echo "${RED}Variable key_pair_name is set to '' in terraform.tfvars. This is a required field. Exiting,${NORMAL}"
        return 1
    fi
    # echo "Variable [${TMP_NAME}] is set to ${TMP_VALUE}"    
}

exit_if_var_does_not_exist aws_region
exit_if_var_does_not_exist aws_access_key_id
exit_if_var_does_not_exist aws_secret_access_key
exit_if_var_does_not_exist key_pair_name
exit_if_var_does_not_exist security_group_name
exit_if_var_does_not_exist ami
exit_if_var_does_not_exist type_instance
exit_if_var_does_not_exist ec2_name
exit_if_var_does_not_exist shell_script_name


if [ ! -f "$TERRAFORM_DIR/scripts/exec/$shell_script_name" ];  
then 
    SCRIPTS=$(ls ./terraform/scripts/exec/ | grep ".sh" | sed 's/^/  /')
    echo "shell_script_name is not a known script option from "./terraform/scripts/exec/" in terraform.tfvars.${NORMAL}"
    echo "This is a required field, known options are below:"
    echo "$SCRIPTS"
    exit
fi

cp ${DIR}/terraform.tfvars $TERRAFORM_DIR

# Starting terraform
cd terraform

terraform init

terraform apply -auto-approve

echo "${GREEN}The output of variables have been saved to terraform_deployment_output.log.${NORMAL}"
terraform output > ../terraform_deployment_output.log