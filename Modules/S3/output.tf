output "bucket_id_env"{
    value = "${aws_s3_bucket.codedeploy-code-bucket.id}"
}

output "bucket_arn_env"{
    value = "${aws_s3_bucket.codedeploy-code-bucket.arn}"
}

output "env_bucket_name"{
    value = "${aws_s3_bucket.codedeploy-code-bucket.bucket}"
}