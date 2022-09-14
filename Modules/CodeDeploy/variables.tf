variable "environment"{}
variable "region"{
    description = "Enter region"
}

variable "target_group_name"{
    description = "Enter target-group"
}

variable "deployment_type"{
    description = " Default Config"
    default = "CodeDEployDefault.OneAtOnce"
}

variable "elb_exists"{
    default = "true"
}

variable "asg1_name"{}
variable "app_name"{}
