#* Recurso: aws_autoscaling_group "ecs_ec2"
#   * Propósito: Garantir que o número desejado de instâncias EC2 esteja sempre em execução. Ele as inicia, monitora e
#     substitui se falharem.
#   * Dependências:
#       * aws_launch_template.ecs_ec2: Precisa do ID do template para saber como criar as instâncias.
#       * data.terraform_remote_state.vpc: Para saber em quais subnets (vpc_zone_identifier) as instâncias devem ser
#         lançadas.

resource "aws_autoscaling_group" "ecs" {
  name_prefix = "cluster-ecs-bia-asg-"
  vpc_zone_identifier = [data.terraform_remote_state.vpc.outputs.vpc_public_subnets_id[0],
  data.terraform_remote_state.vpc.outputs.vpc_public_subnets_id[1]]
  min_size                  = 0
  desired_capacity          = 1
  max_size                  = 2
  health_check_grace_period = 0
  health_check_type         = "EC2"
  protect_from_scale_in     = false

  launch_template {
    id      = aws_launch_template.ecs_ec2.id
    version = "$Latest"
  }

  lifecycle {
    ignore_changes = [desired_capacity]
  }

  tag {
    key                 = "Name"
    value               = "cluster-bia-tf"
    propagate_at_launch = true
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = ""
    propagate_at_launch = true
  }
}
