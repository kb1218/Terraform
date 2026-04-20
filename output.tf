output "public_ip" {
    value = aws_instance.vm.public_ip
}

output "vpc_id" {
  value = aws_vpc.vnet.id
}

output "subnet_id" {
  value = aws_subnet.pub.id 
}

output "sg" {
  value = aws_security_group.sg.id
}
