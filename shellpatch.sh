#!/bin/bash
# This script shellshock patches all Rho Linux boxes, it will be ran from rhotest1

servers=(
#List of servers
rho4dev1.int.uhs.com
rho4int1.int.uhs.com
rho4prod1.int.uhs.com
rho4prod2.int.uhs.com
rho4qua1.int.uhs.com
RHO4INTREDISMASTER.int.uhs.com
RHO4INTREDISSLAVE.int.uhs.com
RHO4QUAREDISMASTER.int.uhs.com
RHO4QUAREDISSLAVE.int.uhs.com
RHO4REDISMASTER.int.uhs.com
RHO4REDISSLAVE.int.uhs.com
RHO4TRN.int.uhs.com
RHODEV1.int.uhs.com
RHOPROD1.int.uhs.com
RHOPROD2.int.uhs.com
RHOTEST1.int.uhs.com
#RHOTRAIN1.int.uhs.com
REDISDEV.int.uhs.com
REDISMASTER.int.uhs.com
REDISSLAVE.int.uhs.com
REDISTEST.int.uhs.com
REDISTRAIN.int.uhs.com
)
for server in ${servers[@]}
do
# Command to patch

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $username@$server "echo $passphrase | sudo -S curl https://shellshocker.net/fixbash | sh"

done
