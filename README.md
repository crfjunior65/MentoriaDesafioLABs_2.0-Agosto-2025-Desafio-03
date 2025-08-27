# 🚀 Projeto BIA: Infraestrutura como Código (IaC) na AWS com Terraform

![Terraform](https://img.shields.io/badge/Terraform-%237B42BC.svg?style=for-the-badge&logo=terraform&logoColor=white) ![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white) ![NodeJS](https://img.shields.io/badge/node.js-6DA55F?style=for-the-badge&logo=node.js&logoColor=white) ![React](https://img.shields.io/badge/react-%2320232a.svg?style=for-the-badge&logo=react&logoColor=%2361DAFB) ![Amazon ECS](https://img.shields.io/badge/Amazon%20ECS-FF9900.svg?style=for-the-badge&logo=amazon-ecs&logoColor=white)

Este repositório contém a implementação do **Projeto BIA**, uma aplicação web full-stack (Node.js + React) com sua infraestrutura na AWS totalmente provisionada e gerenciada com **Terraform**.

O projeto é um blueprint completo e prático para a implantação de aplicações modernas, seguras e escaláveis na nuvem, seguindo as melhores práticas de **Infraestrutura como Código (IaC)**, **CI/CD** e **Segurança**.

## 📜 Índice

- [✨ Pontos Fortes da Arquitetura](#-pontos-fortes-da-arquitetura)
- [🏗️ Arquitetura da Solução](#️-arquitetura-da-solução)
- [🛠️ Tecnologias Utilizadas](#️-tecnologias-utilizadas)
- [🗂️ Estrutura de Diretórios](#️-estrutura-de-diretórios)
- [⚙️ Pré-requisitos](#️-pré-requisitos)
- [🚀 Subindo a Infraestrutura na AWS](#-subindo-a-infraestrutura-na-aws)
- [🐳 Rodando Localmente com Docker](#-rodando-localmente-com-docker)

## ✨ Pontos Fortes da Arquitetura

Este projeto não é apenas uma aplicação, mas um ecossistema de deploy robusto que se destaca por:

- 🏛️ **Infraestrutura como Código (IaC) Modular**: O Terraform é organizado em módulos independentes (VPC, IAM, RDS, etc.), facilitando a manutenção, o reuso e a colaboração.
- 🔒 **Segurança por Design (Security by Design)**: A arquitetura isola recursos críticos (como o banco de dados em sub-redes privadas) e gerencia segredos com o **AWS Secrets Manager**. As permissões são granulares, seguindo o princípio do menor privilégio com **IAM Roles**.
- 🔄 **Automação de CI/CD**: O projeto está pronto para um pipeline de deploy automatizado. O `buildspec.yml` define os passos para o AWS CodeBuild, e o script `deploy-ecs.sh` orquestra a atualização no ECS sem downtime.
- ☁️ **Cloud-Native e Escalável**: O uso de serviços gerenciados como **ECS**, **RDS** e **Application Load Balancer** cria uma base resiliente, escalável e de alta disponibilidade, distribuída em múltiplas zonas de disponibilidade.
- 📦 **Containerização Consistente**: Com **Docker** e **Docker Compose**, o ambiente de desenvolvimento local espelha o ambiente de produção, eliminando o clássico "funciona na minha máquina".

## 🏗️ Arquitetura da Solução

O fluxo, do desenvolvimento ao deploy, foi desenhado para ser automatizado e seguro. O diagrama abaixo ilustra a interação entre os principais componentes:

```mermaid
graph TD
    subgraph "👨‍💻 Ambiente do Desenvolvedor"
        A[Dev] -- git push --> B{Repositório Git};
    end

    subgraph "🔄 Pipeline CI/CD na AWS"
        B -- Webhook --> C[AWS CodePipeline];
        C -- Pega o Código --> D[AWS CodeBuild];
        D -- Executa buildspec.yml --> E[Build da Imagem Docker];
        E -- Envia Imagem --> F[Amazon ECR];
    end

    subgraph "🌐 Infraestrutura AWS (Provisionada via Terraform)"
        G[Amazon ECS] -- Puxa Imagem do ECR --> F;
        G -- Executa --> H[Task (Contêiner BIA)];
        H -- Assume IAM Role --> I[AWS Secrets Manager];
        I -- Fornece Credenciais --> H;
        H -- Conecta --> J[Amazon RDS];
        K[Cliente Final] -- HTTPS --> L[Application Load Balancer];
        L -- Direciona Tráfego --> G;
    end

    C -- Dispara Deploy --> G;
```

## 🛠️ Tecnologias Utilizadas

A espinha dorsal deste projeto é construída com tecnologias de ponta, focadas em automação, escalabilidade e segurança.

### Infraestrutura e Automação (IaC & CI/CD)

![Terraform](https://img.shields.io/badge/Terraform-%237B42BC.svg?style=for-the-badge&logo=terraform&logoColor=white) ![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white) ![Shell Script](https://img.shields.io/badge/shell_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)

- **Terraform**: Orquestra e provisiona toda a infraestrutura na AWS de forma declarativa e modular.
- **Docker**: Garante que a aplicação execute de forma consistente em qualquer ambiente, do desenvolvimento à produção.

### Plataforma Cloud AWS

![Amazon AWS](https://img.shields.io/badge/Amazon%20AWS-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=white) ![Amazon ECS](https://img.shields.io/badge/Amazon%20ECS-FF9900.svg?style=for-the-badge&logo=amazon-ecs&logoColor=white) ![Amazon RDS](https://img.shields.io/badge/Amazon%20RDS-527FFF.svg?style=for-the-badge&logo=amazon-rds&logoColor=white) ![Amazon ECR](https://img.shields.io/badge/Amazon%20ECR-232F3E.svg?style=for-the-badge&logo=amazon-ecr&logoColor=white) ![AWS Secrets Manager](https://img.shields.io/badge/AWS%20Secrets%20Manager-232F3E.svg?style=for-the-badge&logo=aws-secrets-manager&logoColor=white)

- **Amazon ECS (Elastic Container Service)**: Orquestra a execução, o posicionamento e o escalonamento dos contêineres da aplicação.
- **Amazon RDS (Relational Database Service)**: Fornece um banco de dados PostgreSQL gerenciado, resiliente e seguro.
- **Amazon ECR (Elastic Container Registry)**: Armazena de forma privada e segura as imagens Docker da aplicação.
- **AWS Secrets Manager**: Protege as credenciais do banco de dados, injetando-as de forma segura na aplicação em tempo de execução.
- **VPC, IAM, ALB, etc**: Um conjunto completo de serviços de rede, segurança e balanceamento de carga para criar uma arquitetura robusta.

### Aplicação

![NodeJS](https://img.shields.io/badge/node.js-6DA55F?style=for-the-badge&logo=node.js&logoColor=white) ![Express.js](https://img.shields.io/badge/express.js-%23404d59.svg?style=for-the-badge&logo=express&logoColor=white) ![React](https://img.shields.io/badge/react-%2320232a.svg?style=for-the-badge&logo=react&logoColor=%2361DAFB) ![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)

- **Node.js (com Express)**: Constrói a API backend da aplicação.
- **React (com Vite)**: Desenvolve a interface de usuário (frontend) de forma moderna e performática.

## 🗂️ Estrutura de Diretórios

A organização do projeto reflete a separação de responsabilidades entre a aplicação e a infraestrutura.

```
.
├── bia/                # Código-fonte da aplicação Node.js/React e scripts de deploy
│   ├── Dockerfile
│   ├── buildspec.yml
│   ├── compose.yml
│   └── deploy-ecs.sh
└── Terraform/          # Código da Infraestrutura (Terraform)
    ├── 0-TerraformState/ # Backend S3 para o estado remoto
    ├── 1-VPC/            # VPC, sub-redes, gateways, etc.
    ├── 1a-SegGroup/      # Security Groups
    ├── 1b-IAM/           # Roles e Policies do IAM
    ├── 3-RDS/            # Banco de Dados RDS e Secrets Manager
    ├── 5-ECR/            # Repositório ECR
    └── 6-ECS/            # Cluster ECS, Task Definition, Service e ALB
```

## ⚙️ Pré-requisitos

Antes de começar, garanta que você tenha as seguintes ferramentas instaladas e configuradas:

- [AWS CLI](https://aws.amazon.com/cli/)
- [Terraform](https://www.terraform.io/downloads.html)
- [Docker](https://www.docker.com/get-started) e Docker Compose

## 🚀 Subindo a Infraestrutura na AWS

Para provisionar toda a infraestrutura na nuvem, siga a ordem dos módulos do Terraform.

> ⚠️ **Atenção:** Execute os comandos dentro de cada diretório respectivo.

1.  **Configurar o Backend Remoto:**
    ```bash
    cd Terraform/0-TerraformState
    terraform init
    terraform apply
    ```

2.  **Provisionar os Módulos da Infraestrutura:**
    Execute `terraform init && terraform apply` para cada um dos módulos na seguinte ordem:
    - `1-VPC`
    - `1a-SegGroup`
    - `1b-IAM`
    - `3-RDS`
    - `5-ECR`
    - `6-ECS`

3.  **Fazer o Deploy da Aplicação:**
    Após a infraestrutura estar no ar, navegue até a pasta da aplicação e use o script de deploy. Ele irá construir a imagem Docker, enviá-la ao ECR e atualizar o serviço no ECS.
    ```bash
    cd bia/
    ./deploy-ecs.sh deploy
    ```

## 🐳 Rodando Localmente com Docker

Para testar e desenvolver a aplicação em seu ambiente local:

1.  **Inicie os contêineres:**
    Na raiz do diretório `bia/`, execute:
    ```bash
    docker-compose up --build
    ```
    A aplicação estará disponível em `http://localhost:3001`.

2.  **Executar Migrações do Banco (Localmente):**
    Com os contêineres em execução, abra outro terminal e execute:
    ```bash
    # Para criar o banco de dados dentro do container Postgres
    docker-compose exec server bash -c 'npx sequelize db:create'

    # Para rodar as migrações
    docker-compose exec server bash -c 'npx sequelize db:migrate'
    ```
