
# Internet Gateway 

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.prod-vpc.id

  tags = {
    Name = "main-prod"
  }
}


#route table
resource "aws_route_table" "routegw" {
  vpc_id = aws_vpc.prod-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "routegw"
  }
}

#create association between route table and public subnet

resource "aws_route_table_association" "pvsubnet" {
  subnet_id      = aws_subnet.prod-subnet-public.id
  route_table_id = aws_route_table.routegw.id
}