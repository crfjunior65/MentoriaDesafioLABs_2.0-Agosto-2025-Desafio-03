#---------------------------------------------------------------------------
# Criação do papel IAM para execucao de tarefas do ECS
#---------------------------------------------------------------------------

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs-task-execution-role-bia"

  # Politica de confianca que permite o ECS assumir este papel
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })

  tags = {
    Name = "ecs-task-execution-role-bia"
  }
}

# Anexa a politica padrao da AWS para execucao de tarefas do ECS
resource "aws_iam_role_policy_attachment" "ecs_task_execution_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_attachment-secret-manager" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}

# Politica para permitir a leitura do parametro de senha do RDS no SSM
resource "aws_iam_policy" "ecs_ssm_parameter_policy" {
  name        = "ecs-ssm-parameter-read-policy"
  description = "Allow ECS tasks to read the RDS password from SSM Parameter Store"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "ssm:GetParameters",
        Resource = "arn:aws:ssm:us-east-1:${data.aws_caller_identity.current.account_id}:parameter/bia-rds-master-password"
      }
    ]
  })
}

# Anexa a nova politica de leitura do SSM a role de execucao da tarefa
resource "aws_iam_role_policy_attachment" "ecs_task_ssm_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecs_ssm_parameter_policy.arn
}
