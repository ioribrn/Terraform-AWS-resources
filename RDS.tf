# Create a DB subnet group

resource "aws_db_subnet_group" "rds-private-subnet" {
  name = "rds-private-subnet-group"
  subnet_ids = [aws_subnet.prod-subnet-private.id,aws_subnet.prod-subnet-private-2.id]
}


#Create a Security Group to allow mysql port 3306

resource "aws_security_group" "rds-sg" {
  name   = "my-rds-sg"
  vpc_id = aws_vpc.prod-vpc.id

}

# Ingress Security Port 3306
resource "aws_security_group_rule" "mysql_inbound_access" {
  from_port         = 3306
  protocol          = "tcp"
  security_group_id = "${aws_security_group.rds-sg.id}"
  to_port           = 3306
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}


# Step3: Next step is to create MySQL resource

resource "aws_db_instance" "my_test_mysql" {
  allocated_storage           = 20
  storage_type                = "gp2"
  engine                      = "mysql"
  engine_version              = "5.7"
  instance_class              = "${var.db_instance}"
  name                        = "myrdstestmysql"
  username                    = "admin"
  password                    = "admin123"
  parameter_group_name        = "default.mysql5.7"
  db_subnet_group_name        = "${aws_db_subnet_group.rds-private-subnet.name}"
  vpc_security_group_ids      = ["${aws_security_group.rds-sg.id}"]
#   allow_major_version_upgrade = true
  auto_minor_version_upgrade  = true
  availability_zone           = "${aws_subnet.prod-subnet-private.availability_zone}"
#   backup_retention_period     = 35
#   backup_window               = "22:00-23:00"
  maintenance_window          = "Sat:00:00-Sat:03:00"
#   multi_az                    = true
#   skip_final_snapshot         = true
}