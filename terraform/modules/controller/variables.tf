variable "controller_image" {
  description = "Docker image for the custom controller"
  type        = string
  default     = "myregistry/custom-controller:v1.0"
}

variable "controller_replicas" {
  description = "Number of controller replicas"
  type        = number
  default     = 1
}

variable "controller_cpu_request" {
  description = "CPU request for controller"
  type        = string
  default     = "100m"
}

variable "controller_memory_request" {
  description = "Memory request for controller"
  type        = string
  default     = "128Mi"
}
