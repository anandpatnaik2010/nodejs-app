terraform {
  backend "s3" {
    bucket = "nodejs-application-test"
    key    = "nodejs-terraform-state/terraform.tfstate"
    region = "ap-southeast-2"
    #dynamodb_table = "nodejs-terraform-backend"
  }
}
