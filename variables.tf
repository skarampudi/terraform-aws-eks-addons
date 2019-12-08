variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
}

variable "cluster_endpoint" {
  description = "The endpoint for your EKS Kubernetes API."
  type        = string
}

variable "cluster_certificate_authority_data" {
  description = "PEM-encoded root certificates bundle for TLS authentication."
  type        = string
}

variable "cluster_oidc_issuer_url" {
  description = "The name of the EKS cluster."
  type        = string
}
