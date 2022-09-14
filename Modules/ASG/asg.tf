# data "template_file" "userdata" {
#   template = file("userdata.sh")
# }
resource "aws_iam_role" "s3bucket-service-role" {
  name               = "s3bucket-service-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "AmazonS3FullAccess" {
  name = "AmazonS3FullAccess"
  path = "/"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:*",
          "s3-object-lambda:*"
        ],
        "Resource" : "*"
      }
    ]
  })

}
resource "aws_iam_role_policy_attachment" "AmazonS3FullAccess" {
  policy_arn = aws_iam_policy.AmazonS3FullAccess.arn
  role       = aws_iam_role.s3bucket-service-role.name

}
resource "aws_iam_instance_profile" "s3FullAccessforEc2" {
  name = "test_profile"
  role = aws_iam_role.s3bucket-service-role.name
}


resource "aws_launch_configuration" "launch_config" {
  name_prefix                 = "${var.environment}-${var.app_name}-${var.launch-config-name}"
  image_id                    = var.instance-ami
  instance_type               = var.instance-type
  iam_instance_profile        = aws_iam_instance_profile.s3FullAccessforEc2.name
  key_name                    = "ansible"
  user_data                   = "${var.user_data}"
  #associate_public_ip_address = var.instance-associate-public-ip == "true" ? true : false
  security_groups             = [var.web_sg_id]
}

resource "aws_autoscaling_group" "asg" {
  # name                      = "${var.asg-name}"
  name                      = "${var.environment}-${var.app_name}-code-deploy-asg"
  min_size                  = var.asg-min-size
  desired_capacity          = var.asg-def-size
  max_size                  = var.asg-max-size
  launch_configuration      = aws_launch_configuration.launch_config.name
  vpc_zone_identifier       = [var.PrivateSubnet1, var.PrivateSubnet2]
  target_group_arns         = [var.target_group_arn]
  health_check_grace_period = 60
  health_check_type         = "ELB"
  min_elb_capacity          = var.asg-min-size
  default_cooldown          = 300

  lifecycle {
    create_before_destroy = true
  }

  # tags = ["${concat(
  # local.common_tags_asg,
  #tolist(
  # [tomap({Name ="${var.instance-tag-name}",value = "tag.value",key = "tag.value",propagate_at_launch=true})]
  # )
  #)}"]

  tag {
    key   =    "Name"
    value =    format("%s-%s-%s",var.environment, var.app_name, var.asg1_name)
    propagate_at_launch = true
  }
}