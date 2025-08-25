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
  cpu                      = "1024" # 1 vCPU "256" # 0.25 vCPU
  memory                   = "512"  # 512 MiB

  # Role para que o ECS possa puxar a imagem do ECR e enviar logs
  execution_role_arn = data.terraform_remote_state.iam.outputs.ecs_task_execution_role_arn
  #role_arn           = aws_
  #ecs_instance_role_arn
  #task_execution_role_arn

  # Definicao do container
  container_definitions = jsonencode([
    {
      name      = "bia-app-container"
      image     = "${data.terraform_remote_state.ecr.outputs.ecr_repository_url}:latest"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 3001
          hostPort      = 0 # Mapeamento de porta dinamico
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.bia_app_logs.name
          "awslogs-region"        = var.AWS_REGION #data.terraform_remote_state.vpc.outputs.aws_region
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])

  tags = {
    Name = "bia-app-tf-task"
  }
}
