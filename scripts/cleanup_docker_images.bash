#!/bin/bash

# Get all image IDs of autoware repository
image_ids=$(docker images | grep autoware | awk '{print $3}')

# Check if there are any images to delete
if [ -z "$image_ids" ]; then
  echo "No images found for repository autoware."
else
  # Delete all images
  for id in $image_ids; do
    docker rmi $id
  done
  echo "Deleted all images for repository autoware."
fi

docker system prune -f