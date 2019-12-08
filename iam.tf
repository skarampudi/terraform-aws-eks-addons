# Associate IAM oidc provider 
resource "aws_iam_openid_connect_provider" "this" { 
  client_id_list  = ["sts.amazonaws.com"] 
  thumbprint_list = [] 
  url             = var.cluster_oidc_issuer_url
}