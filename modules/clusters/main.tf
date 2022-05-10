# all clusters used in TSP
# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/guides/getting-started

# https://thesoul.atlassian.net/wiki/spaces/ITDEP/pages/6692380966/kubernetes+API+sso+kuberos+keycloak+.

// nbg2  - основной прод
// nbg4 - gitlab / инфра кластер
// fsn5 -  прод про видео
// fsn7 - прод cdn, который мы готовы почти разобрать
// ams2 - прод с ограниченным доступом, сейчас у меня и Рената туда есть доступ
// nbg3 - тест \ stg \ dev

# multiple k8s providers (one for each cluster) can be described with `alias` meta-argument
# https://www.terraform.io/language/providers/configuration

# https://thesoul.atlassian.net/wiki/spaces/ITDEP/pages/6692380966/kubernetes+API+sso+kuberos+keycloak+

#https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs

terraform {
  required_version = ">= 1.0"
  required_providers {
    kubernetes = {
      version = "~> 2.4.1"
    }
  }
}

provider "kubernetes" {
  token = "eyJhbGciOiJSUzI1NiIsImtpZCI6IlM5YXNtcXZvLTU5SDNoQk53Um1tNVNRNDdTdExpWEF4OU1PdWhFOFB1XzQifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImRlZmF1bHQtdG9rZW4td2I1YzQiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiZGVmYXVsdCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjkxNGRmZDdhLWFkODQtNDEyMS1hNGUzLWY5MzI5MDViZDkxYyIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpkZWZhdWx0OmRlZmF1bHQifQ.Dgresrhw3-vLeZx0BK_wz3RF9xjiTkMdf22xDprjoU4QsSippOtDaNGnhhq1bNV8AhBG62Pt87-1Ey0Yu8amAHM1tcfaETXrS89ZkifvEt3v7QamRLIxVdg6jGm3OYVq2bHRqxkGkzhS9jkPgagMJWk9d54uMXVZzl3GcUtj2M-L4iyRpxNiyyO6NtgkMuh8Q0fGDOINKUqO2R5e7Nk0MhuX3BNl13Iz3Tc-aTwe_7y-2H2qT0ZNZUgQNiLxDFfHQzhjj4ZMvve-kLHtlkyODF2Z3T_GsrCM-0dW_tpQmmHZpwv_JB3FHND9LqEUA0oURfRDhxX_q6y-oH0Y3eJUTA"
  host = "https://23.88.53.165:8443"
  insecure = true
}

provider "kubernetes" {
  token = "eyJhbGciOiJSUzI1NiIsImtpZCI6IlM5YXNtcXZvLTU5SDNoQk53Um1tNVNRNDdTdExpWEF4OU1PdWhFOFB1XzQifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImRlZmF1bHQtdG9rZW4td2I1YzQiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiZGVmYXVsdCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjkxNGRmZDdhLWFkODQtNDEyMS1hNGUzLWY5MzI5MDViZDkxYyIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpkZWZhdWx0OmRlZmF1bHQifQ.Dgresrhw3-vLeZx0BK_wz3RF9xjiTkMdf22xDprjoU4QsSippOtDaNGnhhq1bNV8AhBG62Pt87-1Ey0Yu8amAHM1tcfaETXrS89ZkifvEt3v7QamRLIxVdg6jGm3OYVq2bHRqxkGkzhS9jkPgagMJWk9d54uMXVZzl3GcUtj2M-L4iyRpxNiyyO6NtgkMuh8Q0fGDOINKUqO2R5e7Nk0MhuX3BNl13Iz3Tc-aTwe_7y-2H2qT0ZNZUgQNiLxDFfHQzhjj4ZMvve-kLHtlkyODF2Z3T_GsrCM-0dW_tpQmmHZpwv_JB3FHND9LqEUA0oURfRDhxX_q6y-oH0Y3eJUTA"
  host = "https://23.88.53.165:8443"
  insecure = true
  alias = "test"
}

// To use an alternate provider configuration for a resource or data source, set its provider meta-argument to a <PROVIDER NAME>.<ALIAS> reference:

// resource "aws_instance" "foo" {
//   provider = aws.west

//   # ...
// }
