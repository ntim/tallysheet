#!/bin/sh
D=`date +%w`
cp -f /root/tallysheet/db/production.sqlite3 /root/tallysheet/db/production.sqlite3.bak.$D
