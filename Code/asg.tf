
data "template_file" "userdata" {
 template = file("../Modules/Scripts/userdata.sh")
}

module "asg" {
    source  = "../Modules/ASG/"
    
    app_name            = var.app_name
    environment         = var.environment
    PrivateSubnet1      = var.PrivateSubnet1
    PrivateSubnet2      = var.PrivateSubnet2 
    web_sg_id           = module.securitygroup.web_sg_id
    launch-config-name  = var.launch-config-name
    instance-ami        = var.instance-ami
    instance-type       = var.instance-type
    asg-min-size        = var.asg-min-size
    asg-def-size        = var.asg-def-size
    asg-max-size        = var.asg-max-size
    asg1_name           = var.asg1_name
    user_data           = base64encode(data.template_file.userdata.rendered)
    target_group_arn    = module.ALB.targetgroupARN
}