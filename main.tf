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
resource "helm_release" "fluentd_cloudwatch" {
  depends_on = [
    kubernetes_cluster_role_binding.tiller,
    kubernetes_namespace.amazon
  ]

  name       = "fluentd-cloudwatch"
  chart      = "fluentd-cloudwatch"
  repository = data.helm_repository.incubator.metadata.0.name
  namespace  = "amazon"
  version    = "0.12.0"

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

# Install cloudwatch-agent
resource "helm_release" "cloudwatch_agent" {
  depends_on = [
    kubernetes_cluster_role_binding.tiller,
    kubernetes_namespace.amazon
  ]

  name       = "cloudwatch-agent"
  namespace  = "amazon"
  chart      = "cloudwatch-agent"
  repository = "${path.module}/charts"
  version    = "0.1.0"

  set {
    name  = "awsRegion"
    value = data.aws_region.current.name
  }

  set {
    name  = "eksClusterName"
    value = var.cluster_name
  }

  set {
    name  = "rbac.create"
    value = true
  }

  set {
    name  = "rbac.serviceAccountName"
    value = "cloudwatch-agent"
  }

  set {
    name  = "rbac.serviceAccountAnnotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.cloudwatch_agent.arn
  }

}

# Install aws-xray-daemon
resource "helm_release" "aws_xray_daemon" {
  depends_on = [
    kubernetes_cluster_role_binding.tiller,
    kubernetes_namespace.amazon
  ]

  name       = "aws-xray-daemon"
  namespace  = "amazon"
  chart      = "aws-xray-daemon"
  repository = "${path.module}/charts"
  version    = "0.3.0"

  set {
    name  = "awsRegion"
    value = data.aws_region.current.name
  }

  set {
    name  = "rbac.create"
    value = true
  }

  set {
    name  = "rbac.serviceAccountName"
    value = "aws-xray-daemon"
  }

  set {
    name  = "rbac.serviceAccountAnnotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.aws_xray_daemon.arn
  }

}

# Install calico for securiing cluster with network policies
resource "helm_release" "calico" {
  depends_on = [
    kubernetes_cluster_role_binding.tiller
  ]

  name      = "calico"
  namespace = "kube-system"
  chart     = "calico"
  repository = "${path.module}/charts"
}

# Install metrics-server
resource "helm_release" "metrics_server" {
  depends_on = [
    kubernetes_cluster_role_binding.tiller
  ]

  name       = "metrics-server"
  chart      = "metrics-server"
  repository = data.helm_repository.stable.metadata.0.name
  namespace  = "metrics"
  version    = "2.8.7"
}

# Install aws-alb-ingress-controller
resource "helm_release" "aws_alb_ingress_controller" {
  depends_on = [
    kubernetes_cluster_role_binding.tiller
  ]

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
    value = aws_iam_role.aws_alb_ingress_controller.arn
  }

}

# Install external-dns
resource "helm_release" "external_dns" {
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
    value = aws_iam_role.external_dns.arn
  }
 
} 