

provider "aws" {
  region = "us-west-2"
}


# Setting Up Remote State
terraform {
  # Terraform version at the time of writing this post
  required_version = ">= 0.14.0"

  backend "s3" {
    bucket = "0e338230-9941-42b9-bc8c-69811b29769f"
    key    = "terraform.tfstate"
    region = "us-west-2"
  }
}
