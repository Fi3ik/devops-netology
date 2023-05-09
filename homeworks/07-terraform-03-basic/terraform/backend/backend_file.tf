
resource "local_file" "backend" {
  content  = <<-DOC
    bucket         = "${aws_s3_bucket.tf_state.id}"
    region         = "${aws_s3_bucket.tf_state.region}"
    dynamodb_table = "${aws_dynamodb_table.db_tf_locks.name}"
    encrypt        = true     
    DOC
  filename = "backend.hcl"

  depends_on = [
    aws_s3_bucket.tf_state
  ]
}
