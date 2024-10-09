# Public Subnet in Availability Zone us-east-1a
resource "aws_subnet" "public_subnet_1a" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1a"
    Environment = "Production"
  }
}

# Private Subnet in Availability Zone us-east-1b
resource "aws_subnet" "private_subnet_1b" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-1b"
    Environment = "Production"
  }
}

# Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
    Environment = "Production"
  }
}

# Associate Public Subnet with Public Route Table
resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.public_subnet_1a.id
  route_table_id = aws_route_table.public_rt.id
}

# Private Route Table (without internet access)
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "private-route-table"
    Environment = "Production"
  }
}

# Associate Private Subnet with Private Route Table
resource "aws_route_table_association" "private_association" {
  subnet_id      = aws_subnet.private_subnet_1b.id
  route_table_id = aws_route_table.private_rt.id
}

