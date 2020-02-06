resource "aws_cloudwatch_log_group" "lg" {
  name = "ecs/lg"
  tags = {
    Service = "fargate"
  }
}