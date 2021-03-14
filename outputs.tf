output "this_iam_user_arn" {
  value = aws_iam_user.this.arn
}

output "this_aws_iam_access_key_id" {
  value = aws_iam_access_key.this.id
}

output "this_aws_iam_access_key_secret" {
  value = aws_iam_access_key.this.secret
}
