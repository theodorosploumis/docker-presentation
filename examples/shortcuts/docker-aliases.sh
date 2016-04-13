#!/usr/bin/env bash

# Docker related aliases

# Stop all running containers
alias docker-stop="docker stop $(docker ps -a -q)"

alias dinfo="docker info"
alias drun="docker run -d -t -p "

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

