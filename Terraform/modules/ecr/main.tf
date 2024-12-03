resource "aws_ecr_repository" "app" {
  name = "my-app-repo"

  tags = {
    Name = "ECR-Repository"
  }
}

output "repository_url" {
  value = aws_ecr_repository.app.repository_url
}
