variable "bq_dataset_name" { 
  description = "BigQuery Dataset Name"
  type = string
  default = "shiv-bq-dataset"
}

variable "gcp_source_bucket" {
  description = "Google Cloud Storage Bucket Name"
  type = string
  default = "shiv-gcp-bucket"
}

variable "gc_storage_class" {
  description = "Google Cloud Storage Bucket Name"
  type = string
  default = "STANDARD"
}

variable "location"{
    description = "Project location"
    default = "US"
}

variable "credentials" {
  description = "GCP creds"
  default = "./keys/my-keys.json"
}

variable "project" {
  description = "GCP Project ID"
  default = "inlaid-course-437111-h2"
}

variable "region" {
  description = "GCP Region"
  default = "us-central1"  
}