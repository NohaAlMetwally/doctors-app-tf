# create an auto scaling group for the ecs service
resource "aws_appautoscaling_target" "ecs_asg" {
  max_capacity       = 4
  min_capacity       = 2
  resource_id        = "service/${aws_ecs_cluster.cluster.name}/${aws_ecs_service.edoc_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  depends_on = [aws_ecs_service.edoc_service]
}

# create scaling policy for the auto scaling group
resource "aws_appautoscaling_policy" "ecs_policy" {
  name               = "doctors-app-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_asg.id
  scalable_dimension = aws_appautoscaling_target.ecs_asg.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_asg.service_namespace

  target_tracking_scaling_policy_configuration {

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value       = 70
    scale_out_cooldown = 300
    scale_in_cooldown  = 300
    disable_scale_in   = false
  }

  depends_on = [aws_appautoscaling_target.ecs_asg]
}