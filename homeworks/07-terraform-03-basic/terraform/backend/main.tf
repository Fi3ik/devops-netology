provider "aws" {
    region = "eu-central-1"
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "tf_state" {
    bucket = "tf-state-bucket-${data.aws_caller_identity.current.user_id}"
    lifecycle {
        prevent_destroy = true
    }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encrypt_tf_state" {
  bucket = aws_s3_bucket.tf_state.bucket

rule {
    apply_server_side_encryption_by_default {
    sse_algorithm = "AES256"
        }
    }
}

resource "aws_s3_bucket_acl" "acl_baucket_tf_state" {
  bucket = aws_s3_bucket.tf_state.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "versioning_tf_state" {
  bucket = aws_s3_bucket.tf_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "db_tf_locks" {
    name = "tf_state_db"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }
}

#--------------------
