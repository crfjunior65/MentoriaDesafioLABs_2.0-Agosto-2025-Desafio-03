#---------------------------------------------------------------------------
# Configuração do backend S3 para armazenar o estado do Terraform
#---------------------------------------------------------------------------

# Remote State
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket  = "crfjunior-tf-state-bia"
    key     = "vpc/terraform.tfstate"
    region  = "us-east-1"
    profile = "DesafioAWS" # Use your AWS profile if needed
  }
}

# Remote State Security Group
data "terraform_remote_state" "sg" {
  backend = "s3"
  config = {
    bucket  = "crfjunior-tf-state-bia"
    key     = "sg/terraform.tfstate"
    region  = "us-east-1"
    profile = "DesafioAWS" # Use your AWS profile if needed
  }
}
