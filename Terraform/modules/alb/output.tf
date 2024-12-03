output "target_group_arn" {
  description = "ARN of the target group created by the ALB module"
  value       = aws_lb_target_group.app.arn
}

output "lb_listener" {
  description = "ARN of the ALB listener"
  value       = aws_lb_listener.https.arn
}
