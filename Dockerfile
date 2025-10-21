FROM debian:bookworm-slim

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install sudo and SSH server
RUN apt-get update && \
    apt-get install -y sudo openssh-server && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    mkdir /var/run/sshd

# Install essential packages
RUN apt-get update && apt-get install -y \
    bash-completion less nano git gitk curl wget jq tree file \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create user with sudo privileges
RUN groupadd devuser && \
    useradd -g devuser -m -s /bin/bash devuser && \
    echo "devuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Expose SSH port
EXPOSE 22

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]
