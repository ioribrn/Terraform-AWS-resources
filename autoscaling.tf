resource "aws_launch_configuration" "as_conf" {
  name          = "web_config"
  image_id      = lookup(var.AMI,var.AWS_REGION)
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.region-key-pair.id}"
  security_groups = [aws_security_group.security-allowed.id]
}

resource "aws_autoscaling_group" "foobar" {
  name                      = "foobar"
  max_size                  = 3
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
#   desired_capacity          = 1
  force_delete              = true
#   placement_group           = aws_placement_group.test.id
  launch_configuration      = aws_launch_configuration.as_conf.name
  vpc_zone_identifier       = [aws_subnet.prod-subnet-public.id]

  tag {
    key                 = "Name"
    value               = "ec2 instance"
    propagate_at_launch = true
  }
  #[aws_subnet.example1.id, aws_subnet.example2.id]

}