variable "vpc-cidr" {
    description = "this is the value for your vpc"
    default = "10.0.0.0/16"
}

variable "cidr_public_subnet" {
    description = "this is the cidr for public subnet"
    default = "10.0.0.0/24"
  
}