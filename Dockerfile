FROM ubuntu:24.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install essential packages
# RUN apt-get update && apt-get install -y \
#     sudo \
#     openssh-server \
#     git \
#     gitk \
#     curl \
#     wget \
#     jq \
#     && rm -rf /var/lib/apt/lists/*

CMD ["sleep", "infinity"]
