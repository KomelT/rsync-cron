FROM archlinux:latest

RUN pacman -Syy 

RUN pacman -S cron rsync openssh --noconfirm

RUN (crontab -l ; echo "0 2 * * * /scripts/script.sh") 2>&1 | grep -v "no crontab" | sort | uniq | crontab -

RUN crond

ENTRYPOINT ["/scripts/entrypoint.sh"]