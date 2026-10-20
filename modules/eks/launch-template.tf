resource "aws_launch_template" "eks_nodes" {
  name_prefix = "${var.project}-${var.env}-eks-node-"
  #image_id = "ami-0bb6cb30a075246d9"

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = 30
      volume_type           = "gp3"
      encrypted             = true
      delete_on_termination = true
    }
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name    = "${var.project}-${var.env}-eks-node"
      Project = var.project
      Env     = var.env
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}