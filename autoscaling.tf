resource "aws_launch_configuration" "as_conf" {
  name      = "web_config"
  image_id  = lookup(var.AMI,var.AWS_REGION)
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.region-key-pair.id}"
  security_groups = [aws_security_group.security-allowed.id]
  user_data = "#!/bin/bash\napt-get update\napt-get -y install net-tools nginx\nMYIP=`ifconfig | grep -E '(inet 10)|(addr:10)' | awk '{ print $2 }' | cut -d ':' -f2`\necho 'this is: '$MYIP > /var/www/html/index.html"
}

resource "aws_autoscaling_group" "foobar" {
  name                      = "foobar"
  max_size                  = 4
  min_size                  = 2
  #link elb with autoscaling group
  health_check_grace_period = 300
  health_check_type         = "ELB"
  load_balancers = [aws_elb.web_elb.name]
#   desired_capacity          = 1
  force_delete              = true
#   placement_group           = aws_placement_group.test.id
  launch_configuration      = aws_launch_configuration.as_conf.name
  vpc_zone_identifier       = [aws_subnet.prod-subnet-public.id,aws_subnet.prod-subnet-public-2.id]

  tag {
    key                 = "Name"
    value               = "ec2 instance"
    propagate_at_launch = true
  }
  #[aws_subnet.example1.id, aws_subnet.example2.id]

}