FROM archlinux:latest

RUN pacman -Syy 

RUN pacman -S cron rsync openssh zip --noconfirm

RUN (crontab -l ; echo "0 2 * * * /scripts/script.sh") 2>&1 | grep -v "no crontab" | sort | uniq | crontab -

CMD ["/bin/bash"]