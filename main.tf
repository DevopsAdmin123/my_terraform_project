#this is the block to create vpc
resource "aws_vpc" "myvpc" {
    cidr_block = var.vpc-cidr

}

#this is the block to create the igw for vpc
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.myvpc.id
  
}

#this is block to create public subnet
resource "aws_subnet" "public_subnet" { 
    vpc_id = aws_vpc.myvpc.id
    cidr_block = var.cidr_public_subnet
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = true
  
}

#this is block to create rout table
resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "PRA" {
  route_table_id = aws_route_table.RT.id
  subnet_id = aws_subnet.public_subnet.id
  
}

#this is block to create security group
resource "aws_security_group" "web_SG" {
  vpc_id = aws_vpc.myvpc.id
  name = "webSG"

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Web-sg"
  }
  
}





