# Use an official Ubuntu as a parent image
FROM ubuntu:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Update and install basic packages
RUN apt-get update && \
    apt-get install -y \
    sudo \
    vim \
    net-tools \
    iputils-ping \
    curl \
    wget \
    ssh \
    openssh-server \
    passwd

# Create a group 'admin' and add users to this group
RUN groupadd admin && \
    useradd -m -G admin -s /bin/bash web && \
    useradd -m -G admin -s /bin/bash app && \
    useradd -m -G admin -s /bin/bash dbs && \
    useradd -m -G admin -s /bin/bash def

# Set passwords for the users
RUN echo "web:webpassword" | chpasswd && \
    echo "app:apppassword" | chpasswd && \
    echo "dbs:dbspassword" | chpasswd && \
    echo "def:defpassword" | chpasswd

# Add all users to sudoers with no password required
RUN echo "%admin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Expose SSH port
EXPOSE 22

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]
