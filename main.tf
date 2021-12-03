# resource "aws_instance" "web1" {
#     count = var.num_instances
#     ami = lookup(var.AMI,var.AWS_REGION)
#     instance_type = var.instance_type
#     # VPC
#     subnet_id = "${aws_subnet.prod-subnet-public.id}"
#     # Security Group
#     vpc_security_group_ids = ["${aws_security_group.security-allowed.id}"]
#     # the Public SSH key
#     key_name = "${aws_key_pair.region-key-pair.id}"

#     private_ip = "10.0.1.4"
#     # nginx installation
#     provisioner "file" {
#         source = "nginx.sh"
#         destination = "/tmp/nginx.sh"
#     }
#     provisioner "remote-exec" {
#         inline = [
#              "chmod +x /tmp/nginx.sh",
#              "sudo /tmp/nginx.sh"
#         ]
#     }
#     connection {
#         host = coalesce(self.public_ip, self.private_ip)
#         type = "ssh"
#         user = "${var.EC2_USER}"
#         private_key = "${file("${var.PRIVATE_KEY_PATH}")}"
#     }
# }
// Sends your public key to the instance
resource "aws_key_pair" "region-key-pair" {
  key_name   = "region-key-pair"
  public_key = file(var.PUBLIC_KEY_PATH)
}


#assigne a public static ip to the instance 

# resource "aws_eip" "lb" {
#   instance = aws_instance.web1[0].id
#   vpc      = true
# }