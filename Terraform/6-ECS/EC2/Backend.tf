terraform {
  backend "s3" {
    bucket  = "crfjunior-tf-state-bia"
    key     = "ecs-EC2/terraform.tfstate"
    region  = "us-east-1"
    profile = "DesafioAWS" # Use your AWS profile if needed
  }
}
