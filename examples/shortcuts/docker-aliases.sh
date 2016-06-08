#!/usr/bin/env bash

# Docker related aliases

# Stop all running containers
alias docker-stop="docker stop $(docker ps -a -q)"

alias dinfo="docker info"
alias drun="docker run -d -t -p "

# List images (with sort and less options)
alias dimages="docker images | less -S"
alias dimages-repo="docker images | sort -k 1 | less -S"
alias dimages-date="docker images | sort -s -n -k 5,5 | less -S"
alias dimages-size="docker images | sort -s -n -k 7,7 | less -S"

# Debug host ip
# Check this issue https://github.com/docker/docker/issues/8395#issuecomment-58063080
alias hostip="ip route show 0.0.0.0/0 | grep -Eo 'via \S+' | awk '{ print \$2 }'"

# List all running containers
alias dlive="docker ps"

# List all containers
alias dall="docker ps -a"

# Remove all unamed images
alias docker-rm-unnamed="docker rmi $(docker images | grep '^<none>' | awk '{print $3}')"

# Remove all containers that have exited
function docker-rm-exited() {
  docker rm -v $(docker ps -a -q -f status=exited)
}

# Remove all containers
# ToDo: Add an interactive question to proceed
function docker-rm-all() {
  echo -n "Stopping..."
  docker stop $(docker ps -a -q)
  echo -n "Removing..."
  docker rm $(docker ps -a -q)
}

# Login into a docker container with bash
# Usage: docker-ssh-bash [container]
function docker-ssh-bash() {
   docker exec -i -t "$@" /bin/bash
}

# Login into a docker container with sh
# Usage: docker-ssh-sh [container]
function docker-ssh-sh() {
  docker exec -i -t "$@" /bin/sh
}

# Pull all images (this may take time...)
function docker-pull-all(){
  docker images | awk '(NR>1) && ($2!~/none/) {print $1":"$2}' | xargs -L1 docker pull
}

# Update all docker* software (Linux specific)
function docker-update(){

  # docker-machine
  echo -n ">> Docker-machine version (eg 0.7.1 or empty to abort): "
  read machine_version

  # docker-compose
  echo -n ">> Docker-compose version (eg 1.7.1 or empty to abort): "
  read compose_version

  # docker-engin
  echo -n ">> Update docker-engine (docker)? [Y/n]: "
  read update_engine

  if [[ ${machine_version} ]]
  then
    sudo rm /usr/local/bin/docker-machine
    curl -L https://github.com/docker/machine/releases/download/v"${machine_version}"/docker-machine-`uname -s`-`uname -m` > /usr/local/bin/docker-machine
    chmod +x /usr/local/bin/docker-machine
  else
    echo -e ">> No docker-machine version entered, continue."
  fi

  if [[ ${compose_version} ]]
  then
    sudo rm /usr/local/bin/docker-compose
    curl -L https://github.com/docker/compose/releases/download/"${compose_version}"/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
  else
    echo -e ">> No docker-compose version entered, continue."
  fi

  # docker-engine
  if [[ ${update_engine} =~ ^([yY][eE][sS]|[yY])$ ]]
  then
    echo -e ">> Updading docker-engine"
    sudo apt-get update
    sudo apt-get upgrade docker-engine
  fi

  # debug
  docker -v
  docker-machine -v
  docker-compose -v
}
