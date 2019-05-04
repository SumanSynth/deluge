#!/bin/sh

echo "*******************************************************"
echo "Removing Deluge"
echo "*******************************************************"

systemctl stop deluged.service
systemctl disable deluged.service
sudo rm /etc/systemd/system/deluged.service

systemctl stop deluge-web.service
systemctl disable deluge-web.service
sudo rm /etc/systemd/system/deluge-web.service
systemctl daemon-reload
systemctl reset-failed

sudo apt-get -y remove deluged deluge-webui
echo " "
echo "Done!"
echo " "
