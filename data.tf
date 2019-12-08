# Retrieve information about an EKS Cluster.
data "aws_eks_cluster" "this" { 
  name = var.cluster_name
}

# Get an authentication token to communicate with an EKS cluster
data "aws_eks_cluster_auth" "this" { 
  name = var.cluster_name
}