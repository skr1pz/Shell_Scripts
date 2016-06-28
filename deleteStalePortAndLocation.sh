#!/usr/local/bin/bash
##########################################################
# This script deletes endpoint associations from the     #
# port_connection table and port entries in network_port #
# that are older than the scanning interval plus 24      #
# hrs.  Written for BMO.                                 #
#                                                        #
# $Id: deleteStalePortAndLocation.sh 2016-06-22 mmayer $ #
##########################################################

if [ `whoami` != beacon ]; then
   echo "The script may be run only as user 'beacon'"
   exit 1
fi


_pgSQL=`which psql`


mkdir -p -m 777 /home/beacon/staleData/networkPort
mkdir -p -m 777 /home/beacon/staleData/portCon


#Iterate through list until complete 
while read NID; do


#Copy before delete to file
#Delete entries in port_connection for specific NIDs and entries in the network_port table that are older than the max_scan interval plus 24 hrs
#Copy after delete to file
$_pgSQL>/dev/null 2>&1 <<EOF


COPY (SELECT * FROM port_connection WHERE device_ip='$NID' ORDER BY updated DESC) TO '/home/beacon/staleData/portCon/before_$NID.csv' DELIMITER ',' CSV HEADER;


DELETE FROM port_connection WHERE device_ip='$NID' AND updated < NOW() - ((SELECT max_scan FROM server_config) || ' MINS')::INTERVAL - '1 DAYS'::INTERVAL;


COPY (SELECT * FROM port_connection WHERE device_ip='$NID' ORDER BY updated DESC) TO '/home/beacon/staleData/portCon/after_$NID.csv' DELIMITER ',' CSV HEADER;


COPY (SELECT * FROM network_port WHERE device_ip='$NID' ORDER BY updated DESC) TO '/home/beacon/staleData/networkPort/before_$NID.csv' DELIMITER ',' CSV HEADER;


DELETE FROM network_port WHERE device_ip='$NID' AND updated < NOW() - ((SELECT max_scan FROM server_config) || ' MINS')::INTERVAL - '1 DAYS'::INTERVAL;


COPY (SELECT * FROM network_port WHERE device_ip='$NID' ORDER BY updated DESC) TO '/home/beacon/staleData/networkPort/after_$NID.csv' DELIMITER ',' CSV HEADER;


EOF


done < NIDList.txt



#Optimize networks
$_pgSQL>/dev/null 2>&1 <<EOF


SELECT optimize_network_device_config();


EOF
