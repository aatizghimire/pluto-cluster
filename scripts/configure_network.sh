#!/bin/bash
# Configure static IPs using nmtui (interactive tool, run manually on each node)
nmtui

# Example /etc/hosts configuration
cat <<EOF >> /etc/hosts
10.80.0.100 master
10.80.0.101 c1
10.80.0.102 c2
10.80.0.103 c3
EOF

# Set hostname (run on respective nodes)
echo "master" > /etc/hostname  # On master node
# echo "c1" > /etc/hostname    # On c1 node, etc.