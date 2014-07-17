#!/bin/sh -
/usr/local/bin/sabcmd /usr/home/1cimport/sync-disks-xml/disksmag.xslt /smb/ShareShop/disk/1cbitrix/import.xml > /usr/home/1cimport/disksmag.csv
cd /usr/home/1cimport
awk -f disks0.awk disksmag.csv > disks.csv
awk -f disks1.awk disks.csv > disksmag-import.csv
awk -f disks0woi.awk disksmag.csv > disks2.csv
awk -f disks1.awk disks2.csv > disksmag-import-woi.csv

rm disks.csv disks2.csv
