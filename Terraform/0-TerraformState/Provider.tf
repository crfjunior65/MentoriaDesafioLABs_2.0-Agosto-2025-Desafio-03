# --- AWS ---

provider "aws" {
  region  = var.AWS_REGION
  profile = "DesafioAWS"
  default_tags {
    tags = {
      Terraform   = "true"
      Environment = var.Environment
      Project     = "Mentoria-Projetos_AWS"
      Owner       = "CRF_Junior"
      CreatedBy   = "Terraform"
      Management  = "Terraform"
    }
  }
}
