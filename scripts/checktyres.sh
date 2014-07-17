#!/bin/sh

STATEFILE='/usr/home/1cimport/tyres.state'

if [ -f $STATEFILE ]; then
    AAA=`stat -f%Sm -t'%Y.%m.%d.%H.%M.%S' /smb/ShareShop/tyres/1cbitrix/import.xml`
    BBB=`cat $STATEFILE  | awk '{print $1}'`
    if [ "$AAA"  != "$BBB" ]; then
	/usr/home/1cimport/tyres.sh
	echo "New import tyres ready" | mail -s "Import tyres from $AAA" email@email.com
        echo `stat -f%Sm -t'%Y.%m.%d.%H.%M.%S' /smb/ShareShop/tyres/1cbitrix/import.xml` > $STATEFILE
    else 
#	echo "Nothing to change"
    fi
else
    AAA=`stat -f%Sm -t'%Y.%m.%d.%H.%M.%S' /smb/ShareShop/tyres/1cbitrix/import.xml`
    /usr/home/1cimport/tyres.sh
    echo "New import tyres ready" | mail -s "Import tyres from $AAA" email@email.com
    echo `stat -f%Sm -t'%Y.%m.%d.%H.%M.%S' /smb/ShareShop/tyres/1cbitrix/import.xml` > $STATEFILE
fi

