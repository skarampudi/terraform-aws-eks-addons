# create amazon namespace 
resource "kubernetes_namespace" "amazon" { 
  metadata { 
    name = "amazon" 
 
    labels = { 
      name = "amazon" 
    } 
 
  } 
}