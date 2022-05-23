#!/bin/bash

echo "Starting yum_install \n "
yum install git curl jq java-1.8.0-openjdk python38 wget net-tools telnet vim -y && echo "Finished installing tools "

# installs kernel modules and inserts netem for latency
dnf install kernel-modules-extra -y

# time being we have to manually install the module as modprobe isn't picking it up and depmod won't add the module
insmod /lib/modules/4.18.0-193.19.1.el8_2.x86_64/kernel/net/sched/sch_netem.ko.xz