#!/usr/bin/env bash

# Docker
alias docker-list="docker ps -a"
alias docker-stop="docker stop $(docker ps -a -q)"
#alias docker-remove-all="docker ps -a | awk '{print $1}' | xargs --no-run-if-empty docker rm"
alias docker-info="docker info"
alias docker-run="docker run -d -t -p "
# Check this issue https://github.com/docker/docker/issues/8395#issuecomment-58063080
alias hostip="ip route show 0.0.0.0/0 | grep -Eo 'via \S+' | awk '{ print \$2 }'"
alias docker-viz="/usr/bin/dockviz"
alias dlive="docker ps"
alias dall="docker ps -a"

# Remove all unamed images
alias docker-rm-unnamed='docker rmi $(docker images | grep "^<none>" | awk "{print $3}")'
#alias docker-volumes="/usr/bin/docker-volumes"

# Remove all containers that have exited
function docker-rm() {
  docker rm -v $(docker ps -a -q -f status=exited)
}

function docker-rm-all() {
  echo -n "Stopping..."
  docker stop $(docker ps -a -q)
  echo -n "Removing..."
  docker rm $(docker ps -a -q)
}

# Login into a docker container
# Usage: docker-ssh-bash [container]
function docker-ssh-bash() {
    docker exec -i -t "$@" /bin/bash
}

# Usage: docker-ssh-sh [container]
function docker-ssh-sh() {
    docker exec -i -t "$@" /bin/sh
}

# Pull all images
function docker-pull-all(){
  docker images | awk '(NR>1) && ($2!~/none/) {print $1":"$2}' | xargs -L1 docker pull
}

