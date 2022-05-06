# при шаблонизации имя ресурса будет сформировано самим тераформом вида name["${each.key}"], т.е 
# в данном случае team_namespace ресурса итоговое имя будет team_namespace["namespace-1"]
# для цикла по     
#    namespace-1 = {
#      cluster = "nbg4"
#      labels = {}
# i.e https://gitlab.thesoul.io/tsp/devops/infrastructure-services/hetzner/-/jobs/842165

module "clusters" {
  source = "../clusters"
}

resource "kubernetes_namespace_v1" "team_namespace" {
  for_each = var.namespaces
  provider = clusters.kubernetes.${each.value.cluster}
  lifecycle {
    prevent_destroy = true
  }
  metadata {
    annotations = {}
    labels = merge(each.value.labels, {team = var.team_name})
    name = each.key
  }
}

# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/network_policy
# https://learn.hashicorp.com/tutorials/terraform/for-each

resource "kubernetes_network_policy" "zero-trust" {
  for_each = var.namespaces
  provider = clusters.kubernetes.${each.value.cluster}
  lifecycle {
    prevent_destroy = true
  }

  metadata {
    name      = "default-deny"
    namespace = each.key
  }

  spec {
    pod_selector {
      match_labels {}
    }

    policy_types = ["Ingress", "Egress"]
  }
}

# через conditional + count meta arg we can create access to Pods in same namespace and acccess to K8s DNS
