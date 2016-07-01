#!/bin/bash
# This script updates resolv.conf and interfaces with DNS changes - run from rhotest1

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

sshpass -p $passphrase ssh -t -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $username@$server "grep -rl 'nameserver 172.16.20.68' /etc/resolv.conf | xargs sed -i 's/nameserver 172.16.20.68/nameserver 172.16.20.70/g' && grep -rl 'nameserver 172.16.20.56' /etc/resolv.conf | xargs sed -i 's/nameserver 172.16.20.56/nameserver 172.16.10.26/g' && grep -rl 'nameserver 172.16.10.67' /etc/resolv.conf | xargs sed -i 's/nameserver 172.16.10.67/nameserver 172.16.10.26/g' && grep -rl 'nameserver 172.16.65.50' /etc/resolv.conf | xargs sed -i 's/nameserver 172.16.65.50/nameserver 172.16.10.26/g' && grep -rl 'dns-nameservers 172.16.20.68 172.16.20.56' /etc/network/interfaces | xargs sed -i 's/dns-nameservers 172.16.20.68 172.16.20.56/dns-nameservers 172.16.20.70 172.16.10.26/g' && grep -rl 'dns-nameservers 172.16.20.56 172.16.20.68' /etc/network/interfaces | xargs sed -i 's/dns-nameservers 172.16.20.56 172.16.20.68/dns-nameservers 172.16.20.70 172.16.10.26/g' && grep -rl 'dns-nameservers 172.16.20.68 172.16.10.67' /etc/network/interfaces | xargs sed -i 's/dns-nameservers 172.16.20.68 172.16.10.67/dns-nameservers 172.16.20.70 172.16.10.26/g' && grep -rl 'dns-nameservers 172.16.10.67 172.16.20.68' /etc/network/interfaces | xargs sed -i 's/dns-nameservers 172.16.10.67 172.16.20.68/dns-nameservers 172.16.20.70 172.16.10.26/g' && grep -rl 'dns-nameservers 172.16.20.68 172.16.65.50' /etc/network/interfaces | xargs sed -i 's/dns-nameservers 172.16.20.68 172.16.65.50/dns-nameservers 172.16.20.70 172.16.10.26/g' && grep -rl 'dns-nameservers 172.16.65.50 172.16.20.68' /etc/network/interfaces | xargs sed -i 's/dns-nameservers 172.16.65.50 172.16.20.68/dns-nameservers 172.16.20.70 172.16.10.26/g'"
done
