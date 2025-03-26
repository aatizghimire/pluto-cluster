#!/bin/bash
# Install Ganglia on all nodes
pdsh -w master,c[1-3] "dnf install -y ganglia ganglia-gmond ganglia-gmetad"
systemctl enable gmond gmetad
systemctl start gmond gmetad

# Install Fail2Ban for security
pdsh -w master,c[1-3] "dnf install -y fail2ban"
systemctl enable fail2ban
systemctl start fail2ban