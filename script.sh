#!/bin/bash

date=$(date "+%y-%m-%d_%H:%M:%S")
daten=$(date "+%u")

mkdir -p /backup/daily/ /backup/weekly/

if [[daten -eq 7 ]]; then
    rsync -rPu -e 'ssh -i /scripts/key -o "StrictHostKeyChecking no"' "${SSH_STR}:${PAT_TO_ORIG}" /backup/weekly
fi

rsync -rPu -e 'ssh -i /scripts/key -o "StrictHostKeyChecking no"' "${SSH_STR}:${PAT_TO_ORIG}" /backup/daily