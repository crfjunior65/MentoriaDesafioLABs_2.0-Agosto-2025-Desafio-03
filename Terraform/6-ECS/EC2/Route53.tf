# Hosted Zone já existente no Route 53
# Se você já tiver a zone criada manualmente, pode usar o data source:
data "aws_route53_zone" "main" {
  name         = "cloudfix.net.br."
  private_zone = false
}



# Criando o record bia.cloudfix.net.br apontando para o ALB
resource "aws_route53_record" "bia" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "bia.cloudfix.net.br"
  type    = "CNAME"
  ttl     = 300
  records = [aws_lb.main.dns_name]

  allow_overwrite = true
}


/*
resource "aws_route53_record" "bia" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "bia.cloudfix.net.br"
  type    = "CNAME"
  ttl     = 300
  records = [aws_lb.main.dns_name] # aqui vai o DNS do ALB
}







data "aws_route53_zone" "main" {
  name         = "cloudfix.net.br." # nome exato, com ponto final
  private_zone = false
}



# Criando o record bia.cludfix.net.br apontando para o ALB
resource "aws_route53_record" "bia" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "bia.cludfix.net.br"
  type    = "A"
  #  aws_lb.main.dns_name
  alias {
    name                   = aws_lb.main.dns_name
    zone_id                = aws_lb.main.zone_id
    evaluate_target_health = true
  }
}
*/
