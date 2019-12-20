output "fluentd_cloudwatch_helm_release_metadata" {
  description = "Block status of the deployed fluentd-cloudwatch helm release."
  value       = helm_release.fluentd_cloudwatch.metadata
}

output "cloudwatch_agent_helm_release_metadata" {
  description = "Block status of the deployed fluentd-cloudwatch helm release."
  value       = helm_release.cloudwatch_agent.metadata
}

output "aws_xray_daemon_helm_release_metadata" {
  description = "Block status of the deployed fluentd-cloudwatch helm release."
  value       = helm_release.aws_xray_daemon.metadata
}

output "aws_alb_ingress_controller_helm_release_metadata" {
  description = "Block status of the deployed aws-alb-ingress-controller helm release."
  value       = helm_release.aws_alb_ingress_controller.metadata
}

output "external_dns_helm_release_metadata" {
  description = "Block status of the deployed external-dns helm release."
  value       = helm_release.external_dns.metadata
}