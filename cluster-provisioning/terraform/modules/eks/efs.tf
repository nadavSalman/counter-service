resource "aws_security_group" "efs" {
  name        = "sg_efs"
  description = "Allow traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "nfs"
    from_port        = 2049
    to_port          = 2049
    protocol         = "TCP"
    cidr_blocks      = [aws_vpc.main.cidr_block]
  }
}

locals {
  subnet_ids = {
    "subnet-a" = aws_subnet.private-eu-west-2a.id,
    "subnet-b" = aws_subnet.public-eu-west-2b.id
  }
}

resource "aws_efs_file_system" "kube" {
  creation_token = "eks-efs"

  depends_on = [aws_subnet.private-eu-west-2a, aws_subnet.public-eu-west-2b]
}

resource "aws_efs_mount_target" "mount" {
  for_each      = local.subnet_ids
  file_system_id = aws_efs_file_system.kube.id
  subnet_id      = each.value
  security_groups = [aws_security_group.efs.id]

  depends_on = [aws_subnet.private-eu-west-2a, aws_subnet.public-eu-west-2b]
}