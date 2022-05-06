# при шаблонизации имя ресурса будет сформировано самим тераформом вида name["${each.key}"], т.е 
# в данном случае namespace ресурса итоговое имя будет namespace["namespace-1"]
# i.e https://gitlab.thesoul.io/tsp/devops/infrastructure-services/hetzner/-/jobs/842165

module "clusters" {
  source = "../clusters"
}

locals {
  namespaces = flatten([
    for cluster, namespaces_list in var.team_clusters : [
      for namespace_name, namespace_spec in namespaces_list : {
        namespace = namespace_name
        cluster = cluster
        labels = namespace_spec.labels
        annotations = namespace_spec.annotations
      }
    ]
  ])
}

resource "kubernetes_namespace_v1" "namespace" {
  for_each = {
    for namespace in local.namespaces : "${namespace.cluster}-${namespace.namespace}" => namespace
  }
  provider = each.cluster
  lifecycle {
    prevent_destroy = true
  }
  metadata {
    annotations = each.annotations
    labels = merge(each.labels, {team = var.team_name})
    name = each.namespace
  }
}

# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/network_policy
# https://learn.hashicorp.com/tutorials/terraform/for-each

resource "kubernetes_network_policy" "zero-trust" {
  for_each = var.team_clusters
  provider = each.cluster
  lifecycle {
    prevent_destroy = true
  }

  metadata {
    name      = "default-deny"
    namespace = each.namespace
  }

  spec {
    pod_selector {
      match_labels {}
    }

    policy_types = ["Ingress", "Egress"]
  }
}

# через conditional + count meta arg we can create access to Pods in same namespace and acccess to K8s DNS
