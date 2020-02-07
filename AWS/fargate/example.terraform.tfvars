region = "ap-south-1"
profile = "private"

vpc_name = "fargate_vpc"
vpc_cidr = "10.0.0.0/16"
public_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
private_cidrs = ["10.0.11.0/24", "10.0.22.0/24"]
availability_zones = {
  "0" = "ap-south-1a",
  "1" = "ap-south-1b"
}
ipv4_everywhere = "0.0.0.0/0"

app_port = 80
container_name = "test_fargate"
desired_count = 1
fargate_cpu = 256
fargate_memory = 512
image_url = "nginx:latest"