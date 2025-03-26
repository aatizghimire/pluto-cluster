#!/bin/bash
# Install Lua and Lmod dependencies
pdsh -w master,c[1-3] "dnf install -y lua lua-devel tcl"

# Install Lmod (may require building from source or using a package manager)
pdsh -w master,c[1-3] "dnf install -y lmod"

# Configure Lmod - ensure module path is set
echo "export MODULEPATH=/usr/share/modulefiles:/opt/apps/modulefiles" >> /etc/profile.d/lmod.sh

# Install Anaconda in a shared directory
wget https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Linux-x86_64.sh -O /mnt/storage0/anaconda.sh
bash /mnt/storage0/anaconda.sh -b -p /mnt/storage0/anaconda3
rm /mnt/storage0/anaconda.sh

# Create Lmod module file for Anaconda
mkdir -p /opt/apps/modulefiles/anaconda
cat <<EOF > /opt/apps/modulefiles/anaconda/2023.09.lua
whatis("Anaconda 2023.09 for Python workflows")
prepend_path("PATH", "/mnt/storage0/anaconda3/bin")
EOF

# Verify Lmod
source /etc/profile.d/lmod.sh
module avail  # List available modules
module load anaconda/2023.09  # Test loading Anaconda