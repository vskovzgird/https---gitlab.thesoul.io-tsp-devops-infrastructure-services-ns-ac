variable "team_name" {
  description = "Unique team id"
  type        = string
}

# https://www.terraform.io/language/values/variables
variable "namespaces" {
  description = "Team namespaces"
  type = map
  default = {
    namespace-1 = {
      cluster = "nbg4"
      labels = {}
    },
    namespace-1 = {
      cluster = "nbg2"
      labels = {}
    },
  }
}

