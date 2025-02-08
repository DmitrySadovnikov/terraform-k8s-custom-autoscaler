output "deployment_name" {
  description = "Name of the Kubernetes deployment"
  value       = kubernetes_deployment.web_app.metadata[0].name
}

output "hpa_name" {
  description = "Name of the Horizontal Pod Autoscaler"
  value       = kubernetes_horizontal_pod_autoscaler.web_hpa.metadata[0].name
}
