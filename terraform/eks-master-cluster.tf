data "aws_iam_role" "eks-role" {
  name = "eks-role"
}

resource "aws_security_group" "nodejs-kube" {
  name        = "${var.cluster-name}"
  description = "Cluster communication with worker nodes"
  vpc_id      = "${var.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_eks_cluster" "eks-master-cluster" {
  name          = "${var.cluster-name}"
  role_arn      = "${data.aws_iam_role.eks-role.arn}"
  
  vpc_config {
    security_group_ids = ["${aws_security_group.nodejs-kube.id}"]
    subnet_ids         = ["${data.aws_subnet.public-0.id}", "${data.aws_subnet.public-1.id}"]
  }
}

locals {
  kubeconfig = <<KUBECONFIG


apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.eks-master-cluster.endpoint}
    certificate-authority-data: ${aws_eks_cluster.eks-master-cluster.certificate_authority.0.data}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${var.cluster-name}"
KUBECONFIG
}

output "kubeconfig" {
  value = "${local.kubeconfig}"
}
