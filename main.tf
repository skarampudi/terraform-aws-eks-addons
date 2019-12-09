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
  depends_on = [
    kubernetes_cluster_role_binding.tiller,
    kubernetes_namespace.amazon
  ] 
 
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

  set { 
    name  = "rbac.serviceAccountName" 
    value = "fluentd-cloudwatch" 
  } 
 
  set { 
    name  = "rbac.serviceAccountAnnotations.eks\\.amazonaws\\.com/role-arn" 
    value = aws_iam_role.fluentd_cloudwatch.arn 
  }

}

# Install aws-alb-ingress-controller 
resource "helm_release" "aws-alb-ingress-controller" { 
  depends_on = [helm_release.fluentd-cloudwatch] 
 
  name       = "aws-alb-ingress-controller" 
  chart      = "aws-alb-ingress-controller" 
  repository = data.helm_repository.incubator.metadata.0.name 
  namespace  = "kube-system" 
  version    = "0.1.11" 
 
  set { 
    name  = "clusterName" 
    value = var.cluster_name 
  } 
 
  set { 
    name  = "awsRegion" 
    value = data.aws_region.current.name 
  } 
 
  set { 
    name  = "awsVpcID" 
    value = var.vpc_id 
  } 

  set { 
    name  = "rbac.create" 
    value = "true" 
  } 

  set { 
    name  = "rbac.serviceAccountName" 
    value = "aws-alb-ingress-controller" 
  } 
 
  set { 
    name  = "rbac.serviceAccountAnnotations.eks\\.amazonaws\\.com/role-arn" 
    value = aws_iam_role.aws-alb-ingress-controller.arn 
  } 
 
}

# Install external-dns 
resource "helm_release" "external-dns" { 
  depends_on = [
    kubernetes_cluster_role_binding.tiller
  ] 
 
  name       = "external-dns" 
  chart      = "external-dns" 
  repository = data.helm_repository.stable.metadata.0.name 
  namespace  = "kube-system" 
  version    = "2.12.0" 
  timeout    = 60 
 
  set { 
    name = "image.pullPolicy" 
    value = "Always" 
  } 
 
  set { 
    name  = "provider" 
    value = "aws" 
  } 
 
  set { 
    name  = "policy" 
    value = "upsert-only" 
  } 
 
  set { 
    name  = "rbac.create" 
    value = "true" 
  } 
 
  set { 
    name  = "rbac.serviceAccountName" 
    value = "external-dns" 
  } 
 
  set { 
    name  = "rbac.serviceAccountAnnotations.eks\\.amazonaws\\.com/role-arn" 
    value = aws_iam_role.external-dns.arn 
  }
 
} 