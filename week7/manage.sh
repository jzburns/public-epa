#!/bin/bash

#################################
## this is a function in bash
## notice it has no parentheses
#################################
start_server() {
  echo "start_server() called..."
  gcloud compute instances create-with-container "$1" \
    --container-image eu.gcr.io/epa-flite-2021/unreliablebanking:latest \
    --zone=europe-west1-c \
    --tags=http-server,https-server
}

restart_server() {
  echo "restart_server() called..."
  gcloud compute instances update-container "$1" \
    --container-image eu.gcr.io/epa-flite-2021/unreliablebanking:latest \
    --zone=europe-west1-c
}

teardown_server() {
  echo "teardown_server() called..."
  gcloud compute instances delete "$1" \
    --zone=europe-west1-c
}

if [ "$1" == "start" ]; then
  start_server "$2"
fi

if [ "$1" == "restart" ]; then
  restart_server "$2"
fi

if [ "$1" == "teardown" ]; then
  teardown_server "$2"
fi
