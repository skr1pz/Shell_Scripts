#!/bin/sh
###########################################################
# This script generates a Device Sponsorship CSV report   #
# to /tmp/sponsor which will need to be SCP'd off, it     #
# also truncates the timestamps to 19 characters so       #
# Excel can parse it properly, and it sets the            #
# timestamp to their local time; this needs to be changed #
# per customer.                                           #
# $Id: sponsorReport.sh 2016-03-23 18:40:12Z mmayer $     #
#                                                         #
# Changed: Appended 'EST' to the end of timestamps and    #
# added logfile timestamping to the output file name. -   #
# mmayer 20160323 / Added day filter mmayer 20160325      #
#                                                         #
# Added bash date command timezone and set to variable,   #
# appends customer's local timezone to time output and    #
# corrects time in Postgres DB - mmayer 20160328          #
#                   									  #
# Added argument for optional input to filter by number   #
# of days, no argument gives back all data - mmayer       #
# 20160328                                                #
###########################################################

LOGNAME="sponsorReport_"
DATELOCAL=$(date | awk '{print $2, $3, $6}' | sed -e 's/ /_/g')
NAMEANDDATE=$LOGNAME$DATELOCAL

TIMEZONE=$(date | awk '{print $5}')

#Checks to see if input parameter has been set, if it's empty all data is returned; if it is set then you're returning results within that many days
if [ -z "$1" ];
then 
      WHEREFILTER="data_name='SDAMatchingRule'"
else 
      WHEREFILTER="data_name='SDAMatchingRule' AND updated >= NOW() - INTERVAL '"${1}" days'"
fi


mkdir -p -m 0777 /tmp/sponsor


su - beacon -c psql <<EOF

COPY (SELECT 
	    serial_id, 
	    mac, 
	    data_value AS profile, 
	    source AS user, 
	    CAST(created AT TIME ZONE 'UTC' AT TIME ZONE '$TIMEZONE' AS varchar(19)) || ' $TIMEZONE'  AS created,     --timezone scrubbing for local time 
	    CAST(updated AT TIME ZONE 'UTC' AT TIME ZONE '$TIMEZONE' AS varchar(19)) || ' $TIMEZONE' AS updated,      --timezone scrubbing for local time
	    CAST(auto_expire AT TIME ZONE 'UTC' AT TIME ZONE '$TIMEZONE' AS varchar(19)) || ' $TIMEZONE' AS expires   --timezone scrubbing for local time
	  FROM user_data WHERE $WHEREFILTER) 
TO '/tmp/sponsor/$NAMEANDDATE.csv' DELIMITER ',' CSV HEADER;

EOF

#Timezone scubbing found here: http://stackoverflow.com/questions/21277170/postgresql-wrong-converting-from-timestamp-without-time-zone-to-timestamp-with-t
#We have to set timezone to UTC first for conversions to work based on timezone code, SELECT current_setting('TIMEZONE'); returns 'GMT'
