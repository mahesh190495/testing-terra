terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider



module proposal {
  source = "git::https://github.com/mahesh95prabhu/helloterra.git"
  
}
