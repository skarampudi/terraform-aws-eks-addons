output "fluentd_cloudwatch_helm_release_metadata" {
  description = "Block status of the deployed fluentd cloudwatch helm release."
  value       = helm_release.fluentd-cloudwatch.metadata
}