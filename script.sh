#!/bin/bash

date=$(date "+%y-%m-%d_%H:%M:%S")
daten=$(date "+%u")


mkdir -p /backup/daily/ /backup/weekly/ /backup/logs/

echo "---- ${date} ----" >> /backup/logs/daily.log

if [[ $daten -eq 7 ]]; then
    echo "---- ${date} ----" >> /backup/logs/weekly.log

    size1=$(du -sh /backup/weekly | cut -f1)
    start=`date +%s`
    rsync -rPu -e 'ssh -i /scripts/key -o "StrictHostKeyChecking no"' "${SSH_STR}:${PATH_TO_ORIG}" /backup/weekly
    echo "Rsync exit code: ${?}" >> /backup/logs/weekly.log
    end=`date +%s`
    size2=$(du -sh /backup/weekly | cut -f1)
    runtime=$((end-start))

    echo "  time: ${runtime}s"
    echo "  size: from ${size1} to ${size2}"
fi

size1=$(du -sh /backup/daily | cut -f1)
start=`date +%s`
rsync -rPu -e 'ssh -i /scripts/key -o "StrictHostKeyChecking no"' "${SSH_STR}:${PATH_TO_ORIG}" /backup/daily
echo "Rsync exit code: ${?}" >> /backup/logs/daily.log
end=`date +%s`
size2=$(du -sh /backup/daily | cut -f1)
runtime=$((end-start))

echo "  time: ${runtime}s"
echo "  size: from ${size1} to ${size2}"