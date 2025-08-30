#---------------------------------------------------------------------------
# Dados do provedor AWS e configuração do backend S3
#---------------------------------------------------------------------------

data "aws_availability_zones" "available_zones" {
  state = "available"
}

data "aws_caller_identity" "current" {}
