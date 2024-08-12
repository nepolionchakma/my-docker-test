# Use an official Ubuntu as a parent image
FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && \
    apt-get install -y sudo \
                       openssh-server \
                       vim \
                       curl

# Create a user and set up a password (in this example, we're using "root" for simplicity)
RUN useradd -ms /bin/bash user && \
    echo 'user:root' | chpasswd

# Expose the SSH port
EXPOSE 22

# Start the SSH service
CMD ["/usr/sbin/sshd", "-D"]
