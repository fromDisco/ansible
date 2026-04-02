#!/bin/bash
# export PATH so that we can use e.g. apt-get instead of /usr/bin/apt-get
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin

echo "update package lists"
apt-get update

systemctl stop tomcat
sleep 30

if /scripts/cronjob-shellscript.sh
  then
    echo "cronjob-shellscript.sh was excecuted"
  else
    echo "ERROR during cronjob-shellscript.sh"
    systemctl start tomcat
    exit
fi

echo "do security upgrades"
unattended-upgrade -v


if [ -f /var/run/reboot-required ];
  then
    echo "rebooting System after security updates"
    reboot now
  else
    echo "no restart required. Starting tomcat"
    systemctl start tomcat
fi
