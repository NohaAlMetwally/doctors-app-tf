# create application load balancer
resource "aws_lb" "application_load_balancer" {
  name                       = "doctors-app-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb_security_group.id]
  subnets                    = [aws_subnet.public_subnet_az1.id, aws_subnet.public_subnet_az2.id]
  enable_deletion_protection = false

  tags = {
    Name = "doctors-app-alb"
  }
}

resource "aws_lb_target_group" "tg" {
  name        = "doctors-app-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.doctors_app_vpc.id
  target_type = "ip"

  deregistration_delay = 30

  health_check {
    path                = "/"
    matcher             = "200-399"
    interval            = 10
    timeout             = 4     
    unhealthy_threshold = 2
    healthy_threshold   = 2
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}