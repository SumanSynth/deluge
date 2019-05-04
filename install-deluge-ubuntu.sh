#!/bin/sh

echo "****************************************************"
echo "Updating the package database"
echo "****************************************************"

sudo apt-get -q update

echo "****************************************************"
echo "Adding ppa:deluge-team/ppa"
echo "****************************************************"

sudo add-apt-repository -y ppa:deluge-team/ppa

echo "****************************************************"
echo "Installing Deluge Bittorrent Client with Web Interface"
echo "****************************************************"

sudo apt-get -yq install deluged deluge-webui curl
sudo adduser --system --group deluge
sudo gpasswd -a "$USER" deluge

echo "****************************************************"
echo "Creating deluged.service"
echo "****************************************************"

cat > /etc/systemd/system/deluged.service <<'EOF'
[Unit]

Description=Deluge Bittorrent Client Daemon
After=network-online.target

[Service]
Type=simple
User=deluge
Group=deluge
UMask=007

ExecStart=/usr/bin/deluged -d

Restart=on-failure

# Configures the time to wait before service is stopped forcefully.
TimeoutStopSec=300

[Install]
WantedBy=multi-user.target
EOF

echo "****************************************************"
echo "Starting deluged.service "
echo "****************************************************"
systemctl daemon-reload
systemctl start deluged
systemctl enable deluged

echo "****************************************************"
echo "Creating deluge-web.service"
echo "****************************************************"

cat > /etc/systemd/system/deluge-web.service <<'EOF'
[Unit]
Description=Deluge Bittorrent Client Web Interface
After=network-online.target

[Service]
Type=simple

User=deluge
Group=deluge
UMask=027

ExecStart=/usr/bin/deluge-web

Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

echo "****************************************************"
echo "Starting deluge-web.service"
echo "****************************************************"
systemctl daemon-reload
systemctl start deluge-web
systemctl enable deluge-web

echo "****************************************************"
echo "Deluge will be available on HTTP port 8112 by default." 
echo "http://server-ip:8112."
echo "Your IP address is:"
curl ifconfig.me
echo ":8112"
echo "The default password for deluge is deluge."
echo "****************************************************"
