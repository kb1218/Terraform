
variable "vpc_cidr_block" {
    type = string 
    
}


variable "subnet_cidr_block" {
  type = string 
  
}

variable "az" {
    type = string
    
}


variable "assign_public_ip" {
    type = bool 
  
  
}



variable "ami_id" {
    description = "contains ami id of ap-southeast-1 region"
    type = string 
    

}


variable "ins_type" {
    description = "instance_type"
    type = string
    
}


variable "key" {
 type = string

}
