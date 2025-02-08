resource "kubernetes_deployment" "controller" {
  metadata {
    name = "custom-autoscaler"
    labels = {
      app = "custom-autoscaler"
    }
  }

  spec {
    replicas = var.controller_replicas

    selector {
      match_labels = {
        app = "custom-autoscaler"
      }
    }

    template {
      metadata {
        labels = {
          app = "custom-autoscaler"
        }
      }

      spec {
        container {
          image = var.controller_image
          name  = "controller"

          resources {
            requests = {
              cpu    = var.controller_cpu_request
              memory = var.controller_memory_request
            }
          }
        }

        service_account_name = kubernetes_service_account.controller.metadata[0].name
      }
    }
  }
}

resource "kubernetes_service_account" "controller" {
  metadata {
    name = "custom-controller-sa"
  }
}

resource "kubernetes_cluster_role" "controller" {
  metadata {
    name = "custom-controller-role"
  }

  rule {
    api_groups = [""]
    resources  = ["pods", "services", "deployments"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }
}
resource "kubernetes_cluster_role_binding" "controller" {
  metadata {
    name = "custom-controller-role-binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.controller.metadata[0].name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.controller.metadata[0].name
    namespace = "default"
  }
}