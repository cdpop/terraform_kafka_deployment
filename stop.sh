#!/bin/bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# Verify terraform is installed and correct version
source ${DIR}/env_check/version_check.sh


# Destroying terraform 
cd terraform
terraform destroy -auto-approve
