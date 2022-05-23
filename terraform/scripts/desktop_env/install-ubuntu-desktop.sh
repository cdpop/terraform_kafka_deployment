#!/bin/bash

# https://ubuntu.com/tutorials/tutorial-ubuntu-desktop-aws#3-configuring-the-vnc-server

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install ubuntu-desktop gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal xfce4 vnc4server -y
