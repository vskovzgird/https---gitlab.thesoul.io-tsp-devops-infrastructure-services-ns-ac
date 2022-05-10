variable "team_name" {
  description = "Unique team id"
  type        = string
}

variable "cluster_name" {
  description = "Unique cluster name"
  type = string
}

# https://www.terraform.io/language/values/variables
# BUG! type = map на вершине которого идёт namespace name
# не подходит, так как ключи должны быть уникальны
# а нам может потребоваться создавать на двух разных кластерах namespace с одинаковым именем, но разными лейблами
# т.о, на вершину нужно ставить имя кластера?

variable "team_namespaces" {
  description = "Team clusters and their namespaces"
  type = map
  default = {
    nbg4 = {
      test = {
        labels = {},
        annotations = {}
      },
      test-2 = {
        labels = {},
        annotations = {}
      }
    },
    nbg2 = {
      test = {
        labels = {},
        annotations = {}
      },
      test-3 = {
        labels = {},
        annotations = {}
      }
    },
  }
}

