# Use an Ubuntu base image
FROM ubuntu:latest

# Set root password
RUN echo 'root:root' | chpasswd

# Install necessary packages
RUN apt-get update && apt-get install -y \
    sudo \
    openssh-server \
    nano \
    vim

# Create a directory for the SSH service
RUN mkdir -p /run/sshd

# Enable root login via SSH
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Allow root login with password
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Expose SSH port
EXPOSE 22

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]
