variable "region" {}

variable "profile" {}

variable "vpc_name" {}

variable "vpc_cidr" {}

variable "public_cidrs" {
    type = list(string)
}

variable "private_cidrs" {
    type = list(string)
}

variable "ipv4_everywhere" {}

variable "availability_zones_ap_south_1" {}
