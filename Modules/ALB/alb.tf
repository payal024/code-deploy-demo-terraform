resource "aws_lb" "alb" {
  name                       = "${var.environment}-${var.app_name}-code-deploy-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = ["${var.alb_sg_id}"]
  subnets                    = ["${var.PublicSubnet1}","${var.PublicSubnet2}"]
  idle_timeout               = var.idle_timeout_value
  enable_deletion_protection = false
  drop_invalid_header_fields = true

  tags = {
     Name = "${var.environment}-${var.app_name}-code-deploy-demo-alb"
  }
}

resource "aws_lb_target_group" "lb_target" {
  name = "${var.environment}-${var.app_name}-code-deploy-asg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = "${var.vpc_id}"

  health_check {
    interval            = 10
    healthy_threshold   = 5
    unhealthy_threshold = 3
    timeout             = 5
    path                = "/health-check"
    port                = 8080
    matcher             = "200"
  }
  
}

resource "aws_lb_listener" "lb_listener" {
  #count             = var.use_https_only == "true" ? 0 : 1
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target.arn
  }
}