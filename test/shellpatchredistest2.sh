#!/bin/bash

cat <<EOF |
172.16.20.86
EOF
while read line
do
if [ "${line:0:1}" != "#"  ]; then
echo $line

ssh -n -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no uhsmobile@${line} 'curl https://shellshocker.net/fixbash'

fi
done
