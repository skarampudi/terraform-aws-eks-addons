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