output "buckets" {
  description = "Map of Cloud Storage Bucket resources."
  value       = {
    for bucket in var.storage_buckets :
    bucket.name => google_storage_bucket.bucket[bucket.name]
  }
}

output "bucket_names" {
  description = "List of Cloud Storage Bucket names."
  value       = [
    for bucket in var.storage_buckets :
    google_storage_bucket.bucket[bucket.name].name
  ]
}
