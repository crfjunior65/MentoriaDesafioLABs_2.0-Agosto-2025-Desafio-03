#Criação do Provedor de Capacidade (Capacity Provider)
#  Este recurso atua como a "ponte" que conecta o Auto Scaling Group (sua capacidade de infraestrutura) ao Cluster
#  ECS (o orquestrador).
#   * Recurso: aws_ecs_capacity_provider "ecs_ec2"
#   * Propósito: Informar ao ECS sobre o grupo de instâncias que ele pode usar para executar tarefas.
#   * Dependências:
#       * aws_autoscaling_group.ecs_ec2: Precisa do ARN (Amazon Resource Name) do ASG para se vincular a ele.

resource "aws_ecs_capacity_provider" "bia" {
  name = "cluster-bia"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.ecs.arn
    managed_termination_protection = "DISABLED"

    managed_scaling {
      maximum_scaling_step_size = 2
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 100
    }
  }
}

resource "aws_ecs_cluster_capacity_providers" "main" {
  cluster_name       = aws_ecs_cluster.foo.name
  capacity_providers = [aws_ecs_capacity_provider.bia.name]

  default_capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.bia.name
    base              = 1
    weight            = 100
  }
}


#Associação do Provedor de Capacidade ao Cluster
#  O passo final é registrar oficialmente o Capacity Provider no cluster e definir como ele deve ser usado.
#   * Recurso: aws_ecs_cluster_capacity_providers "ecs_ec2"
#   * Propósito: Anexar o provedor de capacidade ao cluster e definir a estratégia padrão (por exemplo, como
#     distribuir as tarefas entre os provedores disponíveis).
#   * Dependências:
#       * aws_ecs_cluster.foo: Precisa do nome do cluster ao qual será associado.
#       * aws_ecs_capacity_provider.ecs_ec2: Precisa do nome do provedor de capacidade que está sendo anexado.
#  O Terraform gerencia essa ordem de dependências automaticamente. No entanto, conhecê-la é a chave para entender o
#  fluxo de criação e para diagnosticar erros de forma eficaz.
