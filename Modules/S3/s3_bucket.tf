resource "aws_s3_bucket" "codedeploy-code-bucket" {
  bucket = "${var.environment}-${var.app_name}-bucketcode"
  #region = "us-east-1"
  


tags = {
        Name = "${var.environment}-${var.app_name}-bucketcode"
      }
}



resource "aws_s3_bucket_acl" "codedeploy-code-bucket" {
  bucket = aws_s3_bucket.codedeploy-code-bucket.id
  acl    = "private"

}
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.codedeploy-code-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
