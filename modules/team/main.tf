# при шаблонизации имя ресурса будет сформировано самим тераформом вида name["${each.key}"], т.е 
# в данном случае namespace ресурса итоговое имя будет namespace["namespace-1"]
# i.e https://gitlab.thesoul.io/tsp/devops/infrastructure-services/hetzner/-/jobs/842165

# то еще извращение...

# МОЖНО ЧЕРЕЗ locals сделать словарь из providers и по ключу получать нужный, затем передавать его в for_each

locals {
  namespaces = flatten([
    for cluster, namespaces_list in var.team_namespaces : [
      for namespace_name, namespace_spec in namespaces_list : {
        name = namespace_name
        cluster = var.cluster_name
        labels = namespace_spec.labels
        annotations = namespace_spec.annotations
      }
    ]
  ])
}

resource "kubernetes_namespace" "namespace" {
  for_each = {
    for namespace in local.namespaces : "${namespace.cluster}-${namespace.name}" => namespace
  }
  lifecycle {
    prevent_destroy = true
  }
  metadata {
    annotations = each.value.annotations
    labels = merge(each.value.labels, {team = var.team_name})
    name = each.value.name
  }
}

# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/network_policy
# https://learn.hashicorp.com/tutorials/terraform/for-each

resource "kubernetes_network_policy" "zero-trust" {
  for_each = {
    for namespace in local.namespaces : "${namespace.cluster}-${namespace.name}" => namespace
  }
  lifecycle {
    prevent_destroy = true
  }

  metadata {
    name      = "default-deny"
    namespace = each.value.name
  }

  spec {
    pod_selector {}

    policy_types = ["Ingress", "Egress"]
  }
}

# через conditional + count meta arg we can create access to Pods in same namespace and acccess to K8s DNS
