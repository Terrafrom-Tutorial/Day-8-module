#create VPC
resource "aws_vpc" "my_VPC" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

#Create Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_VPC.id

  tags = {
    Name = "${var.vpc_name} IGW"
}
}

#Crate public subnet
resource "aws_subnet" "pub-subnet" {
  vpc_id     = aws_vpc.my_VPC.id
  cidr_block = var.subnet_cidr
  availability_zone = "ap-southeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc_name} public subnet" 
  }
}

#Create route table
resource "aws_route_table" "pub_rtb" {
  vpc_id = aws_vpc.my_VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.vpc_name} public route table"
  }
}

#Create public subnet association
resource "aws_route_table_association" "pub_rtb_assco" {
  subnet_id      = aws_subnet.pub-subnet.id
  route_table_id = aws_route_table.pub_rtb.id
}