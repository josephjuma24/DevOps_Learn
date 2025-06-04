#!/bin/bash
# This script will install containerd

# Exit immediately if a command exits with a non-zero status.
set -e

# Update the apt package index and install packages to allow apt to use a repository over HTTPS:
sudo apt-get update
sudo apt-get install -y ca-certificates curl

# Add Docker's official GPG key:
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install containerd.io
# The documentation states that installing docker-ce will also install containerd.io
# We can install containerd.io directly as well.
# Let's try installing only containerd.io first.
# If that doesn't work or is not the recommended way,
# we can change this to install docker-ce, which bundles containerd.io.
sudo apt-get install -y containerd.io

# Create /etc/containerd directory
sudo mkdir -p /etc/containerd

# Generate default containerd config
sudo sh -c 'containerd config default > /etc/containerd/config.toml'

# Set SystemdCgroup to true
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml

# Restart containerd service
sudo systemctl restart containerd

# Verify installation (optional, but good practice)
# We can add a command here to check if containerd is running, e.g.:
# systemctl status containerd
# For now, the script will exit with 0 if all commands above were successful.

echo "Containerd installation script finished."
exit 0
