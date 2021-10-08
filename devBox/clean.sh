#!/bin/bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# Verify terraform is installed and correct version

cd terraform
rm terraform.tfstate*
rm -rf .terraform