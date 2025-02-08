# Kubernetes Custom Autoscaler Controller

## Overview
A custom Kubernetes controller that implements specialized autoscaling logic for deployments. Built with Go and deployed via Terraform to AWS EKS.

## Features
- Monitors deployment metrics
- Implements custom scaling algorithms
- Integrates with AWS EKS
- Terraform-managed infrastructure

## Prerequisites
- Docker
- AWS CLI
- Terraform 1.5+
- Go 1.21+
- kubectl

## Deployment Workflow

### 1. Build Docker Image
```sh
docker build -t <your-registry>/custom-autoscaler:v1.0 .
```

### 2. Push to Container Registry
```sh
# For Docker Hub:
docker push <your-registry>/custom-autoscaler:v1.0

# For Amazon ECR:
aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <account-id>.dkr.ecr.<region>.amazonaws.com
docker tag custom-autoscaler:v1.0 <account-id>.dkr.ecr.<region>.amazonaws.com/custom-autoscaler:v1.0
docker push <account-id>.dkr.ecr.<region>.amazonaws.com/custom-autoscaler:v1.0
```

### 3. Deploy Infrastructure
```sh
cd terraform
terraform init
terraform apply -var="controller_image=<your-registry>/custom-autoscaler:v1.0"
```

### 4. Verify Deployment
```sh
kubectl get pods -l app=custom-autoscaler
kubectl logs deployment/custom-autoscaler
```

## Architecture
```plaintext
graph TD
    A[Custom Controller] -->|Monitors| B(Deployments)
    B --> C{Scaling Needed?}
    C -->|Yes| D[Scale Deployment]
    C -->|No| B
```

## Clean Up
```sh
terraform destroy
docker image rm <your-registry>/custom-autoscaler:v1.0
```

## Configuration Options
| Environment Variable | Description          | Default |
|----------------------|----------------------|---------|
| `SCALE_THRESHOLD`    | CPU% to trigger scale | 80      |
| `CHECK_INTERVAL`     | Metrics check frequency | 30s   |
```

**4. Terraform Updates**
In your controller module (`terraform/modules/controller/main.tf`):
```hcl
resource "kubernetes_deployment" "controller" {
  # ... existing config ...
  
  spec {
    template {
      spec {
        container {
          image = var.controller_image
          # Add environment variables if needed
          env {
            name  = "SCALE_THRESHOLD"
            value = "75"
          }
        }
      }
    }
  }
}
```

**4. Workflow Summary**
1. **Develop Controller**
   - Edit `controller.go`
   - Test locally: `go run controller.go`

2. **Build & Push Image**
   ```sh
   docker build -t <your-registry>/custom-autoscaler:v1.1 .
   docker push <your-registry>/custom-autoscaler:v1.1
   ```

3. **Update Infrastructure**
   ```sh
   cd terraform
   terraform apply -var="controller_image=<your-registry>/custom-autoscaler:v1.1"
   ```

4. **Monitor Operations**
   ```sh
   kubectl logs -f deployment/custom-autoscaler
   ```

**Key Notes:**
- The controller runs as a Deployment in your EKS cluster
- RBAC rules (from previous config) ensure proper permissions
- Image registry can be Docker Hub, ECR, or any private registry
- Version tagging helps manage updates
- The Terraform module completely manages the controller lifecycle

This setup provides a complete CI/CD pipeline for your custom controller from development to production deployment.
