#!/usr/bin/env bash

ComposeFiles=()
test=""

for i in ~/homelab/apps/*/*.yml; do
  test="${test} -f ${i}"
  ComposeFiles+=($i)
done

# compose_files=compile_compose_files
# compile_compose_files() {
#   for I in "${ComposeFiles[@]}"
#   do    
#     $compose_files=${compose_files:+$compose_files }-f $I
#   done
# }


first=$1
second=$2
start_service() {
  if [[ -z "$second" ]]; then
    # "sudo docker compose up -d ${test}"
    docker compose $test up -d 
    # sudo docker compose up -d $compose_files
    # echo "String is empty $(compose_files)"
  elif [[ -n "$second" ]]; then
    echo "String is not empty; $second"
  fi
}

stop_service() {
  echo $3
}

# Script Arguments
shopt -s nocasematch
case $first in
  "start") start_service ;;

  "stop") stop_service ;;

  *) echo "Default" 
     exit ;;
esac
shopt -u nocasematch

