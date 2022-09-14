output "web_codedeploy_app_name" {
    value = "${module.CodeDeploy.codedeploy_app_name}"

}

output "web_codedeploy_group_name"{
     value = "${module.CodeDeploy.codedeploy_group_name}"
}

output "alb_security_group" {
    value = "${module.securitygroup.alb_sg_id}"
}

output "web_security_group" {
    value = "${module.securitygroup.web_sg_id}"
}
    