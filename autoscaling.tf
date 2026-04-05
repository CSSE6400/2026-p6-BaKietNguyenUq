# create autoscaling target 
resource "aws_appautoscaling_target" "taskoverflow" {
    # max capacity container can be 4
    max_capacity = 4
    # min capacity container can be 1
    min_capacity = 1
    # resource id is the service name
    resource_id = "service/taskoverflow/taskoverflow"
    # scalable dimension is the desired count
    scalable_dimension = "ecs:service:DesiredCount"
    # service namespace is ecs
    service_namespace = "ecs"
    depends_on = [ aws_ecs_service.taskoverflow]
}

# create autoscaling policy
resource "aws_appautoscaling_policy" "taskoverflow-cpu" {
    name = "taskoverflow-cpu"
    policy_type = "TargetTrackingScaling"
    resource_id = aws_appautoscaling_target.taskoverflow.resource_id
    scalable_dimension = aws_appautoscaling_target.taskoverflow.scalable_dimension
    service_namespace =aws_appautoscaling_target.taskoverflow.service_namespace
    
    target_tracking_scaling_policy_configuration {
        predefined_metric_specification {
            predefined_metric_type = "ECSServiceAverageCPUUtilization"
        }
        target_value = 20
    }
}

