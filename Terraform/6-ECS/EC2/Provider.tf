provider "aws" {
  region  = var.AWS_REGION
  profile = var.aws_profile
  default_tags {
    tags = {
      Terraform   = "true"
      Environment = var.environment
      Projeto     = var.projeto
      Cliente     = var.cliente
      Autor       = var.autor
    }
  }
}
