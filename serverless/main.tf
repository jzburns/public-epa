provider "google" {
}

resource "google_storage_bucket" "bucket" {
  name     = format("%s-%s", var.project_id, "cloud-functions-bucket")
  location = "eu"
  force_destroy = true
}

resource "google_storage_bucket_object" "archive" {
  name   = "index.zip"
  bucket = google_storage_bucket.bucket.name
  source = "/home/jzburns/EPA-FLITE-2021/week9/gcf/index.zip"
}

resource "google_cloudfunctions_function" "helloGCS" {
  name        = "helloGCS"
  description = "helloGCS"
  runtime     = "nodejs14"
  available_memory_mb   = 256
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.archive.name
  event_trigger {
    event_type = "google.storage.object.finalize"
    resource = google_storage_bucket.bucket.name
  }
  
  entry_point           = "helloGCS"
  region                = var.region
}

resource "google_cloudfunctions_function" "function" {
  name        = "helloUsername"
  description = "helloUsername"
  runtime     = "nodejs14"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.archive.name
  trigger_http          = true
  entry_point           = "helloUsername"
  region                = var.region
}

# IAM entry for all users to invoke the function
resource "google_cloudfunctions_function_iam_member" "invokerGCS" {
  project        = google_cloudfunctions_function.helloGCS.project
  region         = var.region
  cloud_function = google_cloudfunctions_function.helloGCS.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}

# IAM entry for all users to invoke the function
resource "google_cloudfunctions_function_iam_member" "invokerHTTP" {
  project        = google_cloudfunctions_function.function.project
  region         = var.region
  cloud_function = google_cloudfunctions_function.function.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}