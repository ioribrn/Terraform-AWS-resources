variable "instance_type" {

  type = string
  default = "t3.medium"

}

variable "num_instances" {
    
  default = 1
}

variable "access_key"{
 
   type = string
   default = "AKIAW7IPABMDWPTS7QQL"
 
}

variable "secret_key"{
 
   type = string
   default = "JYDK3mOk+I2j4v35sZ6gNn/3yTSnwU5EQfByZyjj"
 
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