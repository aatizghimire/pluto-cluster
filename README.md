# Cost-Effective Deep Learning Infrastructure with NVIDIA GPU

This documentation outlines the setup of a cost-effective High-Performance Computing (HPC) cluster using commodity hardware and NVIDIA GTX 1650 GPUs, as detailed in the research paper by Aatiz Ghimire et al. The approach is tailored for resource-constrained environments like Nepal, leveraging existing lab computers and open-source software to support deep learning and parallel computing tasks.

## Overview

- **Objective**: Build an affordable HPC cluster for deep learning using commonly available hardware.
- **Hardware**: Four computers with NVIDIA GTX 1650 GPUs, Intel i5 CPUs, and 16 GB RAM each.
- **Software**: Rocky Linux 9.4, SLURM, Lmod, Anaconda, MPI, and monitoring tools like Ganglia.
- **Key Features**: Cost efficiency, scalability, centralized management, and enhanced security.

## Cluster Configuration

### Hardware Setup

- **Master Node**: IP `10.80.0.100`, Intel i5 CPU, 16 GB RAM, NVIDIA GTX 1650 GPU.
- **Compute Nodes**: `c1`, `c2`, `c3` (IPs `10.80.0.101-103`), same specs as the master node.
- **Storage**: 1TB shared storage mounted at `/mnt/storage0`.
- **Network**: 1 Gbps Ethernet via CAT6 cables and a switch.

### Software Stack

| Software      | Version  | Purpose                  |
|---------------|----------|--------------------------|
| Rocky Linux   | 9.4      | Operating System         |
| SLURM         | 22.05    | Job Scheduling           |
| Lmod          | Installed| Environment Management   |
| Anaconda      | 2023.09  | Python-based Workflows   |

## Key Steps for Setup

The following steps outline the process to replicate the cluster setup. Detailed Linux commands are provided in separate files.

1. **Operating System Installation**
   - Install Rocky Linux 9.4 on all nodes.
   - Configure root user with a uniform password for simplicity.

2. **Network Configuration**
   - Assign static IPs using `nmtui`.
   - Update `/etc/hosts` and `/etc/hostname` for node communication.

3. **SSH Setup**
   - Install SSH and configure passwordless access between nodes.

4. **Software Deployment**
   - Use `pdsh` for parallel software installation across nodes.
   - Install essential packages like NTP, MUNGE, and NFS.

5. **Storage Configuration**
   - Mount 1TB storage at `/mnt/storage0` and set up NFS for sharing.

6. **User Management**
   - Implement FreeIPA for centralized authentication.

7. **SLURM Setup**
   - Install SLURM (version 22.05) for job scheduling.
   - Configure MUNGE for authentication and SLURM for resource management.

8. **Environment Management with Lmod and Lua**
   - Install Lmod with Lua support for dynamic environment module management.
   - Set up Anaconda and multiple Python versions using Lmod.

9. **Parallel Computing**
   - Set up MPICH for MPI and integrate with SLURM.

10. **GPU Configuration with SLURM**
    - Configure NVIDIA GTX 1650 GPUs for CUDA.
    - Integrate GPU support into SLURM for single-node tasks.

11. **Monitoring and Security**
    - Deploy Ganglia for monitoring.
    - Enhance security with Fail2Ban to block unauthorized SSH attempts.

## Results

- **Cost Efficiency**: Local cluster costs NPR 5,760/month (electricity) vs. NPR 29,640/month for cloud-based NVIDIA T4 GPU rental.
- **Performance**: Effective for single-node GPU tasks and medium-scale MPI workloads.
- **Limitations**: No GPU clustering (lacks GPUDirect RDMA), Ethernet-based MPI communication.

## Conclusion

This setup provides a sustainable, cost-effective alternative to cloud-based solutions, ideal for academic and research institutions in developing countries. Future enhancements could include high-speed interconnects and advanced GPUs.

## Resources

- GitHub Repositories:
  - [Pluto Cluster Setup](https://github.com/aatizghimire/pluto-cluster)
  - [Deep Learning GPU SLURM Template](https://github.com/aatizghimire/deep-learning-gpu-slurm-template)