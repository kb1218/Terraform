
# create vpc
resource "aws_vpc" "vnet" {
  cidr_block = "192.168.0.0/16"
  tags = {
    Name = "TF-VPC-01"
  }
}

# create subnet

resource "aws_subnet" "sub-1" {
  vpc_id                  = aws_vpc.vnet.id
  cidr_block              = "192.168.0.0/20"
  availability_zone       = "ap-southeast-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "PUBLIC-SUBNET"
  }
}


# create internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vnet.id
  tags = {
    Name = "TF-VPC-01-IGW"
  }
}


# create route table
resource "aws_route_table" "rt-1" {
  vpc_id = aws_vpc.vnet.id
  tags = {
    Name = "RT-PUBLIC"
  }

  route {
    gateway_id = aws_internet_gateway.igw.id
    cidr_block = "0.0.0.0/0"
  }
}

resource "aws_route_table_association" "rta-1" {
  route_table_id = aws_route_table.rt-1.id
  subnet_id      = aws_subnet.sub-1.id
}

# create security group

resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.vnet.id
  name   = "TF-VPC-01-SG"
  # add inbound rules
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # add outbound rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 -> all traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# create instance
resource "aws_instance" "vm-1" {
  ami                    = "ami-02289b3fe036fe5cd"
  instance_type          = "t3.micro"
  key_name               = "id_rsa"
  subnet_id              = aws_subnet.sub-1.id
  vpc_security_group_ids = [aws_security_group.sg.id]
  user_data              = <<-EOF
    #!/bin/bash
    sudo -i
    yum update -y
    yum install httpd -y
    systemctl start httpd 
    echo "Hello Terraform" > /var/www/html/index.html
    EOF
  tags = {
    Name = "webserver"
  }
}
