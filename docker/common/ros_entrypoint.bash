#!/bin/bash
set -e

# Enable multicast on loopback interface
sudo ip l set lo multicast on

echo "start ${ROS_DISTRO}!"
sleep infinity 