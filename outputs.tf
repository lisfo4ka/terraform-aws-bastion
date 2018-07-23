output "aws_bastion_private_ip" {
  value = "${aws_instance.bastion.private_ip}"
}

output "aws_bastion_public_ip" {
  value = "${aws_instance.bastion.public_ip}"
}

output "aws_bastion_security_group_id" {
  value = "${aws_security_group.bastion.id}"
}
