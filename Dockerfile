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
    openssh-server

# Set up the root user password
RUN echo 'root:root' | chpasswd

# Expose SSH port
EXPOSE 3333

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]
