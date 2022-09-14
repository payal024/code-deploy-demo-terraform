resource "aws_security_group" "alb_sg" {
  name = "${var.environment}-${var.app_name}-alb-sg-demo"
  vpc_id = var.vpc_id

  ingress {
  from_port = 80
  to_port = 80
  protocol = "TCP"
  cidr_blocks = var.elb_sg_cidr_blocks
  }

  ingress{
  from_port = 443
  to_port = 443
  protocol = "TCP"
  cidr_blocks = var.elb_sg_cidr_blocks
  }
  ingress {
      from_port   = 8080
      to_port     = 8080
      protocol    = "TCP"
      cidr_blocks = var.elb_sg_cidr_blocks
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks =[var.Private1SubnetCidr, var.Private2SubnetCidr, var.Private3SubnetCidr, var.Private4SubnetCidr]
  }
    egress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "TCP"
     cidr_blocks =[var.Private1SubnetCidr, var.Private2SubnetCidr, var.Private3SubnetCidr, var.Private4SubnetCidr]
  }
tags = {
    Name = "${var.environment}-${var.app_name}-alb-sg-demo"


  }
}

resource "aws_security_group" "web_sg" {
  name = "${var.environment}-${var.app_name}-web-sg-demo"
  vpc_id = var.vpc_id

  ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "TCP"
      security_groups = [aws_security_group.alb_sg.id]
  }
    ingress {
      from_port   = 443
      to_port     = 443
      protocol    = "TCP"
      security_groups = [aws_security_group.alb_sg.id]
  }
      ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "TCP"
      cidr_blocks = ["10.42.157.0/24", "10.52.0.0/16", "10.45.40.128/26", "10.48.16.0/20", "10.151.0.0/16", "10.48.80.0/21", "10.0.0.0/8"]
      # cidr_blocks = [ "0.0.0.0/0" ]
  }

     ingress {
      from_port   = 8080
      to_port     = 8080
      protocol    = "TCP"
      cidr_blocks = ["10.42.157.0/24", "10.52.0.0/16", "10.45.40.128/26", "10.48.16.0/20", "10.151.0.0/16", "10.48.80.0/21", "10.0.0.0/8"]
      # cidr_blocks = [ "0.0.0.0/0" ]
  }
ingress {
      from_port   = 443
      to_port     = 443
      protocol    = "TCP"
      cidr_blocks = ["10.42.157.0/24", "10.52.0.0/16", "10.45.40.128/26", "10.48.16.0/20", "10.151.0.0/16", "10.48.80.0/21", "10.0.0.0/8"]
      # cidr_blocks = [ "0.0.0.0/0" ]
  }



  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-${var.app_name}-web-sg-demo"
  }
}



