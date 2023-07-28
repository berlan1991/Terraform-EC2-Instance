terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}


#resource "local_file" "sessionforxshell" {
#  content = module.local_file.file_base64
#  filename = "%UserProfile%/Documents/NetSarang Computer/7/Xshell/Sessions/devops/a.xsh"

#}

provider "aws" {
  #shared_config_file      = "%UserProfile%/.aws/config"
  region = "eu-central-1"
  shared_credentials_file = "%UserProfile%/.aws/credentials"
}

module "compute" {
  source               = "./module/compute"
  ami                  = "ami-04e601abe3e1a910f"
  instance_type        = "t2.micro"
  tag_name             = "ExampleAppServerInstance"
  sg                   = module.security.webserver_sg
  user_data            = file("./userdata.tpl")
  iam_instance_profile = module.iam.s3_profile
}

module "security" {
  source = "./module/security"
}

module "iam" {
  source                 = "./module/iam"
  role_name              = "s3-list-bucket"
  policy_name            = "s3-list-bucket"
  instance_profile_name  = "s3-list-bucket"
  path                   = "/"
  iam_policy_description = "s3 policy for ec2 to list role"
  iam_policy             = file("./s3-list-bucket-policy.tpl")
  assume_role_policy     = file("./s3-list-bucket-trusted-identity.tpl")
}
module "s3" {
  source        = "./module/s3"
  bucket_name   = "yerlanbaidaliyev28072023"
  acl           = "private"
  object_key    = "LUIT"
  object_source = "%UserProfile%/file-for-upload.txt"
}

#module "local_file" {
#  source        = "./module/local_file"
#}