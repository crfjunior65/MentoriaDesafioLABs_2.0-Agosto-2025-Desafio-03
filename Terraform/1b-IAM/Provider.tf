# --- AWS ---

provider "aws" {
  # Configuration options
  #alias = "east-1"
  profile = var.aws_profile
  region  = var.AWS_REGION
  default_tags {
    tags = {
      Terraform   = "true"
      Environment = "Projeto-${var.Environment}"
      Management  = "Terraform"
      Owner       = "Junior_Fernandes"
    }
  }
}

provider "aws" {
  # Configuration options
  alias   = "east-2"
  profile = var.aws_profile
  region  = "us-east-2"
  default_tags {
    tags = {
      Terraform   = "true"
      Environment = "Projeto-${var.Environment}"
      Management  = "Terraform"
      Owner       = "Junior_Fernandes"
    }
  }
}
