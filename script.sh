#!/bin/bash

date=$(date "+%y-%m-%d_%H:%M:%S")

mkdir /backup/tmp/

if [ "$(ls -A /backup/tmp)" != "" ]; then
    zip -r -9 "/backup/${date}_tmp.zip" /backup/tmp
    rm -r /backup/tmp/*
fi

rsync -az -P -e 'ssh -i /scripts/key -o "StrictHostKeyChecking no"' "${SSH_STR}:${PATH_TO_ORIG}" /backup/tmp

zip -r -9 "/backup/${date}.zip" /backup/tmp

rm -r /backup/tmp/*