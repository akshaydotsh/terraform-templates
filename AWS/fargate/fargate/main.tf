module "cloudwatch" {
  source = "../cloudwatch"
}

module "loadbalancer" {
  source = "../loadbalancer"
  app_port = var.app_port
  private_sg = var.private_sg
  private_subnets = var.private_subnets
  public_sg = var.public_sg
  public_subnets = var.public_subnets
  vpc_id = var.vpc_id
}

# -------- SETUP ECS cluster ---------
resource "aws_ecs_cluster" "tf_ecs_cluster" {
  name = "tf_ecs_cluster"
}

resource "aws_iam_role" "ecs_role" {
  name = "ecs_role"
  assume_role_policy = file("${path.module}/policies/assume-role-policy.json")
}

resource "aws_iam_role_policy" "ecs_role_policy" {
  policy = file("${path.module}/policies/iam-role-policy.json")
  role = aws_iam_role.ecs_role.id
}

data "template_file" "container_def_data" {
  template = file("${path.module}/policies/fargate-container-def.json")
  vars = {
    container_name = var.container_name
    image_url = var.image_url
    container_port = var.app_port
    host_port = var.app_port
    awslogs_group_name = module.cloudwatch.log_group_name
    awslogs_region = "ap-south-1"
  }
}

resource "aws_ecs_task_definition" "tf_elb_task_def" {
  family                   = "app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.container_def_data.rendered
  execution_role_arn = aws_iam_role.ecs_role.arn
}

resource "aws_ecs_service" "tf_ecs_service" {
  name            = "tf_ecs_service"
  cluster         = aws_ecs_cluster.tf_ecs_cluster.id
  task_definition = aws_ecs_task_definition.tf_elb_task_def.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"
  network_configuration {
    security_groups = [var.private_sg]
    subnets = var.private_subnets
  }
  load_balancer {
    target_group_arn = module.loadbalancer.target_group_arn
    container_name = var.container_name
    container_port = var.app_port
  }
  depends_on = [module.loadbalancer.alb_listener, aws_iam_role_policy.ecs_role_policy]
}
