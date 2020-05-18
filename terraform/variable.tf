
variable "access_key" {
  default = "change-me"
}

variable "secret_key" {
  default = "change-me"
}

variable "cluster-name" {
  default = "nodejs-kube-cluster"
  type    = "string"
}

variable "region" {
  default = "ap-southeast-2"
}

variable "vpc_id" {
  default = "vpc-***"
}

variable "subnet_id" {
  type = "map"

  default = {
    public-0  = "subnet-***"
    public-1  = "subnet-***"
  }
}

variable "public_subnet_ids" {
  default = ["subnet-***", "subnet-***"]
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC."
  default     = ["172.*.*.0/20", "172.*.*.0/20"]
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami_name" {
  default = "ami-04fcc97b5f6edcd89"
}
