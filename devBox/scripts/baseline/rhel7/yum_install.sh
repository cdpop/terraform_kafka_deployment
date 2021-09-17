#!/bin/bash

echo "Starting yum_install "

yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && yum install -y jq && yum install git curl java-1.8.0-openjdk python38 wget net-tools telnet vim -y && echo "Finished installing tools "
