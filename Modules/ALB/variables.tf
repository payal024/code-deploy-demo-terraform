variable "alb_sg_id"{}
variable "vpc_id"{}
variable "app_name"{}
variable "environment"{}
variable "PublicSubnet1"{}
variable "PublicSubnet2"{}
variable "idle_timeout_value"{
    description = "Mention ideal timeout"
    default = 60
}
