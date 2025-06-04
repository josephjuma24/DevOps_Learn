feature/install-containerd-wsl
I created a script to install and configure containerd on Ubuntu WSL.
This script automates the installation of containerd.io on an Ubuntu system, specifically tailored for WSL environments.

It performs the following actions:
1. Updates apt package index.
2. Installs prerequisite packages (ca-certificates, curl, apt-transport-https, gnupg, lsb-release).
3. Adds Docker's official GPG key.
4. Sets up Docker's stable apt repository.
5. Installs containerd.io.
6. Creates the /etc/containerd directory.
7. Generates a default containerd configuration file (`/etc/containerd/config.toml`).
8. Modifies the configuration to set `SystemdCgroup = true` for compatibility with systemd-based cgroups, which is common in WSL setups.
9. Restarts the containerd service to apply the new configuration.
10. Makes the script executable.
