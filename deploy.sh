#!/bin/bash

# Check if a container named 'ztna-hol' already exists
echo "Checking if a container named 'ztna-hol' already exists..."
container_id=$(sudo docker ps -a -q -f name=ztna-hol)

if [ -n "$container_id" ]; then
	# Stop the container
	echo "Stopping container $container_id..."
	sudo docker stop "$container_id"
	echo "Done!"

	# Remove the container
	echo "Removing container $container_id..."
	sudo docker rm "$container_id"
	echo "Done!"
fi

# Pull the latest changes
echo "Pulling the latest changes from the main branch..."
git pull origin main

# Build the Docker image
echo "Building the Docker image..."
sudo docker build -t ztna-hol .

# Run the Docker container
echo "Running the Docker container..."
sudo docker run -d --restart unless-stopped --name ztna-hol-container -p 80:80 ztna-hol
