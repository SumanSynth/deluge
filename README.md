# Install Deluge on Ubuntu 18.04 LTS Server

Deluge is a popular multi-platform bittorrent client often used to provide torrenting / seedbox functionality on Linux servers. Like rTorrent, deluge uses libtorrent as its backend. Supported by daemon-service, awesome interface, and great plugin support, Deluge surpass Transmission and rTorrent for functionality.

## Method 1: Using script
Open terminal and enter following commands:

    wget https://raw.githubusercontent.com/sumancvb/deluge/master/install-deluge-ubuntu.sh && sudo sh install-deluge-ubuntu.sh

#### Accessing Deluge.
Deluge will be available on HTTP port 8112 by default. Open your favorite browser and navigate to http://yourdomain.com:8112 or http://server-ip:8112.  The default password for deluge is deluge, better change it when you are first to login.

#### Check services

    sudo systemctl status deluged
    sudo systemctl status deluge-web

#### Uninstall Deluge
Run following command in terminal

    wget https://raw.githubusercontent.com/sumancvb/deluge/master/uninstall-deluge-ubuntu.sh && sudo sh uninstall-deluge-ubuntu.sh
## Method 2: Step by step guide
#### Step 1. First make sure that all your system packages are up-to-date

    sudo apt-get update
    
#### Step 2. Installing Deluge on Ubuntu 18.04 LTS.

    sudo add-apt-repository ppa:deluge-team/ppa
    sudo apt install deluged deluge-webui
    sudo adduser --system --group deluge
    sudo gpasswd -a $USER deluge
    
#### Step 3. Create Systemd Service.

    nano /etc/systemd/system/deluged.service
    
Add following lines:

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
    
Now start deluge deamon with the following command:

    systemctl start deluged
    systemctl enable deluged
    
Next, we create a systemd service file for deluge web:

    nano /etc/systemd/system/deluge-web.service
    
Add following lines:

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
    
Save and close the file also start and enable deluge-web:

    systemctl start deluge-web
    systemctl enable deluge-web

#### Step 4. Accessing Deluge.
Deluge will be available on HTTP port 8112 by default. Open your favorite browser and navigate to http://yourdomain.com:8112 or http://server-ip:8112.  The default password for deluge is deluge, better change it when you are first to login.
