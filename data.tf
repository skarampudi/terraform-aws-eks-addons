data "aws_region" "current" {} 
 
data "aws_caller_identity" "current" {}

# Retrieve information about an EKS Cluster.
data "aws_eks_cluster" "this" { 
  name = var.cluster_name
}

# Get an authentication token to communicate with an EKS cluster
data "aws_eks_cluster_auth" "this" { 
  name = var.cluster_name
}

# fluentd-cloudwatch iam role trust relationship 
data "aws_iam_policy_document" "fluentd_cloudwatch_role_policy" { 
  statement { 
 
    actions = [ 
      "sts:AssumeRoleWithWebIdentity", 
    ] 
 
    principals { 
      type        = "Federated" 
      identifiers = ["${aws_iam_openid_connect_provider.this.arn}"] 
    }
 
  } 
}

# cloudwatch-container-insights iam role trust relationship 
data "aws_iam_policy_document" "cloudwatch_container_insights_role_policy" { 
  statement { 
 
    actions = [ 
      "sts:AssumeRoleWithWebIdentity", 
    ] 
 
    principals { 
      type        = "Federated" 
      identifiers = ["${aws_iam_openid_connect_provider.this.arn}"] 
    }
 
  } 
}

# aws-xray-daemon iam role trust relationship
data "aws_iam_policy_document" "aws_xray_daemon_role_policy" { 
  statement { 
 
    actions = [ 
      "sts:AssumeRoleWithWebIdentity", 
    ] 
 
    principals { 
      type        = "Federated" 
      identifiers = ["${aws_iam_openid_connect_provider.this.arn}"] 
    }
 
  } 
}

# alb ingress controller iam role trust relationship 
data "aws_iam_policy_document" "aws_alb_ingress_controller_role_policy" { 
  statement { 
 
    actions = [ 
      "sts:AssumeRoleWithWebIdentity", 
    ] 
 
    principals { 
      type        = "Federated" 
      identifiers = ["${aws_iam_openid_connect_provider.this.arn}"] 
    }
 
  } 
}
 
# external dns iam role trust relationship 
data "aws_iam_policy_document" "external_dns_assume_role_policy" { 
  statement { 
 
    actions = [ 
      "sts:AssumeRoleWithWebIdentity", 
    ] 
 
    principals { 
      type        = "Federated" 
      identifiers = ["${aws_iam_openid_connect_provider.this.arn}"] 
    }
 
  }
}

# stable official helm charts repository  
data "helm_repository" "stable" { 
    name = "stable" 
    url  = "https://kubernetes-charts.storage.googleapis.com" 
} 
 
# Incubator offical helm charts repository
data "helm_repository" "incubator" { 
    name = "incubator" 
    url  = "https://kubernetes-charts-incubator.storage.googleapis.com" 
} 
 