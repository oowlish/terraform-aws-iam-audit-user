resource "aws_iam_user" "this" {
  name = var.name
  tags = var.tags
}

resource "aws_iam_access_key" "this" {
  user = aws_iam_user.this.name
}

resource "aws_iam_user_policy_attachment" "this__security_audit" {
  user       = aws_iam_user.this.name
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}

resource "aws_iam_user_policy_attachment" "this__view_only_access" {
  user       = aws_iam_user.this.name
  policy_arn = "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"
}

resource "aws_iam_user_policy_attachment" "this__prowler_extras" {
  count = var.attach_extras_policy ? 1 : 0

  user       = aws_iam_user.this.name
  policy_arn = aws_iam_policy.prowler_extras[0].arn
}

resource "aws_iam_user_policy_attachment" "this__prowler_security_hub" {
  count = var.attach_security_hub_policy ? 1 : 0

  user       = aws_iam_user.this.name
  policy_arn = aws_iam_policy.prowler_security_hub[0].arn
}

resource "aws_iam_policy" "prowler_extras" {
  count = var.attach_extras_policy ? 1 : 0

  name   = "prowler-extras-readonly-iam-policy"
  policy = data.aws_iam_policy_document.prowler_extras.json
}

data "aws_iam_policy_document" "prowler_extras" {
  statement {
    actions = [
      "dax:ListTables",
      "ds:ListAuthorizedApplications",
      "ds:DescribeRoles",
      "ec2:GetEbsEncryptionByDefault",
      "ecr:Describe*",
      "support:Describe*",
      "tag:GetTagKeys",
      "lambda:GetFunction",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "prowler_security_hub" {
  count = var.attach_security_hub_policy ? 1 : 0

  name   = "prowler-security-hub-readwrite-iam-policy"
  policy = data.aws_iam_policy_document.prowler_security_hub.json
}

data "aws_iam_policy_document" "prowler_security_hub" {
  statement {
    actions = [
      "securityhub:BatchImportFindings",
      "securityhub:GetFindings",
    ]

    resources = ["*"]
  }
}
