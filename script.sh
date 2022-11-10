#!/bin/bash

date=$(date "+%y-%m-%d_%H:%M:%S")
daten=$(date "+%u")


mkdir -p /backup/daily/ /backup/weekly/ /backup/logs/

echo "---- ${date} ----" >> /backup/logs/daily.log

if [[daten -eq 7 ]]; then
    echo "---- ${date} ----" >> /backup/logs/weekly.log

    rsync -rPu -e 'ssh -i /scripts/key -o "StrictHostKeyChecking no"' "${SSH_STR}:${PAT_TO_ORIG}" /backup/weekly
    echo "Rsync exit code: ${?}" >> /backup/logs/weekly.log
fi

rsync -rPu -e 'ssh -i /scripts/key -o "StrictHostKeyChecking no"' "${SSH_STR}:${PAT_TO_ORIG}" /backup/daily
echo "Rsync exit code: ${?}" >> /backup/logs/daily.log