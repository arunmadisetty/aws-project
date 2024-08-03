provider "aws" {
  region = "us-east-2"  
}

# VPC
resource "aws_vpc" "terraform" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "TerraformVPC"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.terraform.id
  tags = {
    Name = "TerraformIGW"
  }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  vpc = true
}

# NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.terraform.id  

  tags = {
    Name = "TerraformNATGateway"
  }
}

# Public Subnets
resource "aws_subnet" "terraform" {
  vpc_id     = aws_vpc.terraform.id
  cidr_block = "10.0.10.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-2a"
  tags = {
    Name = "PublicSubnet1"
  }
}

resource "aws_subnet" "terraform1" {
  vpc_id     = aws_vpc.terraform.id
  cidr_block = "10.0.20.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-2b"
  tags = {
    Name = "PublicSubnet2"
  }
}

resource "aws_subnet" "terraform2" {
  vpc_id     = aws_vpc.terraform.id
  cidr_block = "10.0.30.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-2c"
  tags = {
    Name = "PublicSubnet3"
  }
}

# Private Subnets
resource "aws_subnet" "private_sub" {
  vpc_id     = aws_vpc.terraform.id
  cidr_block = "10.0.40.0/24"
  availability_zone = "us-east-2a"
  tags = {
    Name = "PrivateSubnet1"
  }
}

resource "aws_subnet" "private_sub2" {
  vpc_id     = aws_vpc.terraform.id
  cidr_block = "10.0.50.0/24"
  availability_zone = "us-east-2b"
  tags = {
    Name = "PrivateSubnet2"
  }
}

resource "aws_subnet" "private_sub3" {
  vpc_id     = aws_vpc.terraform.id
  cidr_block = "10.0.60.0/24"
  availability_zone = "us-east-2c"
  tags = {
    Name = "PrivateSubnet3"
  }
}

# Route Table for Public Subnets
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.terraform.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  
  tags = {
    Name = "TerraformPublicRT"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.terraform.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.terraform1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.terraform2.id
  route_table_id = aws_route_table.public_rt.id
}

# Route Table for Private Subnets
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.terraform.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  
  tags = {
    Name = "TerraformPrivateRT"
  }
}

resource "aws_route_table_association" "private_association1" {
  subnet_id      = aws_subnet.private_sub.id
  route_table_id = aws_route_table.private_rt.id

}

resource "aws_route_table_association" "private_association2" {
  subnet_id      = aws_subnet.private_sub2.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_association3" {
  subnet_id      = aws_subnet.private_sub3.id
  route_table_id = aws_route_table.private_rt.id
}