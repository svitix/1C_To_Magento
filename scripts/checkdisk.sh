#!/bin/sh

STATEFILE='/usr/home/1cimport/disks.state'

if [ -f $STATEFILE ]; then
    AAA=`/usr/bin/stat -f%Sm -t'%Y.%m.%d.%H.%M.%S' /smb/ShareShop/disk/1cbitrix/import.xml`
    BBB=`cat $STATEFILE  | awk '{print $1}'`
    if [ "$AAA"  != "$BBB" ]; then
	/usr/home/1cimport/disks.sh
	echo "New import ready" | mail -s "Import disks from $AAA" email@email.com
        echo `/usr/bin/stat -f%Sm -t'%Y.%m.%d.%H.%M.%S' /smb/ShareShop/disk/1cbitrix/import.xml` > $STATEFILE
    else 
#	echo "Nothing to change"
    fi
else
    AAA=`/usr/bin/stat -f%Sm -t'%Y.%m.%d.%H.%M.%S' /smb/ShareShop/disk/1cbitrix/import.xml`
    /usr/home/1cimport/disks.sh
    echo "New import ready" | mail -s "Import disks from $AAA" email@email.com
    echo `/usr/bin/stat -f%Sm -t'%Y.%m.%d.%H.%M.%S' /smb/ShareShop/disk/1cbitrix/import.xml` > $STATEFILE
fi

