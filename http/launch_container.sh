#!/bin/bash

#######################################################
## launch a VM with a container
#######################################################
gcloud compute instances create-with-container nginx-vm \
    --container-image eu.gcr.io/epa-flite-2021/epa-nginx:latest \
    --zone=europe-west1-c \
    --tags=http-server,https-server
    