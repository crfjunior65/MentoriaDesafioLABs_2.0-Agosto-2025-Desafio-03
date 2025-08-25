# Arquivo para o Application Load Balancer e seus componentes

# # 1. Security Group para o ALB
# resource "aws_security_group" "alb_sg" {
#   name        = "alb-sg-bia-tf"
#   description = "Permite trafego HTTP para o ALB"
#   vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

#   ingress {
#     description      = "HTTP from anywhere"
#     from_port        = 80
#     to_port          = 80
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "alb-sg-bia-tf"
#   }
# }

# 2. Application Load Balancer
resource "aws_lb" "main" {
  name               = "alb-bia-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.terraform_remote_state.sg.outputs.sg_bia_alb] #[]
  #security_groups    = [aws_security_group.alb_sg.id] - vpc_public_subnets_id
  subnets = [data.terraform_remote_state.vpc.outputs.vpc_public_subnets_id[0],
  data.terraform_remote_state.vpc.outputs.vpc_public_subnets_id[1]]
  #[0:2] # Usando as duas primeiras subnets publicas

  enable_deletion_protection = false

  tags = {
    Name = "alb-bia-tf"
  }
}

# 3. Target Group para a aplicacao
resource "aws_lb_target_group" "app" {
  name        = "tg-bia-app-tf"
  port        = 80 # Porta em que a aplicacao Bia roda no container
  protocol    = "HTTP"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_vpc_id
  target_type = "instance" # Para ECS com EC2 em modo bridge/host

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-299"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "tg-bia-app-tf"
  }
}
