resource "aws_iam_role" "infinity" {
  name = "eks-cluster-infinity"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "infinity-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.infinity.name
}

variable "cluster_name" {
  default = "infinity"
  type = string
  description = "AWS EKS CLuster Name"
  nullable = false
}

resource "aws_eks_cluster" "infinity" {
  name     = var.cluster_name
  role_arn = aws_iam_role.infinity.arn

  upgrade_policy {
    support_type = "STANDARD"
  }

  vpc_config {
    subnet_ids = [
      aws_subnet.private-us-east-1a.id,
      aws_subnet.private-us-east-1b.id,
      aws_subnet.public-us-east-1a.id,
      aws_subnet.public-us-east-1b.id
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.infinity-AmazonEKSClusterPolicy]
}