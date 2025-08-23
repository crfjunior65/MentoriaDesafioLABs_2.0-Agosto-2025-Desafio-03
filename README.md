# 🚀 Projeto BIA - Aplicação Web em AWS ECS com Terraform

Este projeto implementa a infraestrutura completa na AWS para hospedar a aplicação conteinerizada "Bia", utilizando Terraform para automação e gerenciamento (Infraestrutura como Código - IaC).

## 📋 Visão Geral do Projeto

O objetivo é implantar uma aplicação web full-stack (Node.js + React) de forma automatizada, escalável e segura na AWS. A solução é dividida em duas partes principais:

1.  **Infraestrutura (`Terraform/`)**: Código Terraform que provisiona todos os recursos necessários na nuvem, desde a rede até o cluster de contêineres.
2.  **Aplicação (`bia/`)**: O código-fonte da aplicação, já preparado para ser conteinerizado com Docker.

---

## 🏗️ Arquitetura da Solução

A arquitetura foi projetada para ser modular e escalável, seguindo as melhores práticas da AWS.

### Infraestrutura como Código (Terraform)

O diretório `Terraform/` contém múltiplos módulos, organizados em camadas com dependências explícitas, gerenciadas via `terraform_remote_state`.

-   **`0-TerraformState`**: Configura o backend S3 para armazenar o estado do Terraform de forma remota e segura.
-   **`1-VPC`**: Cria a fundação de rede (VPC, Subnets, Route Tables, Gateways).
-   **`1a-SegGroup`**: Gerencia os Security Groups, que funcionam como firewalls virtuais.
-   **`1b-IAM`**: Define as políticas e papéis (Roles) de IAM para garantir o acesso seguro entre os serviços.
-   **`3-RDS`**: Provisiona uma instância de banco de dados relacional gerenciado pela AWS.
-   **`3a-Orquestrador`**: Cria uma instância EC2 para servir como Bastion Host ou para tarefas de gerenciamento.
-   **`5-ECR`**: Cria o Elastic Container Registry para armazenar as imagens Docker da aplicação "Bia".
-   **`6-ECS`**: Orquestra a execução dos contêineres. A configuração utiliza o **tipo de inicialização EC2**, provisionando um cluster com:
    -   **Launch Template**: Para padronizar a configuração das instâncias EC2.
    -   **Auto Scaling Group**: Para gerenciar o número de instâncias e garantir a escalabilidade e resiliência.
    -   **Capacity Provider**: Para conectar de forma flexível o cluster ao Auto Scaling Group.

### Aplicação (Bia)

O diretório `bia/` contém uma aplicação web moderna e pronta para a nuvem.

-   **Stack de Tecnologia**:
    -   **Backend**: Node.js
    -   **Frontend**: React (gerenciado com Vite)
-   **Containerização**: O `Dockerfile` e o `compose.yml` permitem que a aplicação seja facilmente empacotada e executada em qualquer ambiente com Docker, facilitando o deploy no ECS.
-   **CI/CD**: O arquivo `buildspec.yml` prepara o projeto para integração com serviços de pipeline da AWS como CodeBuild e CodePipeline.

---

## 🛠️ Tecnologias Utilizadas

-   **AWS (Amazon Web Services)**
-   **Terraform**
-   **Docker**
-   **Node.js**
-   **React**

---

## 🚀 Como Utilizar

### Deploy da Infraestrutura

A infraestrutura deve ser implantada seguindo a ordem numérica dos diretórios no `Terraform/`, pois eles representam as dependências. Para cada diretório (de `0` a `6`):

1.  Navegue até o diretório do módulo: `cd Terraform/<diretorio_do_modulo>`
2.  Inicialize o Terraform (necessário apenas na primeira vez):
    ```bash
    terraform init
    ```
3.  Revise o plano de execução:
    ```bash
    terraform plan -out=plan.out
    ```
4.  Aplique a configuração para criar os recursos:
    ```bash
    terraform apply "plan.out"
    ```

### Executando a Aplicação Localmente

Para testar a aplicação "Bia" em sua máquina local:

1.  Navegue até o diretório da aplicação: `cd bia/`
2.  Utilize os scripts fornecidos para iniciar o ambiente com Docker Compose:
    -   No Linux/macOS: `./rodar_app_local_unix.sh`
    -   No Windows: `rodar_app_local_windows.bat`

---

## 👨‍💻 Autor

**Junior Fernandes**
