resource "aws_ecs_cluster" "foo" {
  name = "cluster-bia-tf"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}