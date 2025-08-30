#---------------------------------------------------------------------------
# Configuração do backend S3 para armazenar o estado do Terraform
#---------------------------------------------------------------------------

terraform {
  backend "s3" {
    bucket = "crfjunior-tf-state-bia"
    #${var.environment}"
    key     = "iam/terraform.tfstate"
    region  = "us-east-1"
    profile = "DesafioAWS" # Use your AWS profile if needed
    #dynamodb_table = "meu-lock-dynamodb"  # Para locking
    #encrypt        = true                 # Criptografar o arquivo de estado
  }
}
