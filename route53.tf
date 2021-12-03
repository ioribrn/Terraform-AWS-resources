resource "aws_route53_zone" "my_hosted_zone" {
  name = var.domain_name
  tags = {
      Environment = "dev"

  }
}


resource "aws_route53_record" "www" {

    zone_id = aws_route53_zone.my_hosted_zone.zone_id
    name = "www.secdevops.fr"
    type="A"
    ttl = "300"
    records = [aws_eip.lb.public_ip]
}

output "name_server" {

    value = aws_route53_zone.my_hosted_zone.name_servers
}

###dev

