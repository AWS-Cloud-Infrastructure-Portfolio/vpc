terraform {
  backend "s3" {
    bucket         = "tf-state-secure-vpc-dev"
    key            = "network/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "tf-lock-secure-vpc-dev"
    encrypt        = true
  }
}
