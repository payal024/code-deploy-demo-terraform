output "loadbalancerdns" {
    value = "${aws_lb.alb.dns_name}"
}

output "zoneid" {
    value = "${aws_lb.alb.zone_id}"
}

output "target_group_name" {
    value = aws_lb_target_group.lb_target.name
}

output "targetgroupARN"{
    value = aws_lb_target_group.lb_target.arn
}