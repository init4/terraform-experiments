resource "aws_instance" "slag" {
  ami = "ami-083ebc5a49573896a"
  instance_type = "t2.micro" 
  private_ip = "10.0.2.101"
  availability_zone = aws_subnet.internal.availability_zone
  subnet_id = aws_subnet.internal.id 
  associate_public_ip_address = lookup(var.awsprops, "publicip")
  key_name = lookup(var.awsprops, "keyname")
  user_data = file("userdata_dinobots.sh")
  security_groups = [ aws_security_group.allow_all.id ]
  vpc_security_group_ids = [ aws_security_group.allow_all.id ]
  root_block_device {
    delete_on_termination = true
    iops = 150
    volume_size = 50
    volume_type = "gp2"
  }
  tags = {
    Name ="slag"
    Environment = "dinobots"
    OS = "Linux"
    Managed = "nope"
  }
  lifecycle {
    ignore_changes = [ security_groups ]
    create_before_destroy = true
  }
  depends_on = [ aws_security_group.allow_all ]
}

resource "aws_instance" "sludge" {
  ami = "ami-083ebc5a49573896a"
  instance_type = "t2.micro" 
  private_ip = "10.0.2.102"
  availability_zone = aws_subnet.internal.availability_zone
  subnet_id = aws_subnet.internal.id 
  associate_public_ip_address = lookup(var.awsprops, "publicip")
  key_name = lookup(var.awsprops, "keyname")
  user_data = file("userdata_dinobots.sh")
  security_groups = [ aws_security_group.allow_all.id ]
  vpc_security_group_ids = [ aws_security_group.allow_all.id ]
  root_block_device {
    delete_on_termination = true
    iops = 150
    volume_size = 50
    volume_type = "gp2"
  }
  tags = {
    Name ="sludge"
    Environment = "dinobots"
    OS = "Linux"
    Managed = "nope"
  }
  lifecycle {
    ignore_changes = [ security_groups ]
    create_before_destroy = true
  }
  depends_on = [ aws_security_group.allow_all ]
}

resource "aws_instance" "snarl" {
  ami = "ami-083ebc5a49573896a"
  instance_type = "t2.micro" 
  private_ip = "10.0.2.103"
  availability_zone = aws_subnet.internal.availability_zone
  subnet_id = aws_subnet.internal.id 
  associate_public_ip_address = lookup(var.awsprops, "publicip")
  key_name = lookup(var.awsprops, "keyname")
  user_data = file("userdata_dinobots.sh")
  security_groups = [ aws_security_group.allow_all.id ]
  vpc_security_group_ids = [ aws_security_group.allow_all.id ]
  root_block_device {
    delete_on_termination = true
    iops = 150
    volume_size = 50
    volume_type = "gp2"
  }
  tags = {
    Name ="snarl"
    Environment = "dinobots"
    OS = "Linux"
    Managed = "nope"
  }
  lifecycle {
    ignore_changes = [ security_groups ]
    create_before_destroy = true
  }
  depends_on = [ aws_security_group.allow_all ]
}

resource "aws_instance" "swoop" {
  ami = "ami-083ebc5a49573896a"
  instance_type = "t2.micro" 
  private_ip = "10.0.2.104"
  availability_zone = aws_subnet.internal.availability_zone
  subnet_id = aws_subnet.internal.id 
  associate_public_ip_address = lookup(var.awsprops, "publicip")
  key_name = lookup(var.awsprops, "keyname")
  user_data = file("userdata_dinobots.sh")
  security_groups = [ aws_security_group.allow_all.id ]
  vpc_security_group_ids = [ aws_security_group.allow_all.id ]
  root_block_device {
    delete_on_termination = true
    iops = 150
    volume_size = 50
    volume_type = "gp2"
  }
  tags = {
    Name ="swoop"
    Environment = "dinobots"
    OS = "Linux"
    Managed = "nope"
  }
  lifecycle {
    ignore_changes = [ security_groups ]
    create_before_destroy = true
  }
  depends_on = [ aws_security_group.allow_all ]
}

output "slag_public" {
  value = aws_instance.slag.public_ip
}
output "slag_internal" {
  value = aws_instance.slag.private_ip
}
output "sludge_public" {
  value = aws_instance.sludge.public_ip
}
output "sludge_internal" {
  value = aws_instance.sludge.private_ip
}
output "snarl_public" {
  value = aws_instance.snarl.public_ip
}
output "snarl_internal" {
  value = aws_instance.snarl.private_ip
}
output "swoop_public" {
  value = aws_instance.swoop.public_ip
}
output "swoop_internal" {
  value = aws_instance.swoop.private_ip
}

