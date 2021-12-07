variable "instance_type" {

  type = string
  default = "t3.medium"

}

variable "num_instances" {
    
  default = 1
}

variable "access_key"{
 
   type = string
   default = "<access_key_here>"
 
}


variable "secret_key"{
 
   type = string
   default = "<secret_key_here>"
 
}

variable "AMI" {
    type = map(string)
    default =  {
        eu-central-1 = "ami-0a49b025fffbbdac6"   
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
  default = "eu-central-1"
}



variable "db_instance" {
  default = "db.t2.micro"
}


####wp and rds

variable "database_name" {

    default = "myrdstestmysql"
}
variable "database_password" {

        default = "admin123"

}
variable "database_user" {

        default = "admin"

}