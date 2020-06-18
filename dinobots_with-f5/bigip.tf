resource "aws_instance" "bigip1" {
  ami = "ami-06c56f34aa094a0dd"
  instance_type = "t2.medium"
  associate_public_ip_address = true
  private_ip = "10.0.0.10"
  availability_zone = aws_subnet.management.availability_zone
  subnet_id = aws_subnet.management.id
  security_groups = [aws_security_group.allow_all.id]
  vpc_security_group_ids = [aws_security_group.allow_all.id]
  user_data = file("userdata_bigip1.sh")
  key_name = lookup(var.awsprops, "keyname")
  root_block_device { delete_on_termination = true }
  tags = {
    Name = "bigip1"
  }
  lifecycle {
    ignore_changes = [ security_groups ]
    create_before_destroy = true
  }
}

resource "aws_network_interface" "external" {
  subnet_id = aws_subnet.external.id
  private_ips = ["10.0.1.10", "10.0.1.100"]
  security_groups = [aws_security_group.allow_all.id]
  attachment {
    instance = aws_instance.bigip1.id
    device_index = 1
  }
}

resource "aws_network_interface" "internal" {
  subnet_id = aws_subnet.internal.id
  private_ips = ["10.0.2.10", "10.0.2.100"]
  security_groups = [aws_security_group.allow_all.id]
  attachment {
    instance = aws_instance.bigip1.id
    device_index = 2 
  }
}

resource "aws_eip" "eip_vip" {
  vpc                       = true
  network_interface         = aws_network_interface.external.id
  associate_with_private_ip = "10.0.1.100"
}

output "bigip1" {
  value = "${aws_instance.bigip1.public_ip}"
}

output "bigip1_vip1" {
  value = "${aws_eip.eip_vip.public_ip}"
}

