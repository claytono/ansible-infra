# Manage the existing B2 bucket with master key (has writeBuckets permission)
resource "b2_bucket" "restic_backups" {
  bucket_name = "cmo-restic"
  bucket_type = "allPrivate"

  # Lifecycle rule: delete old versions 1 day after hidden (minimum allowed)
  lifecycle_rules {
    file_name_prefix             = "" # Apply to all files in bucket
    days_from_hiding_to_deleting = 1
  }
}
