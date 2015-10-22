#!/bin/sh
#############################################
## Written by Mark Mayer Feb, 17th 2015 to ##
##    unmap volumes - PROD_FLEX_CLUSTER    ##
#############################################


#PROD_FLEX_STORE
esxcli storage vmfs unmap --volume-uuid=53ea43cc-2f014dec-b179-0090fa2cf430
esxcli storage vmfs unmap --volume-uuid=53ea43e7-b1253d4f-551e-0090fa2cf430
esxcli storage vmfs unmap --volume-uuid=53ea4407-ca4a6d36-ff5e-0090fa2cf430
esxcli storage vmfs unmap --volume-uuid=53ea4421-879ef324-211f-0090fa2cf430
esxcli storage vmfs unmap --volume-uuid=53ea4435-b9897516-7892-0090fa2cf430


#SQL_STORE
esxcli storage vmfs unmap --volume-uuid=54920fc6-5af7ccd6-22aa-0090fa2cf430
esxcli storage vmfs unmap --volume-uuid=54920fda-b5d0f77e-08dd-0090fa2cf430
esxcli storage vmfs unmap --volume-uuid=54920fef-1a7abda8-3438-0090fa2cf430


#VMFS_ISO
esxcli storage vmfs unmap --volume-uuid=4bec21fd-7551d20c-e225-001517dca68d


exit 0