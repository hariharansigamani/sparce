terraform {

  backend "s3" {
    bucket                 = "rearc-070124-demo"
    key                    = "devops/ecs-webserver.tfstate"
    skip_region_validation = "true" 
    region                 = "ap-south-2"
    encrypt                = "true"
    kms_key_id             = "arn:aws:kms:ap-south-2:944200606058:key/aff8ac93-b112-4189-9327-1c6e6cc9c6e9"
    dynamodb_table         = "Shared_services"
  }
}