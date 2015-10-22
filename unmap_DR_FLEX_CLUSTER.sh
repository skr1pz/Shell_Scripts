#!/bin/sh
#############################################
## Written by Mark Mayer Feb, 17th 2015 to ##
##    unmap volumes - DR_FLEX_CLUSTER      ##
#############################################


#DR_VM_STORE
esxcli storage vmfs unmap --volume-uuid=530b3cc8-d0139ffb-ada8-0090fa3bd4b2
esxcli storage vmfs unmap --volume-uuid=530e1cc8-7ff4404c-207f-0090fa3bee24
esxcli storage vmfs unmap --volume-uuid=530e1cea-a3610062-e2a2-0090fa3bee24
esxcli storage vmfs unmap --volume-uuid=530e1d02-1e8b9908-27f9-0090fa3bee24
esxcli storage vmfs unmap --volume-uuid=530e1e33-5edba59c-ac38-0090fa3bee24


#DR_SQL_STORE
esxcli storage vmfs unmap --volume-uuid=546a1fa3-1fe9982f-09eb-0090fa3bd4b2
esxcli storage vmfs unmap --volume-uuid=546a1fe2-4f46f46c-438a-0090fa3bd4b2
esxcli storage vmfs unmap --volume-uuid=546a203a-137ad973-2a30-0090fa3bd4b2


#VMFS_ISO
esxcli storage vmfs unmap --volume-uuid=54381e8a-d783ff5e-05cc-0090fa2cd73a


exit 0