#!/bin/bash
set -m

mongodb_cmd="mongod"
#cmd="$mongodb_cmd --httpinterface --rest --master --smallfiles"
#cmd="$mongodb_cmd --httpinterface --rest --smallfiles"
cmd="$mongodb_cmd --smallfiles --logpath=/dev/null"
if [ "$AUTH" == "yes" ]; then
    cmd="$cmd --auth"
fi

if [ "$JOURNALING" == "no" ]; then
    cmd="$cmd --nojournal"
fi

if [ "$OPLOG_SIZE" != "" ]; then
    cmd="$cmd --oplogSize $OPLOG_SIZE"
fi

if [ "BIND_IPS" != "" ]; then
    cmd="$cmd --bind_ip $BIND_IPS"
fi

if [ "REPLSET" != "" ]; then
    cmd="$cmd --replSet $REPLSET"
fi

$cmd &

if [ ! -f /data/db/.mongodb_password_set ]; then
    /set_mongodb_password.sh
fi

fg