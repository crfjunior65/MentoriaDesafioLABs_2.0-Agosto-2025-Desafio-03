resource "aws_s3_bucket" "s3_state" {
  bucket = "crfjunior-tf-state-bia"
  #bucket = "crfjunior-terraform-state-bia"

  #lifecycle {
  #  prevent_destroy = false #true
  #}
  force_destroy = true
  lifecycle {
    prevent_destroy = false #true
  }

  tags = {
    Name = "crfunior-terraform-state-bia"

  }
}

resource "aws_s3_bucket_versioning" "terrafor_state_versioning" {
  bucket = aws_s3_bucket.s3_state.id
  versioning_configuration {
    status = "Disabled"
    #status = "Enabled"
  }
}

/*
# Criação da Tabela DynamoDB para lock do Terraform State
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "terraform-state-lock"
  }
}
*/
