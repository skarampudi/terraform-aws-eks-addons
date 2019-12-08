terraform {
  required_version = ">= 0.12.6"

}
 
provider "helm" { 
  install_tiller  = true 
  tiller_image    = "gcr.io/kubernetes-helm/tiller:v2.16.1" 
  service_account = "tiller"

  kubernetes { 
    host                   = var.cluster_endpoint
    cluster_ca_certificate = base64decode(var.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.this.token 
    load_config_file       = false 
  } 
} 