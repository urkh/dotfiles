#!/bin/bash

# Get the stored state from file
exec < /home/urkh/.config/brightness/current # stdin replaced by this file
read state # first line of file goes to state variable

# Decrease the state, down to FF
new_state=$(echo "$[0x$state-0x10]") # in decimal
if [ "$new_state" -lt 15 ] # 15 = 0F in hex
then
    echo "Already at minimal brightness."
else
    state=$(echo "obase=16; $new_state" | bc) # update and put into hex
    echo "Setting brightness to $state and storing state..."
    sudo setpci -s 00:02.0 F4.B=$state # passwordless sudo
    echo $state > /home/urkh/.config/brightness/current
fi
