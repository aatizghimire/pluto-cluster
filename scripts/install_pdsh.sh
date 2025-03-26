#!/bin/bash
# Install pdsh on master node
dnf install -y pdsh

# Example: Install a package on all nodes
pdsh -w master,c[1-3] "dnf install -y vim"