#!/bin/bash

#######################################################
## the code for the producer (publisher)
#######################################################
gcloud pubsub topics publish epa-topic-1 --message="This is a greate message"

sleep 3
#######################################################
## the code for the subscriber (consumer)
#######################################################
gcloud pubsub subscriptions pull epa-subs-1 --auto-ack
