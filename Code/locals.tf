locals {
  common_tags = {
    application      =  "infracode"
    appshortname     = "${var.app_name}"
    environment      = "${var.environment}"
    region           = "${var.region}"
    deployment_method  = "auto"
}
}