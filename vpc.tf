# Virtual private cloud
resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "Pranavissam-Project-VPC"
    Environment = "Dev"
    Project     = "Cloud-Observability"
  }
}

# internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "Pranavissam-IGW"
  }
}