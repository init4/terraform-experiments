
data "aws_availability_zones" "available" {}
 
# Create a VPC to launch our instances into
resource "aws_vpc" "dinobots" {
  cidr_block = "10.0.0.0/16"
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.dinobots.id
}

# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.dinobots.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.default.id
}

resource "aws_route_table_association" "route_table_external" {
    subnet_id = aws_subnet.external.id
    route_table_id = aws_vpc.dinobots.main_route_table_id
}

resource "aws_route_table_association" "route_table_internal" {
    subnet_id = aws_subnet.internal.id
    route_table_id = aws_vpc.dinobots.main_route_table_id
}

# Create a management subnet to launch our instances into
resource "aws_subnet" "management" {
  vpc_id                  = aws_vpc.dinobots.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[1]
}

# Create an external subnet to launch our instances into
resource "aws_subnet" "external" {
  vpc_id                  = aws_vpc.dinobots.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[1]
}

# Create an internal subnet to launch our instances into
resource "aws_subnet" "internal" {
  vpc_id                  = aws_vpc.dinobots.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[1]
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Used in the terraform"
  vpc_id      = aws_vpc.dinobots.id

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

