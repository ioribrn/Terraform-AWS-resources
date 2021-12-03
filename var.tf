variable "instance_type" {

  type = string
  default = "t2.nano"

}

variable "num_instances" {
    
  default = 1
}

variable "access_key"{
 
   type = string
   default = "<access_key>"
 
}

variable "secret_key"{
 
   type = string
   default = "<secret_key>"
 
}

variable "AMI" {
    type = map(string)
    default =  {
        us-east-1 = "ami-083654bd07b5da81d"   
        }
}

variable "PUBLIC_KEY_PATH" {

    type = string
    default = "fiverr.pub"
}

variable "PRIVATE_KEY_PATH" {

    type = string
    default = "fiverr"
}

variable "EC2_USER" {
    type = string
    default = "ubuntu"

}

variable "AWS_REGION" {
  default = "us-east-1"
}

variable "domain_name" {

    default = "secdevops.fr"
}