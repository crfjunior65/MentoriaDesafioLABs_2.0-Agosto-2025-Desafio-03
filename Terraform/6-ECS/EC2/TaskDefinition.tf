# Arquivo para a Definicao da Tarefa ECS (Task Definition)

# Log Group no CloudWatch para receber os logs do container
resource "aws_cloudwatch_log_group" "bia_app_logs" {
  name = "/ecs/bia-app-tf"

  tags = {
    Name = "bia-app-tf-logs"
  }
}

# A definicao da tarefa (o blueprint da aplicacao)
resource "aws_ecs_task_definition" "app" {
  family                   = "bia-app-tf-task"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  #cpu                      = "1024" # 1 vCPU "256" # 0.25 vCPU
  #memory                   = "512"  # 512 MiB

  # Role para que o ECS possa puxar a imagem do ECR e enviar logs
  execution_role_arn = data.terraform_remote_state.iam.outputs.ecs_task_execution_role_arn

  # Definicao do container
  container_definitions = jsonencode([
    {
      name      = "bia-app-container"
      image     = "${data.terraform_remote_state.ecr.outputs.ecr_repository_url}:latest"
      cpu       = 1024
      memory    = 400
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 0 # Mapeamento de porta dinamico
        }
      ]
      environment = [
        {
          name  = "PORT",
          value = "8080"
        },
        {
          name  = "DB_PORT"
          value = tostring(data.terraform_remote_state.rds.outputs.db_db_port)
        },
        {
          name  = "DB_HOST"
          value = data.terraform_remote_state.rds.outputs.db_db_address
        },
        {
          name  = "DB_NAME"
          value = data.terraform_remote_state.rds.outputs.db_db_name
        },
        {
          name  = "DB_USER"
          value = data.terraform_remote_state.rds.outputs.db_db_username
        },
        {
          name  = "AWS_REGION"
          value = var.AWS_REGION
        }
      ]
      secrets = [
        {
          name      = "DB_PWD",
          valueFrom = data.terraform_remote_state.rds.outputs.db_secret_arn
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.bia_app_logs.name
          "awslogs-region"        = var.AWS_REGION
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])

  tags = {
    Name = "bia-app-tf-task"
  }
}
