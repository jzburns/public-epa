provider "google" {
}

locals {
}

resource "google_pubsub_topic" "pubsub-v1" {
  name = "news-topic"

  # A label is a key-value pair that helps you organize your Google Cloud resources. 
  # You can attach a label to each resource, then filter the resources based on their labels. 
  # Information about labels is forwarded to the billing system, so you can break down your billed charges by label.
  labels = {
    activity = "epa-labs"
  }
  # By default, a message that cannot be delivered within the maximum retention 
  # time of 7 days is deleted and is no longer accessible.
  # this is a shorter time period of 1 day 3 min 20 sec
  message_retention_duration = "86600s"
}

