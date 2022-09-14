module "CodeDeploy" {
  source = "../Modules/CodeDeploy/"
  target_group_name = module.ALB.target_group_name
  asg1_name         = module.asg.asg1_name
  app_name          = var.app_name
  environment       = var.environment
  region            = var.region
}