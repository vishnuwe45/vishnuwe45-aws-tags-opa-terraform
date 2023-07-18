# resource "aws_s3_bucket" "opa_bucket" {
#   bucket        = "opa-encryption-testing-now-in-cicd"
#   acl           = "private"
#   force_destroy = true
#     tags = {
#     department = "Learning"
#     owner      = "ASE"
#   }
# }



# resource "aws_subnet" "public-subnet" {
#   cidr_block        = var.public_subnet_cidr
#   vpc_id            = aws_vpc.stack-example-vpc.id
#   availability_zone = "us-west-2a"

#   tags = {
#     department = "Learning"
#     owner      = "ASE"
#   }
# }



# resource "aws_internet_gateway" "gateway" {
#   vpc_id = aws_vpc.stack-example-vpc.id

#   tags = {
#     department = "Learning"
#     owner      = "ASE"
#   }

# }


# resource "aws_vpc" "stack-example-vpc" {
#   cidr_block           = var.vpc_cidr
#   enable_dns_support   = true
#   enable_dns_hostnames = true
#   tags = {
#     department = "Learning"
#     owner      = "ASE"
#   }
# }
