data "aws_ssm_parameter" "ecs_node_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}

resource "aws_launch_template" "ecs_ec2" {
  name_prefix            = "cluster-bia-tf-lt-"
  image_id               = data.aws_ssm_parameter.ecs_node_ami.value
  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.terraform_remote_state.sg.outputs.sg_bia_ec2] # Replace with your security group ID
  #[ aws_security_group.bia_ec2.id ]

  iam_instance_profile { arn = data.terraform_remote_state.iam.outputs.iam_ssm_profile.arn }

  #aws_iam_instance_profile.ecs_node.name

  #iam_instance_profile { arn = aws_iam_instance_profile.ecs_node.arn } # Ensure this IAM instance profile exists
  #{ arn = aws_iam_instance_profile.ecs_node.arn }
  monitoring { enabled = false }

  user_data = base64encode(<<-EOF
      #!/bin/bash
      echo ECS_CLUSTER=${aws_ecs_cluster.foo.name} >> /etc/ecs/ecs.config;
    EOF
  )
}
