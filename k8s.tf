# Create service account for tiller
resource "kubernetes_service_account" "tiller" { 
  metadata { 
    name = "tiller" 
    namespace = "kube-system" 
  } 
} 

# Bind cluster role to tiller service account
resource "kubernetes_cluster_role_binding" "tiller" { 
  depends_on = [kubernetes_service_account.tiller] 
 
  metadata { 
    name = kubernetes_service_account.tiller.metadata[0].name 
  } 
 
  role_ref { 
      api_group = "rbac.authorization.k8s.io" 
      kind = "ClusterRole" 
      name = "cluster-admin" 
  } 
 
  subject { 
      api_group = "" 
      kind = "ServiceAccount" 
      name = "tiller" 
      namespace = "kube-system" 
  } 
} 