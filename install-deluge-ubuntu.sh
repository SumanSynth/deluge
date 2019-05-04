#!/bin/sh

sudo apt-get update
sudo add-apt-repository ppa:deluge-team/ppa
sudo apt install deluged deluge-webui
sudo adduser --system --group deluge
sudo gpasswd -a idroot deluge

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

systemctl start deluged
systemctl enable deluged

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

systemctl start deluge-web
systemctl enable deluge-web
