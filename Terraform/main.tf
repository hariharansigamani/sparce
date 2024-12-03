module "vpc" {
  source         = "terraform-aws-modules/vpc/aws"
  name           = "my-vpc"
  cidr           = "10.0.0.0/16"
  azs            = ["ap-south-2a", "ap-south-2b"]
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
}

module "ecr" {
  source = "./modules/ecr"
}

module "ecs" {
  source             = "./modules/ecs"
  image_url          = module.ecr.repository_url
  secret_word        = "mysecret"
  subnets            = module.vpc.public_subnets
  target_group_arn   = module.alb.ecs_target_group_arn
  lb_listener        = module.alb.lb_listener
  execution_role_arn = aws_iam_role.ecs_execution_role.arn
  vpc_id             = module.vpc.vpc_id
}

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.vpc.vpc_id
  subnets           = module.vpc.public_subnets
  lb_security_group = aws_security_group.alb_sg.id
  certificate_arn   = var.certificate_arn
}

resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Security group for the ALB"
  vpc_id      = module.vpc.vpc_id
  ingress {
    from_port   = 3000 # Allow inbound traffic on port 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow traffic from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow outbound traffic to anywhere
  }
}