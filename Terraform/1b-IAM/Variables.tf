variable "Environment" {
  description = "The environment for the Terraform deployment"
  type        = string
  default     = "Desafio-03/Formacao_AWS"

}
variable "AWS_REGION" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}
variable "aws_profile" {
  type    = string
  default = "DesafioAWS"
}
