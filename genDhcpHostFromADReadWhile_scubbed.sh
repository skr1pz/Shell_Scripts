#!/usr/bin/bash
###########################################################################
# This script is used to query AD and generate DHCP hostnames via dhcpgen #
# Please set the ldapsearch variables for your environment                #
# $Id: genDhcpHostFromAD.sh 2016-03-07 17:08:23Z mmayer $                 #
########################################################################### 


#ldapsearch variables, change for your environment
HOST=ldap://$IP
USER=$bindUN
PASS=$PW
BASEDN=$baseDN

#dhcpgen destination IP variable, change for your environment
DEST=$destIP

#log file
LOGFILE="genDhcpHostFromADLogFile.log"

if [ `whoami` != root ]; then
	echo "You must be root to run this script, aborting"
	exit 1
fi

if [ $(ifconfig eth0 | awk '/inet / {print $2}') = $DEST ]; then
        echo "Your destination IP argument for dhcpgen is the same as your source IP, please open this script and set the DEST variable; aborting"
        exit 1
fi 

if [ -f $LOGFILE ]; then
        rm -f $LOGFILE
fi

mount -t fdescfs fdesc /dev/fd  #Mount /dev/fd/62 to supress error 

cat <<EOM

#################################################################################################        
# This script will generate DHCP hostnames via the dhcpgen script and ldapsearch                #
#                                                                                               #
# Open the script and edit the variables for your AD environment and destination IP for         #
# dhcpgen traffic. THE SOURCE IP (BOX YOU EXECUTE FROM) AND DESTINATION IP CANNOT BE THE SAME!! #
#################################################################################################

To proceed hit ENTER, to abort hit CTRL-C
EOM
        read foo
        echo "Reading AD, this will take hours if you have thousands of records"



while read INPUT; \
do printf "$INPUT\r" && echo $INPUT >> $LOGFILE && `#Echo current host being created and write to log file`\
dhcpgen \
-t d \
-a $(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//') `#Generate random MAC Addresses using openssl and format correct via sed`\
-n $INPUT $DEST; \
done \
< <(ldapsearch -E pr=10000/noprompt -H $HOST \
-D "$USER" \
-w $PASS \
-b "$BASEDN" '(objectClass=computer)' \
\
| awk '/name: / {print $2}')
