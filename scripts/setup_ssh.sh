#!/bin/bash
# Install SSH
dnf install -y openssh-server openssh-clients
systemctl enable sshd
systemctl start sshd

# Generate SSH keys on master node
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa

# Copy keys to all nodes (replace 'your_password' with root password)
for node in c1 c2 c3; do
    ssh-copy-id -i ~/.ssh/id_rsa.pub root@$node
done

# Test passwordless SSH
ssh root@c1 "echo SSH working"