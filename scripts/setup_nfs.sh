#!/bin/bash
# Install NFS on master node
dnf install -y nfs-utils
systemctl enable nfs-server
systemctl start nfs-server

# Configure NFS exports
echo "/mnt/storage0 10.80.0.0/24(rw,sync,no_subtree_check)" >> /etc/exports
exportfs -ra

# Mount NFS on compute nodes
pdsh -w c[1-3] "dnf install -y nfs-utils"
pdsh -w c[1-3] "mkdir -p /mnt/storage0"
pdsh -w c[1-3] "mount 10.80.0.100:/mnt/storage0 /mnt/storage0"
pdsh -w c[1-3] "echo '10.80.0.100:/mnt/storage0 /mnt/storage0 nfs defaults 0 0' >> /etc/fstab"