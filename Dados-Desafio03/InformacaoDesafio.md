# Desafio 03: Terraform, IAC, Mensageria e Arquitetura Serverless (AGO/25)

## 🎯 Objetivo do Desafio

> Lançar a aplicação BIA com Terraform, fazendo o deploy no Amazon ECS. O desafio contempla dois cenários: um sem Application Load Balancer (ALB) e outro com ALB, domínio e HTTPS.

---

## 📋 Detalhes do Serviço

*   **SERVIÇO DESAFIO:** Terraform + ECS + ALB + RDS
*   **PRÉ-REQUISITO:** É necessário ter completado o **Desafio 02**.

---

## ⚠️ Observações Importantes

*   **Etapa não-linear:** A configuração do *listener* para a porta `443` no ALB é um ponto de atenção.
*   **Referência:** O processo é detalhado no **dia 3** do evento "Imersão AWS & IA".
*   **Escopo do Terraform:** A criação do certificado no ACM (AWS Certificate Manager) e a configuração de zonas no Route 53 **NÃO PRECISAM** ser feitas com Terraform para este desafio.

---

## ✍️ Modelo de Postagem para o LinkedIn

```
Foi pra conta mais um Desafio incrível da Mentoria da Formação AWS com Henrylle Maia.

Durante o Bootcamp Imersão AWS nós lançamos um ambiente inteiro na AWS com alta disponibilidade e todos os recursos necessários. Agora chegou o grande momento de construir todo esse ambiente usando IAC com Terraform.

Após um `terraform apply`, lançamos todas as dependências necessárias e construímos todos os recursos, desde a máquina de trabalho para apoiar nossas ações na nuvem, até o cluster inteiro conectado com ALB, repositório no ECR, RDS com secrets, security groups e muito mais.

Experiência rica que amadurece muito meu entendimento do uso de Terraform com AWS.
```
