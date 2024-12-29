#!/bin/bash

# create cyclonedds.conf to increase the OS-level receive buffer size permanently to avoid error when using rmw_cyclonedds_cpp
# (https://github.com/ros2/rmw_cyclonedds?tab=readme-ov-file#performance-recommendations)
CYCLONEDDS_CONF="/etc/sysctl.d/60-cyclonedds.conf"
if [ ! -f "${CYCLONEDDS_CONF}" ]; then
  echo ">> ${CYCLONEDDS_CONF} does not exist. It is necessary to avoid error when using rmw_cyclonedds_cpp."
  echo ">> Creating ${CYCLONEDDS_CONF}..."
  echo -e "net.core.rmem_max=2147483647\nnet.core.rmem_default=2147483647\n" | sudo tee "${CYCLONEDDS_CONF}" > /dev/null
  echo ">> ${CYCLONEDDS_CONF} is created!"

  # apply the settings immediately without reboot
  sudo sysctl -w net.core.rmem_max=2147483647 > /dev/null
fi

docker compose -f ./docker/humble/docker-compose.yml build