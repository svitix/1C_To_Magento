#!/bin/sh -
/usr/local/bin/sabcmd /usr/home/1cimport/sync-tyres-xml/tyresmag.xslt /smb/ShareShop/tyres/1cbitrix/import.xml > /usr/home/1cimport/tyresmag.csv
cd /use/home/1cimport
awk -f tyres0.awk tyresmag.csv > tyres.csv
awk -f tyres1.awk tyres.csv > tyresmag-import.csv
awk -f tyres0woi.awk tyresmag.csv > tyres2.csv
awk -f tyres1.awk tyres2.csv > tyresmag-import-woi.csv


rm tyres.csv tyres2.csv

