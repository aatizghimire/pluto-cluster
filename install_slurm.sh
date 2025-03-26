#!/bin/bash
# Install SLURM dependencies and MUNGE for authentication
pdsh -w master,c[1-3] "dnf install -y epel-release"
pdsh -w master,c[1-3] "dnf install -y munge munge-libs munge-devel"

# Install SLURM (version 22.05) - may require building from source
pdsh -w master,c[1-3] "dnf install -y slurm-22.05* slurm-devel slurm-slurmd slurm-slurmctld"

# Generate MUNGE key on master and copy to compute nodes
dd if=/dev/urandom bs=1 count=1024 > /etc/munge/munge.key
chown munge:munge /etc/munge/munge.key
chmod 400 /etc/munge/munge.key
pdsh -w c[1-3] "scp master:/etc/munge/munge.key /etc/munge/munge.key"
pdsh -w c[1-3] "chown munge:munge /etc/munge/munge.key; chmod 400 /etc/munge/munge.key"

# Start MUNGE service
pdsh -w master,c[1-3] "systemctl enable munge"
pdsh -w master,c[1-3] "systemctl start munge"

# Basic SLURM configuration (/etc/slurm/slurm.conf) - example snippet
cat <<EOF > /etc/slurm/slurm.conf
ControlMachine=master
NodeName=master,c[1-3] CPUs=4 RealMemory=16000 State=UNKNOWN
PartitionName=main Nodes=master,c[1-3] Default=YES MaxTime=INFINITE State=UP
EOF
pdsh -w c[1-3] "scp master:/etc/slurm/slurm.conf /etc/slurm/slurm.conf"

# Start SLURM services
systemctl enable slurmctld  # On master only
systemctl start slurmctld   # On master only
pdsh -w c[1-3] "systemctl enable slurmd"
pdsh -w c[1-3] "systemctl start slurmd"

# Verify SLURM
sinfo  # Check cluster status