#!/bin/bash
# This script shellshock patches all Rho Linux boxes, it will be ran from rhotest1

servers=(
#List of servers
REDISTEST.int.uhs.com

)
for server in ${servers[@]}
do
# Command to patch

ssh uhsmobile@$server "echo m0b113@dm1n | sudo -S curl https://shellshocker.net/fixbash | sh"

done