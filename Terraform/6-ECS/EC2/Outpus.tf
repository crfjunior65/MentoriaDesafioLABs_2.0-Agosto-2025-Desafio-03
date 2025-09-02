output "ecs-cluster-name" {
  value = aws_ecs_cluster.foo.name

}

output "ecs-service-name" {
  value = aws_ecs_service.app.name
}

output "dns-alb" {
  value = aws_lb.main.dns_name
}

output "alb-arn" {
  value = aws_lb.main.arn

}
