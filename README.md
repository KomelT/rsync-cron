# Rsync Cron

Container to run script with Rsync at 2:00 am.

**Mount**
`/scripts:/local/folder/with/script`

**ENV**

```
SSH_STR=username@remote_hostname
PATH_TO_ORIG=/path/on/remote # pat to folder wich has to be backed up
```

**Dockerfile**

```
FROM archlinux:latest

RUN pacman -Syy

RUN pacman -S cron rsync openssh zip --noconfirm

RUN (crontab -l ; echo "0 2 * * * /scripts/script.sh") 2>&1 | grep -v "no crontab" | sort | uniq | crontab -

CMD ["/bin/bash"]
```
