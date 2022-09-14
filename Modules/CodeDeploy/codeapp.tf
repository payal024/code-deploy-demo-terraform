resource "aws_codedeploy_app" "java-codedeploy-app" {
  compute_platform = "Server"
  name             = "${var.environment}-${var.app_name}-code-app-test"
}

resource "aws_iam_role" "codedeploy-service-role" {
  name = "codedeploy-service-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "codedeploy.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "AWSCodeDeployRole" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
  role       = aws_iam_role.codedeploy-service-role.name

}

resource "aws_codedeploy_deployment_group" "java-codedeploy-group" {
  app_name               = "${var.environment}-${var.app_name}-code-app-test"
  deployment_group_name  = "${var.environment}-${var.app_name}-code-app-group"
  service_role_arn       = aws_iam_role.codedeploy-service-role.arn
  autoscaling_groups     = [var.asg1_name]
  deployment_config_name = "CodeDeployDefault.AllAtOnce"
  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "IN_PLACE"
  }
  dynamic load_balancer_info {
    for_each = "${local.elb_exists}"
    content {
      target_group_info {
        name ="${var.target_group_name}"
      }
    }
      
    }
     auto_rollback_configuration {
     enabled = false
  }
}