#---------------------------------------------------------------------------
# Criação do papel IAM para EC2 com permissoes para SSM e S3
#---------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Criar o Role IAM para a EC2 com permissões para o SSM ######
#------------------------------------------------------------------------------

resource "aws_iam_role" "ssm_role" {
  name = "ec2-ssm-role"

  # Politica de confianca que permite o EC2 assumir este papel
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

# Anexar a política gerenciada AmazonSSMManagedInstanceCore ao Role
resource "aws_iam_role_policy_attachment" "ssm_managed_policy" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Anexar a política gerenciada AmazonS3FullAccess ao Role
resource "aws_iam_role_policy_attachment" "s3_full_ssm" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# Anexar a política gerenciada AmazonRDSFullAccess ao Role
resource "aws_iam_role_policy_attachment" "rds_full_acess_policy" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}

# Anexar a política gerenciada AmazonECS_FullAccess ao Role
resource "aws_iam_role_policy_attachment" "ecs_full_access_policy" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
}

# Anexar a política gerenciada AmazonEC2FullAccess ao Role
resource "aws_iam_role_policy_attachment" "ec2_full_acess_policy" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

# Anexar a política gerenciada AmazonEC2ContainerRegistryFullAccess ao Role
resource "aws_iam_role_policy_attachment" "ec2_container_registry_policy" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

# Anexar a política gerenciada SecretsManagerReadWrite ao Role
resource "aws_iam_role_policy_attachment" "secretmanager_managed_policy" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}

#------------------------------------------------------------------------------

# Criar um Instance Profile para associar o Role à instância EC2
resource "aws_iam_instance_profile" "ssm_profile" {
  name = "ec2-ssm-profile"
  role = aws_iam_role.ssm_role.name
}

#--------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Criação do papel IAM para EC2 com permissoes para Admin Access
#------------------------------------------------------------------------------

# Criar o Role IAM para a EC2 com permissões para o Admin Access
resource "aws_iam_role" "ec2_admin_role" {
  name = "ec2-admin-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

# Anexar a política AdministratorAccess ao Role
resource "aws_iam_role_policy_attachment" "AdministratorAccess_policy" {
  role       = aws_iam_role.ec2_admin_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  #"arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Criar um Instance Profile para associar o Role à instância EC2
resource "aws_iam_instance_profile" "admin_profile" {
  name = "ec2-admin-profile"
  role = aws_iam_role.ec2_admin_role.name
}

#--------------------------------------------------------------------------------
#------------------------------------------------------------------------------
# Criação do papel IAM para EC2 com permissoes para ECS
#------------------------------------------------------------------------------

resource "aws_iam_role" "ecs_instance_role" {
  name = "ecs-instance-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}



resource "aws_iam_role_policy_attachment" "ecs_instance_cloudwatch_policy" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

resource "aws_iam_role_policy_attachment" "s3_full" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "ecr_full" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

resource "aws_iam_role_policy_attachment" "ecs_full" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
}

resource "aws_iam_role_policy_attachment" "ssm_managed_policy_ecs" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

#------------------------------------------------------------------------------

resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "ecs-instance-profile"
  role = aws_iam_role.ecs_instance_role.name
}

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
# Politica de Assumir Role para EC2
#------------------------------------------------------------------------------
data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

#------------------------------------------------------------------------------
