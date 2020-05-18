resource "aws_instance" "jenkins" {
  ami                         = "${var.ami_name}"
  instance_type               = "${var.instance_type}"
  subnet_id                   = "${var.subnet_id["public-0"]}"
  vpc_security_group_ids      = ["${aws_security_group.jenkins.id}"]
  key_name                    = "anand-test"
}

resource "aws_security_group" "jenkins" {
  name        = "${var.cluster-name}"
  description = "Allow traffic"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    description = "SSH"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
