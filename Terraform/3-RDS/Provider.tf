# --- AWS ---

provider "aws" {
  # Configuration options
  #alias = "us-east-1"
  profile = var.aws_profile
  region  = var.AWS_REGION
  default_tags {
    tags = {
      Terraform    = "true"
      Environment  = "Desafio-03-Formacao-AWS-bia"
      Management   = "Terraform"
      RegiaoCriada = "us-east-1"
      Owner        = "JuniorFernandes"
    }
  }
}
