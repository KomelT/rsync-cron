# Rsync Cron

Container to run script with Rsync at 2:00 am.

**Mount**
`/scripts:/local/folder/with/script`

**Dockerfile**

```
FROM ubuntu:latest

RUN apt update && apt -y install cron rsync ssh

RUN (crontab -l ; echo "0 3 * * * /scripts/script.sh") 2>&1 | grep -v "no crontab" | sort | uniq | crontab -

RUN cron

CMD ["/bin/bash"]
```
