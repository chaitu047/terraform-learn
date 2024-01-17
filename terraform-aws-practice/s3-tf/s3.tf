resource "aws_s3_bucket" "example" {
  count  = 3
  bucket = "${var.bucketname}-789-${count.index}"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
