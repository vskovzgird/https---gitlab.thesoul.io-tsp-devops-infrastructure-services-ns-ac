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

provider "kubernetes" {
  host                   = "https://k8s-master1.nbg4.tsp.li:6443"
  cluster_ca_certificate = ""
  alias = "nbg4"
}

provider "kubernetes" {
  host                   = "https://k8s-master1.nbg3.tsp.la:6443"
  cluster_ca_certificate = ""
  alias = "nbg3"
}

provider "kubernetes" {
  host                   = "https://k8s-master1.nbg2.tsp.li:6443"
  cluster_ca_certificate = ""
  alias = "nbg2"
}

// To use an alternate provider configuration for a resource or data source, set its provider meta-argument to a <PROVIDER NAME>.<ALIAS> reference:

// resource "aws_instance" "foo" {
//   provider = aws.west

//   # ...
// }
