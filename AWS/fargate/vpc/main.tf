resource "aws_vpc" "tf_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "tf_internet_gateway" {
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name = "tf_igw"
  }
}

resource "aws_route_table" "tf_public_rt" {
  vpc_id = aws_vpc.tf_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_internet_gateway.id
  }

  tags = {
    Name = "tf_public"
  }
}

resource "aws_subnet" "tf_public_subnet" {
  count                   = length(var.public_cidrs)
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = var.public_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = lookup(var.availability_zones, count.index)
  tags = {
    Name = "tf_public_${count.index + 1}"
  }
}

resource "aws_eip" "tf_eip" {
  vpc = true
}

resource "aws_nat_gateway" "tf_nat_gateway" {
  allocation_id = aws_eip.tf_eip.id
  subnet_id = aws_subnet.tf_public_subnet.*.id[0]
}

resource "aws_route_table_association" "tf_public_assoc" {
  count          =  length(aws_subnet.tf_public_subnet)
  subnet_id      =  aws_subnet.tf_public_subnet.*.id[count.index]
  route_table_id =  aws_route_table.tf_public_rt.id
}

resource "aws_subnet" "tf_private_subnet" {
  count                   = length(var.private_cidrs)
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = var.private_cidrs[count.index]
  availability_zone       = lookup(var.availability_zones, count.index%2)
  tags = {
    Name = "tf_private_${count.index + 1}"
  }
}

resource "aws_default_route_table" "tf_private_rt" {
  default_route_table_id  = aws_vpc.tf_vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.tf_nat_gateway.id
  }

  tags = {
    Name = "tf_private"
  }
}

resource "aws_route_table_association" "tf_private_assoc" {
  count          = length(aws_subnet.tf_private_subnet)
  subnet_id      = aws_subnet.tf_private_subnet.*.id[count.index]
  route_table_id = aws_default_route_table.tf_private_rt.id
}

resource "aws_security_group" "tf_public_sg" {
  name        = "tf_public_sg"
  description = "Used for access to the public instances"
  vpc_id      = aws_vpc.tf_vpc.id

  #SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ipv4_everywhere]
  }

  #HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.ipv4_everywhere]
  }
  #HTTPS
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.ipv4_everywhere]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "tf_private_sg" {
  name        = "tf_private_sg"
  description = "Used for access to the private instances"
  vpc_id      = aws_vpc.tf_vpc.id

  #SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.tf_public_sg.id]
  }

  #HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.tf_public_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.ipv4_everywhere]
  }
}