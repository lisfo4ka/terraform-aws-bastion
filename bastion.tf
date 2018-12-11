resource "aws_instance" "bastion" {
  ami                         = "${var.ami_id}"
  instance_type               = "${var.instance_type}"
  subnet_id                   = "${var.public_subnet_id}"
  associate_public_ip_address = true
  key_name                    = "${var.ssh_key_pair_name}"

  vpc_security_group_ids = ["${coalescelist(var.security_group_ids, aws_security_group.bastion.*.id)}"]

  tags = "${merge(var.tags, map(
    "Name", "${var.platform_name}-bastion",
    "kubernetes.io/cluster/${var.platform_name}", "${var.platform_name}",
    "user:tag", "EDP-shared-${var.platform_name}")
  )}"
}

resource "aws_eip" "bastion" {
  tags = "${merge(var.tags, map(
   "Name", "${var.platform_name}-bastion",
   "kubernetes.io/cluster/${var.platform_name}", "${var.platform_name}",
   "user:tag", "EDP-shared-${var.platform_name}")
  )}"
}

resource "aws_eip_association" "eip_bastion" {
  instance_id   = "${aws_instance.bastion.id}"
  allocation_id = "${aws_eip.bastion.id}"
}

resource "aws_security_group" "bastion" {
  count       = "${length(var.security_group_ids) != 0 ? 0 : 1}"
  name        = "${var.platform_name}-bastion"
  description = "Bastion group for ${var.platform_name}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.operator_cidrs}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${var.vpc_id}"

  tags = "${merge(var.tags, map(
    "Name", "${var.platform_name}-bastion",
    "Role", "bastion-node")
  )}"
}
