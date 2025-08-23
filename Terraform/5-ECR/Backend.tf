terraform {
  backend "s3" {
    bucket  = "crfjunior-tf-state-bia"
    key     = "ecr/terraform.tfstate"
    region  = "us-east-1"
    profile = "DesafioAWS" # Perfil do AWS CLI
    #dynamodb_table = "meu-lock-dynamodb"  # Para locking
    #encrypt        = true                 # Criptografar o arquivo de estado
  }
}
