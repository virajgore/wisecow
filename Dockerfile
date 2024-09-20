[ec2-user@ip-172-31-45-11 wisecow]$ cat Dockerfile 
# Use Ubuntu as the base image
FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Update and install required packages
RUN apt-get update && apt-get install -y \
    cowsay \
    fortune-mod \
    netcat \
    && rm -rf /var/lib/apt/lists/*

# Ensure cowsay and fortune are in the PATH
ENV PATH="/usr/games:${PATH}"

# Create a directory for our application
WORKDIR /app

# Copy the wisecow.sh script into the container
COPY wisecow.sh /app/wisecow.sh

# Make sure the script is executable
RUN chmod +x /app/wisecow.sh

# Expose the port the app runs on
EXPOSE 4499

# Add debugging steps
RUN echo "#!/bin/bash" > /entrypoint.sh && \
    echo "set -x" >> /entrypoint.sh && \
    echo "echo 'Checking prerequisites:'" >> /entrypoint.sh && \
    echo "which cowsay" >> /entrypoint.sh && \
    echo "which fortune" >> /entrypoint.sh && \
    echo "which nc" >> /entrypoint.sh && \
    echo "echo 'Running wisecow.sh:'" >> /entrypoint.sh && \
    echo "/app/wisecow.sh" >> /entrypoint.sh && \
    chmod +x /entrypoint.sh

# Use the new entrypoint script
CMD ["/entrypoint.sh"]
