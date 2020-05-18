resource "aws_eks_node_group" "nodejs" {
  cluster_name    = "${var.cluster-name}"
  node_group_name = "nodejs-ng"
  node_role_arn   = "arn:aws:iam::490752027248:role/nodejs-app"
  subnet_ids      = ["${var.public_subnet_ids[count.index]}"]
  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }
}

resource "aws_iam_role" "eks-node" {
  name = "${var.cluster-name}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}


data "aws_region" "current" {}

locals {
  cdp-eks-node-userdata = <<USERDATA
#!/bin/bash -xe
/etc/eks/bootstrap.sh ${var.cluster-name}
USERDATA
}

// Required Kubernetes Configuration to Join Worker Nodes 
locals {
  config-map-aws-auth = <<CONFIGMAPAWSAUTH


apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: ${aws_iam_role.eks-node.arn}
      username: system:node:{{EC2PublicDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
CONFIGMAPAWSAUTH
}

output "config-map-aws-auth" {
  value = "${local.config-map-aws-auth}"
}
