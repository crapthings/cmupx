#!/bin/bash

# Is docker already installed?
set +e
haveDocker=$(docker version | grep "version")
set -e

if [ ! "$haveDocker" ]; then

  # Remove the lock
  set +e
  sudo rm /var/lib/dpkg/lock > /dev/null
  sudo rm /var/cache/apt/archives/lock > /dev/null
  sudo dpkg --configure -a
  set -e

  # Required to update system
  sudo apt-get update

  # Install docker
  wget -qO- https://get.daocloud.io/docker/ | sudo sh
  echo "DOCKER_OPTS=\"\$DOCKER_OPTS --registry-mirror=http://b3c8f2b4.m.daocloud.io\"" | sudo tee -a /etc/default/docker
  sudo service docker restart

fi
