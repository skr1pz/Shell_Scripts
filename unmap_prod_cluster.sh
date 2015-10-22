#!/bin/sh
#############################################
## Written by Mark Mayer Feb, 17th 2015 to ##
##    unmap volumes - prod_cluster         ##
#############################################


#PROD_VM_STORE
esxcli storage vmfs unmap --volume-uuid=53037250-bbfa8852-cdba-3440b5a18f7c
esxcli storage vmfs unmap --volume-uuid=5303741e-949e0e6a-52ae-3440b5a18f7c
esxcli storage vmfs unmap --volume-uuid=530375e4-aa08fa8f-c432-3440b5a18f7c
esxcli storage vmfs unmap --volume-uuid=530377bb-48329997-7b34-3440b5a18f7c
esxcli storage vmfs unmap --volume-uuid=53037b64-c804a728-aa5a-3440b5a18f7c


#VMFS_ISO
esxcli storage vmfs unmap --volume-uuid=4bec21fd-7551d20c-e225-001517dca68d


exit 0