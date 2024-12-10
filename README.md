# sparce

git clone <repository-url>
cd <repository-folder>


Step 2: Configure Variables
Create a terraform.tfvars file or set variables in the variables.tf file to customize your deployment:

app_name              = "my-app"
region                = "ap-south-2"
vpc_cidr              = "10.0.0.0/16"
public_subnet_cidrs   = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs  = ["10.0.3.0/24", "10.0.4.0/24"]
docker_image_tag      = "latest"
secret_word           = "mySecretWord"
certificate_arn       = "arn:aws:acm:ap-south-2:<account-id>:certificate/<certificate-id>"

Troubleshooting
IAM Permissions: Ensure your AWS user/role has the necessary permissions to create ECS, ALB, VPC, and ECR resources.
Resource Limits: Check AWS limits if any resource creation fails.
VPC Endpoint Issues: Ensure the subnets have access to the VPC endpoints configured for ECR.


Each stage can be tested as follows (where <ip_or_host> is the location where the app is deployed):

Public cloud & index page (contains the secret word) - http(s)://<ip_or_host>[:port]/
Docker check - http(s)://<ip_or_host>[:port]/docker
Secret Word check - http(s)://<ip_or_host>[:port]/secret_word
Load Balancer check - http(s)://<ip_or_host>[:port]/loadbalanced
TLS check - http(s)://<ip_or_host>[:port]/tls

Above all checks will be done in a single deployment, using Loadbalancer URL the request will be redirect to ECS .

ECS task definition isn't being created, 

Troubleshooting :
- IAM policy 
- Task Definition Configuration
- ECS Cluster and VPC Configuration