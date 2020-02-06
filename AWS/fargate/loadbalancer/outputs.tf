output "target_group_arn" {
  value = aws_lb_target_group.tf_alb_tg.arn
}

output "alb_listener" {
  value = aws_lb_listener.tf_alb_listener
}