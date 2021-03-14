variable "name" {
  type        = string
  default     = "prowler"
  description = "Name of the user."
}

variable "tags" {
  type        = map(string)
  description = "Key-value map of tags for the IAM User."
}

variable "attach_extras_policy" {
  type        = bool
  default     = false
  description = "Whether to attach a policy to scan all services included in the group \"Extras\"."
}

variable "attach_security_hub_policy" {
  type        = bool
  default     = false
  description = "Whether to attach a policy to send findings to \"AWS Security Hub\"."
}
