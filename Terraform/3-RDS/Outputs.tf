output "db_end_point" {
  value = aws_db_instance.db-Projeto.endpoint
}

output "db_arn" {
  value = aws_db_instance.db-Projeto.arn
}

output "db_db_name" {
  value = aws_db_instance.db-Projeto.db_name
}

output "db_db_id" {
  value = aws_db_instance.db-Projeto.id
}

output "db_db_username" {
  value = aws_db_instance.db-Projeto.username
}

output "db_db_port" {
  value = aws_db_instance.db-Projeto.port
}

output "db_db_address" {
  value = aws_db_instance.db-Projeto.address
}

output "db_db_engine" {
  value = aws_db_instance.db-Projeto.engine
}

output "db_db_identifier" {
  value = aws_db_instance.db-Projeto.identifier
}

output "db_db_password" {
  sensitive = true
  value     = aws_db_instance.db-Projeto.password
}

output "db_secret_arn" {
  description = "ARN of the Secrets Manager secret for the DB"
  value       = aws_secretsmanager_secret.db_password_secret.arn
}

output "db_secret_name" {
  description = "Name of the Secrets Manager secret for the DB"
  value       = aws_secretsmanager_secret.db_password_secret.name
}
