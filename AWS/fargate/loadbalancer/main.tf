resource "aws_lb" "tf_alb" {
  name               = "tf-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [var.public_subnets[0], var.private_subnets[1]]
  security_groups    = [var.public_sg]
}

resource "aws_lb_target_group" "tf_alb_tg" {
  name        = "tf-alb-tg"
  port        = var.app_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
}

resource "aws_lb_listener" "tf_alb_listener" {
  load_balancer_arn = aws_lb.tf_alb.id
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tf_alb_tg.id
  }
}