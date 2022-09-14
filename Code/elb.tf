module "ALB" {
   source = "../Modules/ALB/"
   alb_sg_id     =  module.securitygroup.alb_sg_id
   PublicSubnet1 =  var.PublicSubnet1
   PublicSubnet2 = var.PublicSubnet2
   vpc_id     = var.vpc_id

   app_name    = var.app_name
   environment = var.environment
}
