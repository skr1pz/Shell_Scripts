#!/bin/sh
#############################################
## Written by Mark Mayer Feb, 17th 2015 to ##
##    unmap volumes -   DR_PROD_CLUSTER    ##
#############################################


#DR_PROD_VM_STORE
esxcli storage vmfs unmap --volume-uuid=5498b760-4463da30-7d5f-e41f13617730
esxcli storage vmfs unmap --volume-uuid=5498b799-7ff60f48-cbb3-e41f13617730
esxcli storage vmfs unmap --volume-uuid=5498b7c2-1005403c-e9a4-e41f13617730


#VMFS_ISO
esxcli storage vmfs unmap --volume-uuid=54381e8a-d783ff5e-05cc-0090fa2cd73a


exit 0