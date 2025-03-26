#!/bin/bash
# Install and configure NTP using pdsh
pdsh -w master,c[1-3] "dnf install -y chrony"
pdsh -w master,c[1-3] "systemctl enable --now chronyd"

# Set master as NTP server (edit /etc/chrony.conf on master)
echo "allow 10.80.0.0/24" >> /etc/chrony.conf
systemctl restart chronyd