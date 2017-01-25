#!/bin/bash

# have docker installed, remove it
if [ 'docker' -eq 0 ]; then
  docker volume rm $(docker volume ls -q)
  docker rm -f $(sudo docker ps -aq)
  service nvidia-docker stop
  service docker stop
  rpm -qa|grep nvidia-docker|xargs  yum remove -y
  rpm -qa|grep docker|xargs  yum remove -y
  rm -rf /etc/docker
  rm -rf /disk2/docker
  ifconfig docker0 down
  brctl delbr docker0
  ifconfig docker_gwbridge down
  brctl delbr docker_gwbridge
fi
