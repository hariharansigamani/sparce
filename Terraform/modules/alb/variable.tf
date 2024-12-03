variable "vpc_id" {
  description = "VPC ID where the load balancer will be deployed"
  type        = string
}

variable "subnets" {
  description = "List of public subnets for the ALB"
  type        = list(string)
}

variable "lb_security_group" {
  description = "Security group for the ALB"
  type        = string
}

variable "certificate_arn" {
  description = "ARN of the SSL/TLS certificate for the ALB listener"
  type        = string
}

