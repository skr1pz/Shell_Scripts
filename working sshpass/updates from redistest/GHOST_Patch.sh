#!/bin/bash
# This script patches the C libraries that the GHOST vulnerability exploits - run from redistest

servers=(
RHO4INTREDISMASTER.int.uhs.com
RHO4INTREDISSLAVE.int.uhs.com
RHO4INT1.int.uhs.com
RHO4QUAREDISMASTER.int.uhs.com
RHO4QUAREDISSLAVE.int.uhs.com
RHO4QUA1.int.uhs.com
RHO4DEV1.int.uhs.com
RHO4REDISMASTER.int.uhs.com
RHO4REDISSLAVE.int.uhs.com
RHO4PROD1.int.uhs.com
RHO4PROD2.int.uhs.com
REDISMASTER.int.uhs.com
REDISSLAVE.int.uhs.com
RHOPROD2.int.uhs.com
RHOPROD1.int.uhs.com
REDISDEV.int.uhs.com
RHODEV1.int.uhs.com
REDISTRAIN.int.uhs.com
RHOTRAIN1.int.uhs.com
REDISTEST.int.uhs.com
RHOTEST1.int.uhs.com
)
for server in ${servers[@]}
do
# Command to patch

sshpass -p m0b113@dm1n ssh -t -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no uhsmobile@$server "sudo apt-get clean && sudo apt-get -y update && sudo apt-get -y install libc6 && ldd --version && wget https://webshare.uchicago.edu/orgs/ITServices/itsec/Downloads/GHOST.c && gcc GHOST.c -o GHOST && ./GHOST && sudo reboot"
read -p 'Press enter to continue'
done

