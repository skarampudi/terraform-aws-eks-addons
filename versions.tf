terraform {
  required_version = ">= 0.12.6"

}

provider "kubernetes" { 
  host                   = data.aws_eks_cluster.this.endpoint
  token                  = data.aws_eks_cluster_auth.this.token 
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority.0.data)
  load_config_file       = false
} 

provider "helm" { 
  install_tiller  = true 
  tiller_image    = "gcr.io/kubernetes-helm/tiller:v2.16.1" 
  service_account = "tiller"

  kubernetes { 
    host                   = data.aws_eks_cluster.this.endpoint
    token                  = data.aws_eks_cluster_auth.this.token 
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority.0.data)
    load_config_file       = false 
  } 
}  