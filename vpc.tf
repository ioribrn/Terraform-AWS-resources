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
    availability_zone = "us-east-1a"
    tags = {
        Name = "prod-subnet-public"
    }

}
resource "aws_subnet" "prod-subnet-public-2" {

    vpc_id = aws_vpc.prod-vpc.id
    cidr_block ="10.0.4.0/24"
    map_public_ip_on_launch =   "true"
    availability_zone = "us-east-1b"
    tags = {
        Name = "prod-subnet-public-2"
    }

}

resource "aws_subnet" "prod-subnet-private" {

    vpc_id = aws_vpc.prod-vpc.id
    cidr_block ="10.0.3.0/24"
    map_public_ip_on_launch = "false"
    availability_zone =  "us-east-1c"
    tags = {
        Name = "prod-subnet-private"
    }

}
resource "aws_subnet" "prod-subnet-private-2" {

    vpc_id = aws_vpc.prod-vpc.id
    cidr_block ="10.0.5.0/24"
    map_public_ip_on_launch = "false"
    availability_zone =  "us-east-1d"
    tags = {
        Name = "prod-subnet-private-2"
    }

}

