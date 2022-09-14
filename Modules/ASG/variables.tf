variable "environment" {}
variable "launch-config-name"{}
variable "instance-type"{}
# variable "launch-config-name"{}
variable "instance-ami"{}
variable "asg1_name"{}
variable "user_data" {}
variable "asg-min-size"{}
variable "asg-def-size"{}
variable "asg-max-size"{}
variable "target_group_arn" {
  type  = string
}
variable "app_name"{}
variable "PrivateSubnet1"{}
variable "PrivateSubnet2"{}
variable "web_sg_id"{}

