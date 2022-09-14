output "codedeploy_app_name"{
    value = "${aws_codedeploy_deployment_group.java-codedeploy-group.app_name}"
}

output "codedeploy_group_name"{
    value = "${aws_codedeploy_deployment_group.java-codedeploy-group.deployment_group_name}"
}