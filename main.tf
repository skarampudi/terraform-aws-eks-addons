# create amazon namespace 
resource "kubernetes_namespace" "amazon" {
  depends_on = [data.aws_eks_cluster.this]

  metadata { 
    name = "amazon" 
 
    labels = { 
      name = "amazon" 
    } 
 
  } 
}

# Install fluentd-cloudwatch 
resource "helm_release" "fluentd-cloudwatch" { 
  depends_on = [kubernetes_cluster_role_binding.tiller, kubernetes_namespace.amazon] 
 
  name       = "fluentd-cloudwatch" 
  chart      = "fluentd-cloudwatch" 
  repository = data.helm_repository.incubator.metadata.0.name 
  namespace  = "amazon" 
  version    = "0.11.1" 
 
  set { 
    name  = "awsRegion" 
    value = data.aws_region.current.name 
  } 
 
  set { 
    name  = "logGroupName" 
    value = "/aws/eks/${var.cluster_name}/application" 
  } 
 
  set { 
    name  = "rbac.create" 
    value = true 
  } 
 
}