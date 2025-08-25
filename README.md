# Desafio 03: Infraestrutura como Código (IaC) na AWS com Terraform

## Visão Geral

Este projeto implementa uma infraestrutura completa e automatizada na AWS para hospedar a aplicação "Bia", um serviço web full-stack. O principal objetivo é demonstrar o domínio de conceitos de Infraestrutura como Código (IaC) utilizando o Terraform para provisionar e gerenciar uma arquitetura cloud-nativa, segura e escalável.

A arquitetura foi projetada para ser robusta, utilizando serviços gerenciados da AWS para otimizar a operação e a manutenção.

## Arquitetura da Solução

A infraestrutura provisionada pelo Terraform consiste nos seguintes componentes principais:

- **Rede (VPC):** Uma Virtual Private Cloud customizada com sub-redes públicas e privadas distribuídas em múltiplas zonas de disponibilidade para garantir alta disponibilidade.
- **Segurança:** Security Groups para controle de tráfego em nível de instância e Roles do IAM para gerenciamento de permissões granulares entre os serviços.
- **Banco de Dados (RDS):** Uma instância do Amazon RDS (PostgreSQL/MySQL) executando em uma sub-rede privada, com credenciais gerenciadas de forma segura pelo AWS Secrets Manager.
- **Containerização (Docker & ECR):** A aplicação "Bia" é containerizada com o Docker, e a imagem é armazenada no Amazon Elastic Container Registry (ECR).
- **Orquestração (ECS com EC2):** O Amazon Elastic Container Service (ECS) é utilizado para orquestrar os contêineres da aplicação, com instâncias EC2 como capacidade computacional, gerenciadas por um Auto Scaling Group.
- **Load Balancer:** Um Application Load Balancer (ALB) distribui o tráfego de entrada para os contêineres, garantindo escalabilidade e resiliência.

## Pontos Fortes e Boas Práticas Adotadas

Este projeto se destaca pela aplicação de diversas boas práticas de mercado:

- **Infraestrutura como Código (IaC) Modular:** A utilização do Terraform com uma estrutura de diretórios modular, onde cada componente da infraestrutura (VPC, IAM, RDS, etc.) é isolado, facilita a manutenção, o reuso de código e a colaboração.
- **Gerenciamento de Estado Remoto:** O estado do Terraform é armazenado de forma segura e centralizada em um backend S3, uma prática essencial para ambientes de produção e trabalho em equipe.
- **Automação de Deploy (CI/CD):** A presença de scripts de deploy (`deploy-ecs.sh`) e um arquivo `buildspec.yml` demonstra a preparação para um pipeline de integração e entrega contínua (CI/CD) com ferramentas como o AWS CodeBuild.
- **Segurança por Design:** A arquitetura foi planejada com segurança em mente, utilizando sub-redes privadas para o banco de dados, roles do IAM com o princípio do menor privilégio e o AWS Secrets Manager para proteger informações sensíveis.
- **Foco em Resiliência:** O uso de múltiplas zonas de disponibilidade, Auto Scaling Groups e um Load Balancer garante que a aplicação possa se recuperar de falhas e escalar de acordo com a demanda.

## A Jornada de Aprendizado Contínuo

A construção deste projeto é um testemunho do aprendizado contínuo. Durante o desenvolvimento, enfrentamos e superamos desafios técnicos que aprofundaram o conhecimento sobre a integração fina entre os serviços da AWS e o Terraform.

- **IAM Roles vs. Instance Profiles:** Um dos principais aprendizados foi a distinção crucial entre a `execution_role_arn` (utilizada pelo serviço ECS para acessar outros recursos da AWS) e o `instance_profile` (anexado a uma instância EC2). A correção deste detalhe no `TaskDefinition.tf` foi fundamental para o sucesso do deploy e solidificou o entendimento sobre o funcionamento do IAM.
- **Alocação de Recursos (CPU/Memória):** O ajuste fino da alocação de memória entre a definição da tarefa ECS (`aws_ecs_task_definition`) e a definição do contêiner (`container_definitions`) demonstrou a importância de entender como os recursos são solicitados e gerenciados pelo orquestrador para garantir um deploy válido.

Cada erro não foi um bloqueio, mas uma oportunidade de refinar a infraestrutura e solidificar os conceitos de cloud computing.

## Estrutura de Diretórios do Terraform

A organização modular do Terraform é um dos pilares deste projeto:

```
/Terraform
├── 0-TerraformState/ # Configuração do Backend S3 para o estado remoto
├── 1-VPC/            # Definição da VPC, sub-redes, gateways e tabelas de rota
├── 1a-SegGroup/      # Gerenciamento dos Security Groups
├── 1b-IAM/           # Criação das Roles e Policies do IAM
├── 3-RDS/            # Provisionamento do Banco de Dados RDS e Secrets Manager
├── 3a-Orquestrador/  # Instância EC2 para administração (Bastion Host)
├── 5-ECR/            # Criação do repositório ECR para a imagem Docker
└── 6-ECS/            # Configuração do Cluster ECS, Task Definition, Service e ALB
```
