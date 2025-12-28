
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true            
  availability_zone       = "us-east-1a"    

  tags = {
    Name = "Pranavissam-Public-Subnet"
  }
}


resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Pranavissam-Private-Subnet"
  }
}