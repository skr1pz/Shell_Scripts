#!/bin/bash
# This script updates resolv.conf and interfaces with DNS changes - run from redistest

servers=(
#RHO4INTREDISMASTER.int.uhs.com
#RHO4INTREDISSLAVE.int.uhs.com
#RHO4QUAREDISMASTER.int.uhs.com
#RHO4QUAREDISSLAVE.int.uhs.com
#RHO4REDISMASTER.int.uhs.com
#RHO4REDISSLAVE.int.uhs.com
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

sshpass -p $passphrase ssh -t -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $username@$server "sudo grep -rl 'nameserver 172.16.10.67' /etc/resolv.conf | xargs sudo sed -i 's/nameserver 172.16.10.67/nameserver 172.16.10.26/g' && sudo grep -rl 'dns-nameservers 172.16.20.68 172.16.10.67' /etc/network/interfaces | xargs sudo sed -i 's/dns-nameservers 172.16.20.68 172.16.10.67/dns-nameservers 172.16.20.70 172.16.10.26/g' && cat /etc/resolv.conf && cat /etc/network/interfaces"
read -p 'Press enter to continue'
done

