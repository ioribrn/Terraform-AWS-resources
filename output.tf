output "elb_dns_name" {
  value = aws_elb.web_elb.dns_name
}

# output "public_ip" {

#     value = aws_launch_configuration.web_elb.public_ip
# }