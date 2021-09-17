#!/bin/bash
version="$1"

# install baseline
/tmp/scripts/exec/baseline.sh

# cp demo with zsh
/tmp/scripts/cp_demo/cp-demo-complete-jmx.sh $version


