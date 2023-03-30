terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
output name {
  value       = var.key
  sensitive   = no
  description = "description"

}

