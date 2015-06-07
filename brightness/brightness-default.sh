#!/bin/bash

# Set brightness to default value
state=AF
sudo setpci -s 00:02.0 F4.B=$state # passwordless sudo
echo $state > /home/androith/.scripts/brightness/state
