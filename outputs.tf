output "fluentd_cloudwatch_helm_release_metadata" {
  description = "Block status of the deployed fluentd cloudwatch helm release."
  value       = helm_release.fluentd-cloudwatch.metadata
}

output "aws_alb_ingress_controller_helm_release_metadata" {
  description = "Block status of the deployed aws-alb-ingress-controller helm release."
  value       = helm_release.aws-alb-ingress-controller.metadata
}

output "external_dns_helm_release_metadata" {
  description = "Block status of the deployed external-dns helm release."
  value       = helm_release.external-dns.metadata
}