resource "aws_launch_configuration" "as_conf" {
  name      = "web_config"
  image_id  = lookup(var.AMI,var.AWS_REGION)
  depends_on = [aws_efs_mount_target.efs-mt-example]
  instance_type = var.instance_type
  key_name = "${aws_key_pair.region-key-pair.id}"
  security_groups = [aws_security_group.security-allowed.id]
  user_data = data.template_file.init.rendered
  #user_data = "#!/bin/bash\napt-get update\napt-get -y install wget php php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc unzip net-tools nginx\ncd /var/www\nsudo wget https://wordpress.org/latest.zip\nsudo unzip latest.zip\nsudo rm -rif html\nsudo mkdir html\nsudo mv ./wordpress/* html\ncd html\ncd /var/www/html\ncp wp-config-sample.php wp-config.php\nsudo sed -ie \"s/database_name_here/myrdstestmysql/g\" wp-config.php\nsudo sed -ie \"s/username_here/admin/g\" wp-config.php\nsudo sed -ie \"s/password_here/admin123/g\" wp-config.php\nsudo sed -ie \"s/localhost/admin123/g\" wp-config.php"

}


data "template_file" "init" {
  template = "${file("router-init.sh.tpl")}"

vars = {
    rds_localhost = "${aws_db_instance.my_test_mysql.endpoint}"
  }
}
resource "aws_autoscaling_group" "foobar" {
  name                      = "foobar"
  max_size                  = 4
  min_size                  = 1
  #link elb with autoscaling group
  health_check_grace_period = 1000
  health_check_type         = "ELB"
  load_balancers = [aws_elb.web_elb.name]
#   desired_capacity          = 1
  force_delete              = false
#   placement_group           = aws_placement_group.test.id
  launch_configuration      = aws_launch_configuration.as_conf.name
  vpc_zone_identifier       = [aws_subnet.prod-subnet-public.id,aws_subnet.prod-subnet-public2.id]

  tag {
    key                 = "Name"
    value               = "ec2 instance"
    propagate_at_launch = true
  }
  #[aws_subnet.example1.id, aws_subnet.example2.id]

}