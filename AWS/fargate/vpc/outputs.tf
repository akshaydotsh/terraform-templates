output "vpc_id" {
  value = aws_vpc.tf_vpc.id
}

output "public_sg" {
  value = aws_security_group.tf_public_sg.id
}

output "public_subnets" {
  value = aws_subnet.tf_public_subnet.*.id
}

output "private_sg" {
  value = aws_security_group.tf_private_sg.id
}

output "private_subnets" {
  value = aws_subnet.tf_private_subnet.*.id
}