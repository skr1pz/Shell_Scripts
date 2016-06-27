#!/bin/sh

#################################################
# Author: Mark Mayer                            #
# Date: 20160627                                #
# Finds all VMIDs and pipes to power on command #
#################################################



for z in $(vim-cmd vmsvc/getallvms | awk '{print $1}' | egrep '^[0-9]'); do vim-cmd vmsvc/power.on $z; done
