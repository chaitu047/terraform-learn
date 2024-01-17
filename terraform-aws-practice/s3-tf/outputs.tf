output "s3_bucket_list" {
  value = aws_s3_bucket.example[*].id
}
