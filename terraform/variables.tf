variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}

variable "private_subnets" {
  description = "List of private subnet CIDR blocks"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  default     = "autoscale-cluster"
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  default     = "1.28"
}

variable "min_nodes" {
  description = "Minimum number of nodes in the EKS cluster"
  default     = 1
}

variable "max_nodes" {
  description = "Maximum number of nodes in the EKS cluster"
  default     = 5
}

variable "desired_nodes" {
  description = "Desired number of nodes in the EKS cluster"
  default     = 2
}

variable "controller_image" {
  description = "Docker image for the custom controller"
  type        = string
}
