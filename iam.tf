# Associate IAM oidc provider 
resource "aws_iam_openid_connect_provider" "this" { 
  client_id_list  = ["sts.amazonaws.com"] 
  thumbprint_list = [] 
  url             = data.aws_eks_cluster.this.identity.0.oidc.0.issuer
}