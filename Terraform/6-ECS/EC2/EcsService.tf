# Arquivo final para o Servico ECS (ECS Service)

resource "aws_ecs_service" "app" {
  name            = "bia-app-tf-service"
  cluster         = aws_ecs_cluster.foo.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1 # Inicia com 1 instancia da aplicacao
  launch_type     = "EC2"

  # Tempo para o container iniciar antes de comecar os health checks
  health_check_grace_period_seconds = 30

  # Conecta o servico ao nosso Application Load Balancer
  load_balancer {
    target_group_arn = aws_lb_target_group.app.arn
    container_name   = "bia-app-container"
    container_port   = 3001
  }

  # Garante que o listener do ALB esteja pronto antes de criar o servico
  depends_on = [aws_lb_listener.http]

  tags = {
    Name = "bia-app-tf-service"
  }
}
