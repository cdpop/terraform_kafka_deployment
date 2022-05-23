variable "security_group_id" {
  type = string
  description = "Security group ID."
  default = null
}

variable "key_pair_name" {
  type = string
  description = "Key name"
}

variable "security_group_name"{
    type = string
    description = "Security group name."
}

variable "owner_email"{
    type = string
    description = "Confluent Email for user. Required for tagging instances otherwise they will auto delete in 12 hours."
    default = "Auto Delete Enabled"
}