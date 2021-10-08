#!/bin/bash
version=$1
echo "$version" > /tmp/cp_demo_version.txt

# install baseline
/tmp/scripts/exec/baseline.sh

# cp demo with zsh
/tmp/scripts/cp_demo/cp-demo-complete.sh $version


