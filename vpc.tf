resource "aws_vpc" "prod-vpc" {

  cidr_block = "10.0.0.0/16"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  enable_classiclink = "false"
  instance_tenancy = "default"
  tags = {
      Name = "prod-vpc"
  }

}

resource "aws_subnet" "prod-subnet-public" {

    vpc_id = aws_vpc.prod-vpc.id
    cidr_block ="10.0.1.0/24"
    map_public_ip_on_launch =   "true"
    availability_zone = var.aws_region
    tags = {
        Name = "prod-subnet-public"
    }

}

resource "aws_subnet" "prod-subnet-private" {

    vpc_id = aws_vpc.prod-vpc.id
    cidr_block ="10.0.2.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = var.aws_region
    tags = {
        Name = "prod-subnet-private"
    }
    
}