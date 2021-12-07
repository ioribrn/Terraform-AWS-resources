resource "aws_elb" "web_elb" {
  name = "web-elb"
  security_groups = [
    "${aws_security_group.security-allowed.id}"
  ]
  subnets = [
    "${aws_subnet.prod-subnet-public.id}",
    "${aws_subnet.prod-subnet-public2.id}"
  ]
  cross_zone_load_balancing   = true

  ## remove instance after 400 s of deletion 
  connection_draining =  true
  connection_draining_timeout = 1000
  #instances = [aws_instance.web1.name]


  #create ssl certification before

  # listener {
  #   instance_port      = 8000
  #   instance_protocol  = "http"
  #   lb_port            = 443
  #   lb_protocol        = "https"
  #   ssl_certificate_id = var.certificate
  # }
health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:80/"
  }
listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "80"
    instance_protocol = "http"
  }

tags = {
    Name = "my-elb"
}
}


##route 53
resource "aws_route53_zone" "primary" {
  name = "secdevops.fr"
}
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "secdevops.fr"
  type    = "A"

  alias {
    name                   = aws_elb.web_elb.dns_name
    zone_id                = aws_elb.web_elb.zone_id
    evaluate_target_health = true
  }
}