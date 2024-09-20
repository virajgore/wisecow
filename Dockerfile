# Use Ubuntu as the base image
FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Update and install required packages
RUN apt-get update && apt-get install -y \
    cowsay \
    fortune \
    netcat \
    && rm -rf /var/lib/apt/lists/*

# Create a directory for our application
WORKDIR /app

# Copy the wisecow.sh script into the container
COPY wisecow.sh /app/wisecow.sh

# Make sure the script is executable
RUN chmod +x /app/wisecow.sh

# Expose the port the app runs on
EXPOSE 4499

# Run the script
CMD ["/app/wisecow.sh"]