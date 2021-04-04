##################################################################################
# VARIABLES GLOBAL
##################################################################################
variable "projectname" {
  default = "ECS"
}

variable "region" {
  default = "eu-west-1"
}

variable "environment" {
  default = "NON-PRODUCTION"
}

##################################################################################
# VARIABLES VPC
##################################################################################

variable "vpc_id" {
  default = "vpc-b7b70bd1"
}

variable "subnet_dmz_a" {
  default = "subnet-05da074d"
}

variable "subnet_dmz_b" {
  default = "subnet-0cebe257"
}

variable "subnet_dmz_c" {
  default = "subnet-73c40b15"
}

variable "cidr_block" {
  default = "172.27.0.0/16"
}

variable "ingress_cidr_blocks" {
  default = "172.27.0.0/16"
}

variable "egress_cidr_blocks" {
  default = "0.0.0.0/0"
}

##################################################################################
# VARIABLES EC2
##################################################################################
variable "sec_group" {
  default = "SG-ECS-DMZ"
}

variable "kms_keys_name" {
  default = "arn:aws:kms:eu-west-1:480843451374:key/f31320fc-d324-41a5-bad9-7f2d550174f9"
}

##################################################################################
# VARIABLES EC2
##################################################################################
variable "public_ssl_cert" {
  default = "arn:aws:acm:eu-west-1:033289000621:certificate/71beb57b-b2bd-4109-8f40-3d92c091dd4c"
}
