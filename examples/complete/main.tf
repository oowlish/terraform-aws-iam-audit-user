provider "aws" {
  region = "us-east-1"
}

module "aws_iam_audit_user" {
  source = "../"

  name = "prowler"

  attach_extras_policy       = true
  attach_security_hub_policy = true

  tags = {
    ProjectName = "Security Audit"
  }
}
