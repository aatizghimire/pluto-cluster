#!/bin/bash
# Install Rocky Linux 9.4 on each node (manual step, followed by updates)
dnf update -y
# Set root password (replace 'your_password' with a secure password)
echo "your_password" | passwd --stdin root