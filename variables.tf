variable "vpc_id" {} 

variable "platform_name" {
  type = "string"
}

variable "public_subnet_id" {
  type = "string"
}

variable "ami_id" {
  type    = "string"
  default = "ami-dd3c0f36"
}

variable "operator_cidrs" {
  type        = "list"
  description = "CIDRS that is allowed to connect to bastion"
}

variable "key_name" {
  default = "demo-regeneron"
}

variable "tags" {
  type        = "map"
  description = "A map of tags to add to all resources."
}
