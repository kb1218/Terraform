
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-20260313"]
  }
}


resource "aws_instance" "vm" {

  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name      = "id_rsa"
  tags = {
    Name = "tf-server"
  }

}
