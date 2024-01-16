resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket-7896"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
