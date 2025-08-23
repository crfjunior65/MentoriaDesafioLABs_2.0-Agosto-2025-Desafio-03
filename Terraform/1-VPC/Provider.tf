# --- AWS ---

provider "aws" {
  # Configuration options
  #alias = "us-east-1"
  profile = "DesafioAWS"
  region  = "us-east-1"
  #alias  = "us-1"
  default_tags {
    tags = {
      Terraform    = "true"
      Environment  = "Desafio-03-Formacao-AWS-bia"
      Management   = "Terraform"
      RegiaoCriada = "us-east-1"
    }
  }
}

provider "aws" {
  # Configuration options
  #alias = "sa-east-1"
  profile = "DesafioAWS"
  region  = "sa-east-1"
  alias   = "sa-1"
  default_tags {
    tags = {
      Terraform    = "true"
      Environment  = "Projeto"
      Management   = "Terraform"
      RegiaoCriada = "sa-east-1"
    }
  }
}
