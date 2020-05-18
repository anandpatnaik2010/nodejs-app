data "aws_vpc" "cdp-vpc" {
  id = "${var.vpc_id}"
}

data "aws_subnet" "public-0" {
  id = "${var.subnet_id["public-0"]}"
}

data "aws_subnet" "public-1" {
  id = "${var.subnet_id["public-1"]}"
}