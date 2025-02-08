variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "min_nodes" {
  description = "Minimum number of nodes in the EKS cluster"
  type        = number
}

variable "max_nodes" {
  description = "Maximum number of nodes in the EKS cluster"
  type        = number
}

variable "desired_nodes" {
  description = "Desired number of nodes in the EKS cluster"
  type        = number
}
