variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  type        = string
}

variable "cluster_ca_certificate" {
  description = "Cluster CA certificate"
  type        = string
}

variable "app_replicas" {
  description = "Number of replicas for the web app"
  type        = number
  default     = 2
}

variable "app_image" {
  description = "Docker image for the web app"
  type        = string
  default     = "nginx:latest"
}

variable "cpu_request" {
  description = "CPU request for the web app container"
  type        = string
  default     = "200m"
}

variable "memory_request" {
  description = "Memory request for the web app container"
  type        = string
  default     = "256Mi"
}

variable "cpu_limit" {
  description = "CPU limit for the web app container"
  type        = string
  default     = "500m"
}

variable "memory_limit" {
  description = "Memory limit for the web app container"
  type        = string
  default     = "512Mi"
}

variable "min_replicas" {
  description = "Minimum number of replicas for HPA"
  type        = number
  default     = 2
}

variable "max_replicas" {
  description = "Maximum number of replicas for HPA"
  type        = number
  default     = 5
}

variable "cpu_utilization_percentage" {
  description = "Target CPU utilization percentage for HPA"
  type        = number
  default     = 80
}
