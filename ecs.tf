resource "aws_ecs_cluster" "cluster" {
  name = "doctors-app-cluster"
  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

resource "aws_ecs_task_definition" "edoc_task" {
  family                             = "edoc-task"
  network_mode                       = "awsvpc"
  requires_compatibilities           = ["FARGATE"]
  cpu                                = "512"  # 0.5 vCPU
  memory                             = "1024" # 1 GB
  execution_role_arn                 = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "web"
      image     = var.container_image
      essential = true
      portMappings = [
        { containerPort = 80, protocol = "tcp" }
      ]
      environment = [
        { name = "DB_HOST", value = aws_db_instance.mariadb.address },
        { name = "DB_NAME", value = var.db_name }
      ]

      secrets = [
        { name = "DB_USER", valueFrom = "${data.aws_secretsmanager_secret.db.arn}:db_username::" },
        { name = "DB_PASS", valueFrom = "${data.aws_secretsmanager_secret.db.arn}:db_password::" }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.ecs.name
          "awslogs-region"        = var.region
          "awslogs-stream-prefix" = "edoc"
        }
      }
    }
  ])
}



resource "aws_ecs_service" "edoc_service" {
  name            = "edoc-svc"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.edoc_task.arn
  desired_count   = 2
  launch_type     = "FARGATE"
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200

  network_configuration {
    subnets          = [aws_subnet.private_app_subnet_az1.id, aws_subnet.private_app_subnet_az2.id]
    security_groups  = [aws_security_group.app_server_security_group.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.tg.arn
    container_name   = "web"
    container_port   = 80
  }

  depends_on = [aws_lb_listener.http]
}

resource "aws_cloudwatch_log_group" "ecs" {
  name              = "/ecs/edoc"
  retention_in_days = 1
}
