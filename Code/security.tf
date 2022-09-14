module "securitygroup" {
 source = "../Modules/securitygroup/"

 vpc_id           = var.vpc_id
  environment = var.environment
  app_name = var.app_name
  Private1SubnetCidr= var.Private1SubnetCidr
 Private2SubnetCidr = var.Private2SubnetCidr
 Private3SubnetCidr= var.Private3SubnetCidr
 Private4SubnetCidr = var.Private4SubnetCidr
  elb_sg_cidr_blocks = var.elb_sg_cidr_blocks
}