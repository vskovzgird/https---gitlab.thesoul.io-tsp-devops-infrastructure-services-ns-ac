// https://learn.hashicorp.com/tutorials/terraform/module-create?in=terraform/modules

# првоайдер можно объявлять наверху дефолтный
# его будут использовать все ресурсы без указания provider
# https://www.terraform.io/language/providers/configuration

# !! The version argument in provider configurations is deprecated. 
# In Terraform 0.13 and later, always declare provider version constraints in the required_providers block.

# configure GitLab CI/CD as a backend for TF state
terraform {
  backend "local" {
  }
}

locals {
  team_name = "devops"
  test = {
    test = {
        labels = {},
        annotations = {}
        },
    test-2 = {
        labels = {},
        annotations = {
            ann-1 = "ann-1",
            ann-2 = "ann-2"
        }
    },
    test-3 = {
        labels = {},
        annotations = {}
        },
    test-4 = {
        labels = {},
        annotations = {}
        },
  }
  prod = {
    ns-1 = {
        labels = {},
        annotations = {}
    },
    ns-2 = {
        labels = {},
        annotations = {
            ann-1 = "ann-1"
        }
    },
    test-3 = {
        labels = {},
        annotations = {}
    }
  }
}

# we have to change provider via env variables otherwise we can not pass it dynamically to team module
# provider "kubernetes" {
#   token = "eyJhbGciOiJSUzI1NiIsImtpZCI6IlM5YXNtcXZvLTU5SDNoQk53Um1tNVNRNDdTdExpWEF4OU1PdWhFOFB1XzQifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImRlZmF1bHQtdG9rZW4td2I1YzQiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiZGVmYXVsdCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjkxNGRmZDdhLWFkODQtNDEyMS1hNGUzLWY5MzI5MDViZDkxYyIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpkZWZhdWx0OmRlZmF1bHQifQ.Dgresrhw3-vLeZx0BK_wz3RF9xjiTkMdf22xDprjoU4QsSippOtDaNGnhhq1bNV8AhBG62Pt87-1Ey0Yu8amAHM1tcfaETXrS89ZkifvEt3v7QamRLIxVdg6jGm3OYVq2bHRqxkGkzhS9jkPgagMJWk9d54uMXVZzl3GcUtj2M-L4iyRpxNiyyO6NtgkMuh8Q0fGDOINKUqO2R5e7Nk0MhuX3BNl13Iz3Tc-aTwe_7y-2H2qT0ZNZUgQNiLxDFfHQzhjj4ZMvve-kLHtlkyODF2Z3T_GsrCM-0dW_tpQmmHZpwv_JB3FHND9LqEUA0oURfRDhxX_q6y-oH0Y3eJUTA"
#   host = "https://23.88.53.165:8443"
#   insecure = true
# }

# will pass different KUBE_HOST KUBE_TOKEN env variables on job level to differentiate between clusters
provider "kubernetes" {
  insecure = true
}