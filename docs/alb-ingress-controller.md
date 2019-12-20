# aws-alb-ingress-controlle

[aws-alb-ingress-controller](https://kubernetes-sigs.github.io/aws-alb-ingress-controller/) is deployed to EKS cluster as an addon by this module. 

Inorder to use aws-alb ingress resource to expose it to traffic , use following similar ingress definition in your yanl file.

```yaml
---
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: <app name>
  namespace: <namespace>
  annotations:
    kubernetes.io/ingress.class: alb
    alb.ingress.kubernetes.io/scheme: internal
    alb.ingress.kubernetes.io/subnets: subnet-xxxx, subnet-xxxx, subnet-xxxx
    alb.ingress.kubernetes.io/listen-ports: '[{"HTTP":80}, {"HTTPS":443}]'
    alb.ingress.kubernetes.io/target-type: ip
    alb.ingress.kubernetes.io/certificate-arn: arn:aws:acm:us-east-1:xxxx:certificate/xxxx-xxxx
    alb.ingress.kubernetes.io/tags: foo=bar,env=dev
    alb.ingress.kubernetes.io/inbound-cidrs: 10.0.0.0/8
    alb.ingress.kubernetes.io/ssl-policy: ELBSecurityPolicy-FS-1-2-2019-08
    alb.ingress.kubernetes.io/actions.redirect-http-https: '{"Type":"redirect","RedirectConfig":{"Protocol":"HTTPS","Port":"443","Host":"#{host}","Path":"/#{path}","Query":"#{query}","StatusCode":"HTTP_301"}}'
    alb.ingress.kubernetes.io/load-balancer-attributes: routing.http2.enabled=true
spec:
  rules:
  - http:
      paths:
      - path: /
        backend:
          serviceName: <app name>
          servicePort: 80

```

verify that the Ingress resource is enabled:
```bash
kubectl get ingress/<Service Name> -n <namespace>
```
## References

* https://kubernetes-sigs.github.io/aws-alb-ingress-controller/
* https://docs.aws.amazon.com/eks/latest/userguide/alb-ingress.html
* https://eksworkshop.com/beginner/130_exposing-service/
