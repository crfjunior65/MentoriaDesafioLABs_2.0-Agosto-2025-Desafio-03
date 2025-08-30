# Cluster EKS (Kubernetes)

Este diretório contém o código Terraform para provisionar um cluster Amazon EKS (Elastic Kubernetes Service) robusto e pronto para produção na AWS.

## 1. Arquitetura e Funcionalidades

A infraestrutura criada por este Terraform inclui:

- **Cluster EKS**: Gerenciado pelo módulo oficial `terraform-aws-modules/eks/aws`.
- **VPC Dedicada**: Uma nova VPC é criada exclusivamente para o cluster, com CIDR `10.0.0.0/16`, garantindo isolamento total.
- **Sub-redes Seguras**: O módulo provisiona sub-redes públicas e privadas. Os worker nodes rodam nas **sub-redes privadas** por segurança.
- **Monitoramento (Container Insights)**: O Add-on de Observabilidade do CloudWatch é ativado (`enable_amazon_cloudwatch_observability = true`), enviando métricas e logs detalhados para o CloudWatch e populando dashboards automaticamente.
- **Controlador de Ingress (ALB)**: O Add-on do AWS Load Balancer Controller é ativado (`enable_aws_load_balancer_controller = true`), permitindo que o Kubernetes crie e gerencie Application Load Balancers (ALBs) para expor serviços externamente.

---

## 2. Como Implantar o Cluster

Siga os passos abaixo para criar a infraestrutura.

**Atenção:** A criação de um cluster EKS pode demorar de 15 a 25 minutos.

1.  **Navegue até o diretório:**
    ```bash
    cd Terraform/7-EKS/
    ```

2.  **Inicialize o Terraform:**
    (Este comando só precisa ser executado uma vez)
    ```bash
    terraform init
    ```

3.  **Planeje a implantação:**
    (Opcional, mas recomendado para revisar os recursos que serão criados)
    ```bash
    terraform plan
    ```

4.  **Aplique a configuração:**
    ```bash
    terraform apply --auto-approve
    ```

---

## 3. Acessando o Cluster

Após a conclusão do `terraform apply`, você precisa configurar sua máquina local para se comunicar com o cluster usando o `kubectl`.

1.  **Obtenha o Comando de Configuração:**
    Execute o seguinte comando do Terraform para obter o comando de configuração do `kubectl`:
    ```bash
    terraform output configure_kubectl
    ```

2.  **Execute o Comando Gerado:**
    Copie e cole o comando retornado (será parecido com o exemplo abaixo) e execute-o no seu terminal:
    ```bash
    aws eks --region us-east-1 update-kubeconfig --name bia-eks-cluster
    ```
    Isso irá atualizar seu arquivo `~/.kube/config` com as credenciais do novo cluster.

3.  **Verifique a Conexão:**
    Para confirmar que você está conectado, liste os nós (worker nodes) do cluster:
    ```bash
    kubectl get nodes
    ```
    Você deverá ver 2 nós com o status `Ready`.

---

## 4. Exemplo: Implantando uma Aplicação (Nginx)

Este guia mostra como implantar um servidor web Nginx e expô-lo para a internet usando o Load Balancer Controller.

1.  **Crie o arquivo de Deployment:**
    Crie um arquivo chamado `nginx-deployment.yaml` com o seguinte conteúdo. Ele define que queremos 2 réplicas do Nginx rodando.
    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: nginx-deployment
    spec:
      replicas: 2
      selector:
        matchLabels:
          app: nginx
      template:
        metadata:
          labels:
            app: nginx
        spec:
          containers:
          - name: nginx
            image: nginx:latest
            ports:
            - containerPort: 80
    ```

2.  **Crie o arquivo de Serviço (Service):**
    Crie um arquivo `nginx-service.yaml`. Este serviço expõe o Nginx internamente no cluster para que o Ingress possa encontrá-lo.
    ```yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: nginx-service
    spec:
      selector:
        app: nginx
      ports:
        - protocol: TCP
          port: 80
          targetPort: 80
      type: ClusterIP
    ```

3.  **Crie o arquivo de Rota (Ingress):**
    Crie um arquivo `nginx-ingress.yaml`. Este é o recurso que instrui o **AWS Load Balancer Controller** a criar um ALB para expor nosso serviço Nginx na internet.
    ```yaml
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: nginx-ingress
      annotations:
        alb.ingress.kubernetes.io/scheme: internet-facing
        alb.ingress.kubernetes.io/target-type: ip
    spec:
      ingressClassName: alb
      rules:
      - http:
          paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: nginx-service
                port:
                  number: 80
    ```

4.  **Aplique os arquivos no Cluster:**
    Execute os seguintes comandos no seu terminal:
    ```bash
    kubectl apply -f nginx-deployment.yaml
    kubectl apply -f nginx-service.yaml
    kubectl apply -f nginx-ingress.yaml
    ```

5.  **Acesse sua Aplicação:**
    O provisionamento do ALB pode levar alguns minutos. Para obter o endereço DNS do Load Balancer, execute:
    ```bash
    kubectl get ingress nginx-ingress
    ```
    Copie o valor da coluna `ADDRESS` e cole-o em seu navegador. Você deverá ver a página de boas-vindas do Nginx.

<!-- BEGIN_TF_DOCS -->
## Providers

No providers.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Regiao AWS para a criacao dos recursos | `string` | `"us-east-1"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Nome do cluster EKS | `string` | `"bia-eks-cluster"` | no |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | Versao do Kubernetes para o cluster EKS | `string` | `"1.28"` | no |
| <a name="input_instance_types"></a> [instance\_types](#input\_instance\_types) | Tipos de instancia para os nos de trabalho (worker nodes) | `list(string)` | <pre>[<br>  "t3.medium"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Endpoint do control plane do cluster EKS. |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Nome do cluster EKS. |
| <a name="output_configure_kubectl"></a> [configure\_kubectl](#output\_configure\_kubectl) | Comando para configurar o kubectl para se conectar ao cluster EKS. |
<!-- END_TF_DOCS -->
