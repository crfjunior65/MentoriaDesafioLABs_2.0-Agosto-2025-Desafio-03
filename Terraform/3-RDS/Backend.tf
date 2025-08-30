#---------------------------------------------------------------------------
# Configuração do backend RDS para armazenar o estado do Terraform
#---------------------------------------------------------------------------

terraform {
  backend "s3" {
    bucket  = "crfjunior-tf-state-bia"
    key     = "rds/terraform.tfstate"
    region  = "us-east-1"
    profile = "DesafioAWS"
    #dynamodb_table = "meu-lock-dynamodb"  # Para locking
    #encrypt        = true                 # Criptografar o arquivo de estado
  }
}
