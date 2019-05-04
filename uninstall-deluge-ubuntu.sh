#!/bin/sh

echo "*******************************************************"
echo "Removing Deluge"
echo "*******************************************************"

systemctl stop deluged
systemctl disable deluged
rm /etc/systemd/system/deluged.service

systemctl stop deluge-web
systemctl disable deluge-web
rm /etc/systemd/system/deluge-web.service
systemctl daemon-reload
systemctl reset-failed

sudo apt-get -y remove deluged deluge-webui
echo " "
echo "Done!"
echo " "
