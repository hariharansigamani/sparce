resource "aws_ecs_cluster" "main" {
  name = "ecs-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "my-app-task"
  execution_role_arn       = var.execution_role_arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([{
    name      = "app"
    image     = "944200606058.dkr.ecr.ap-south-2.amazonaws.com/rearc:latest"
    cpu       = 256
    memory    = 512
    essential = true
    portMappings = [{
      containerPort = 3000
      protocol      = "tcp"
      hostPort      = 3000
    }]
    environment = [{
      name  = "SECRET_WORD"
      value = var.secret_word
    }]
  }])
}

resource "aws_ecs_service" "app" {
  cluster        = aws_ecs_cluster.main.id
  name            = "rearc" 
  task_definition = aws_ecs_task_definition.app.arn
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnets
    security_groups  = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "app"
    container_port   = 3000
  }

  depends_on = [var.lb_listener]
}


resource "aws_security_group" "ecs_sg" {
  name_prefix = "ecs_sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3000  # Allow inbound traffic on port 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow traffic from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow outbound traffic to anywhere
  }
}
