<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.10.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.ecs_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_instance_profile.s3_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_instance_profile.ssm_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.ec2_s3_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ecs_instance_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ecs_task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ssm_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ec2_container_registry_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ec2_full_acess_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecr_full](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs_full](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs_full_access_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs_instance_cloudwatch_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs_instance_ecr_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs_task_execution_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.rds_full_acess_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.s3_full](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.s3_full_ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.s3_managed_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.secretmanager_managed_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ssm_managed_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ssm_managed_policy_ecs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_AWS_REGION"></a> [AWS\_REGION](#input\_AWS\_REGION) | The AWS region to deploy resources | `string` | `"us-east-1"` | no |
| <a name="input_Environment"></a> [Environment](#input\_Environment) | The environment for the Terraform deployment | `string` | `"Desafio-03/Formacao_AWS"` | no |
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | n/a | `string` | `"DesafioAWS"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_ident"></a> [aws\_ident](#output\_aws\_ident) | AWS  Identifier |
| <a name="output_ecs_task_execution_role_arn"></a> [ecs\_task\_execution\_role\_arn](#output\_ecs\_task\_execution\_role\_arn) | ARN of the IAM role for ECS Task Execution |
| <a name="output_iam_ec2_s3_role"></a> [iam\_ec2\_s3\_role](#output\_iam\_ec2\_s3\_role) | aws\_iam\_role" "ec2\_s3\_role |
| <a name="output_iam_ecs_atach_role"></a> [iam\_ecs\_atach\_role](#output\_iam\_ecs\_atach\_role) | n/a |
| <a name="output_iam_instance_profile_ssm_profile_name"></a> [iam\_instance\_profile\_ssm\_profile\_name](#output\_iam\_instance\_profile\_ssm\_profile\_name) | Profile Name |
| <a name="output_iam_s3_atach_role"></a> [iam\_s3\_atach\_role](#output\_iam\_s3\_atach\_role) | aws\_iam\_role\_policy\_attachment" "s3\_managed\_policy |
| <a name="output_iam_s3_profile"></a> [iam\_s3\_profile](#output\_iam\_s3\_profile) | aws\_iam\_instance\_profile" "s3\_profile |
| <a name="output_iam_ssm_profile"></a> [iam\_ssm\_profile](#output\_iam\_ssm\_profile) | Role SSM Profile |
| <a name="output_ssm_atach_role"></a> [ssm\_atach\_role](#output\_ssm\_atach\_role) | n/a |
| <a name="output_ssm_role"></a> [ssm\_role](#output\_ssm\_role) | n/a |
<!-- END_TF_DOCS -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.10.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.ecs_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_instance_profile.s3_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_instance_profile.ssm_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.ec2_s3_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ecs_instance_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ssm_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ec2_container_registry_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ec2_full_acess_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecr_full](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs_full](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs_full_access_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs_instance_cloudwatch_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs_instance_ecr_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.rds_full_acess_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.s3_full](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.s3_full_ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.s3_managed_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.secretmanager_managed_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ssm_managed_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ssm_managed_policy_ecs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_availability_zones.available_zones](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.instance_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_AWS_REGION"></a> [AWS\_REGION](#input\_AWS\_REGION) | The AWS region to deploy resources | `string` | `"us-east-1"` | no |
| <a name="input_Environment"></a> [Environment](#input\_Environment) | The environment for the Terraform deployment | `string` | `"Desafio-03/Formacao_AWS"` | no |
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | n/a | `string` | `"DesafioAWS"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_ident"></a> [aws\_ident](#output\_aws\_ident) | AWS  Identifier |
| <a name="output_iam_ec2_s3_role"></a> [iam\_ec2\_s3\_role](#output\_iam\_ec2\_s3\_role) | aws\_iam\_role" "ec2\_s3\_role |
| <a name="output_iam_ecs_atach_role"></a> [iam\_ecs\_atach\_role](#output\_iam\_ecs\_atach\_role) | n/a |
| <a name="output_iam_instance_profile_ssm_profile_name"></a> [iam\_instance\_profile\_ssm\_profile\_name](#output\_iam\_instance\_profile\_ssm\_profile\_name) | Profile Name |
| <a name="output_iam_s3_atach_role"></a> [iam\_s3\_atach\_role](#output\_iam\_s3\_atach\_role) | aws\_iam\_role\_policy\_attachment" "s3\_managed\_policy |
| <a name="output_iam_s3_profile"></a> [iam\_s3\_profile](#output\_iam\_s3\_profile) | aws\_iam\_instance\_profile" "s3\_profile |
| <a name="output_iam_ssm_profile"></a> [iam\_ssm\_profile](#output\_iam\_ssm\_profile) | Role SSM Profile |
| <a name="output_ssm_atach_role"></a> [ssm\_atach\_role](#output\_ssm\_atach\_role) | n/a |
| <a name="output_ssm_role"></a> [ssm\_role](#output\_ssm\_role) | n/a |
<!-- END_TF_DOCS -->
