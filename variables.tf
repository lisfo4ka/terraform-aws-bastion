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

variable "instance_type" {
  type        = "string"
  description = "Instance type for bastion host"
  default     = "t2.nano"
}

variable "security_group_ids" {
  type        = "list"
  description = "List of security groups for Bastion host"
}

variable "operator_cidrs" {
  type        = "list"
  description = "CIDRS that is allowed to connect to bastion"
  default     = []
}

variable "ssh_key_pair_name" {
  description = "Key pair name in AWS to use for access to nodes"
}

variable "iam_instance_profile" {
  type        = "string"
  description = "IAM Instance Profile to launch the instance with"
  default     = ""
}

variable "tags" {
  type        = "map"
  description = "A map of tags to add to all resources."
}
