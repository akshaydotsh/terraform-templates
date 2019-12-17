variable "region" {
    default = "ap-south-1"
}

variable "vpc_name" {
    default = "custom-vpc"
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "public_cidrs" {
    type = "list"
}

variable "private_cidrs" {
    type = "list"
}

variable "accessip" {
    default = "0.0.0.0/0"
}

variable "availability_zones_ap_south_1" {
    default = {
        "0" = "ap-south-1a",
        "1" = "ap-south-1b"
    }
}
