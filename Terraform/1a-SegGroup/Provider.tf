# --- AWS ---

provider "aws" {
  # Configuration options
  #alias = "us-east-1"
  profile = "DesafioAWS"
  region  = "us-east-1"
  default_tags {
    tags = {
      Terraform   = "true"
      Environment = "Desafio-03-Formacao-AWS"
      Management  = "Terraform"
    }
  }
}
