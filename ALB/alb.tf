##################################################################################
# ALB
##################################################################################

resource "aws_lb_target_group" "tg_port_80" {
  name     = "TARGET-ECS-80"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"
}

resource "aws_lb_target_group" "tg_port_443" {
  name     = "TARGET-ECS-443"
  port     = 443
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"
}

resource "aws_lb" "alb_service" {
  name               = "ALB-CONTAINERS-ECS"
  load_balancer_type = "application"
  internal           = false
  security_groups    = [var.sec_group]
  subnets            = [var.subnet_dmz_a,var.subnet_dmz_b,var.subnet_dmz_c]
  idle_timeout                     = 60
  enable_cross_zone_load_balancing = false
  enable_http2                     = true
  enable_deletion_protection       = false
  ip_address_type                  = "ipv4"
  tags = {
    Name        = "ALB-CONTAINERS-ECS"
    Environment = var.environment
    Project     = var.projectname
  }
}

resource "aws_lb_listener" "listener_http_80" {
  load_balancer_arn = aws_lb.alb_service.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "listener_https_443" {
  load_balancer_arn = aws_lb.alb_service.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.public_ssl_cert
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_port_443.arn
  }
}

#resource "aws_lb_target_group_attachment" "alb_attach_80" {
#  target_group_arn = aws_lb_target_group.tg_port_80.arn
#  target_id        = aws_instance.ec2-1.id
#  port             = 80
#}

#resource "aws_lb_target_group_attachment" "alb_ansible_attach_443" {
#  target_group_arn = aws_lb_target_group.tg_port_443.arn
#  target_id        = aws_instance.ec2-1.id
#  port             = 443
#}