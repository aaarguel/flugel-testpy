variable "access_key" {
  description = "Access key provided for AWS "
  type        = string
  default     = "DON'T-FORGET-IT"
}

variable "secret_key" {
  description = "Secret key provided for AWS "
  type        = string
  default     = "DON'T-FORGET-IT"
}

variable "tags" {
  description = "Tags provided for Flugel Team"
  type = map(string)
  default = {
    Name  = "Flugel"
    Owner = "InfraTeam"
  }
}