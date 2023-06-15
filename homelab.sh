#!/usr/bin/env bash

ComposeFiles=""
test=""
docker_compose="docker-compose.yml"
env=".env"
# Add global .env file to script
source $env

for i in ~/homelab/apps/*/; do
  # Test if app has .env file, if so add to script
  if test -f "$i$env"; then
    ComposeFiles+="--file $i$docker_compose --env-file $i$env "
  else
    ComposeFiles+="--file $i$docker_compose "
  fi
done

# Create Docker Networks
docker network inspect traefik_proxy >/dev/null 2>&1 ||
  docker network create traefik_proxy

docker network inspect socket_proxy >/dev/null 2>&1 ||
  docker network create socket_proxy

first=$1
second=$2
start_service() {
  if [[ -z "$second" ]]; then
    # echo "docker compose $ComposeFiles up -d"
    docker compose --env-file $env $ComposeFiles up -d
  elif [[ -n "$second" ]]; then
    echo "String is not empty; $second"
  fi
}

stop_service() {
  if [[ -z "$second" ]]; then
    echo "docker compose --env-file $env $ComposeFiles down"
    docker compose --env-file $env $ComposeFiles down
  elif [[ -n "$second" ]]; then
    echo "String is not empty; $second"
  fi
}

# Script Arguments
shopt -s nocasematch
case $first in
"start") start_service ;;
"stop") stop_service ;;
# "ps") 
*)
  echo "Default"
  exit
  ;;
esac
shopt -u nocasematch
