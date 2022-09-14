locals {

    elb_exists = "${var.elb_exists==true ? tolist(["elb"]) : []}"
}