region = "ap-south-1"
availability_zones_ap_south_1 = {
  "0" = "ap-south-1a",
  "1" = "ap-south-1b"
}
vpc_name = "custom-vpc"
vpc_cidr = "10.0.0.0/16"
accessip = "0.0.0.0/0"
public_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24",
]
private_cidrs = [
  "10.0.11.0/24",
  "10.0.12.0/24",
  "10.0.21.0/24",
  "10.0.22.0/24"
]

