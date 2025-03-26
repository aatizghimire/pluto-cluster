#!/bin/bash
# Install NVIDIA drivers and CUDA toolkit
pdsh -w master,c[1-3] "dnf install -y nvidia-driver cuda-toolkit-12-0"

# Verify GPU detection
nvidia-smi

# Update SLURM configuration to include GPU resources
cat <<EOF >> /etc/slurm/slurm.conf
GresTypes=gpu
NodeName=master Gres=gpu:1
NodeName=c1 Gres=gpu:1
NodeName=c2 Gres=gpu:1
NodeName=c3 Gres=gpu:1
PartitionName=main Nodes=master,c[1-3] Default=YES MaxTime=INFINITE State=UP
EOF
pdsh -w c[1-3] "scp master:/etc/slurm/slurm.conf /etc/slurm/slurm.conf"

# Restart SLURM services
systemctl restart slurmctld  # On master
pdsh -w c[1-3] "systemctl restart slurmd"

# Test GPU availability
scontrol show node  # Check GPU resources
sbatch <<EOF
#!/bin/bash
#SBATCH --job-name=gpu_test
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
nvidia-smi
EOF