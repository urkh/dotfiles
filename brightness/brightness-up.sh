#!/bin/bash

# Get the stored state from file
exec < /home/urkh/.config/brightness/state # stdin replaced by this file
read state # first line of file goes to state variable

# Increase the state, up to FF
new_state=$(echo "$[0x$state+0x10]") # in decimal
if [ "${new_state}" -gt 255 ] # 255 = FF in hex
then
    echo "Already at maximal brightness."
else
    state=$(echo "obase=16; $new_state" | bc) # put into hex
    echo "Setting brightness to $state and storing state..."
    sudo setpci -s 00:02.0 f4.b=$state # passwordless sudo
    echo $state > /home/urkh/.config/brightness/state
fi
