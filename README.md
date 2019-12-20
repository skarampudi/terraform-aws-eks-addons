# terraform-aws-eks-addons
Terraform module for aws eks addons

A terraform module to deploy all addons using helm charts. Inspired by and adapted from https://eksworkshop.com/ and Terraform Module https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/7.0.0.

## Usage example

```hcl

module "my-cluster" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "my-cluster"
  cluster_version = "1.14"
  subnets         = ["subnet-abcde012", "subnet-bcde012a", "subnet-fghi345a"]
  vpc_id          = "vpc-1234556abcdef"

  worker_groups = [
    {
      instance_type = "m4.large"
      asg_max_size  = 5
    }
  ]
}

module "addons" {
  source          = "git@github.com:skarampudi/terraform-aws-eks-addons.git"
  cluster_name    = "module.eks.cluster_id"
  vpc_id          = "vpc-1234556abcdef"
}

```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| cluster\_name | The name of the EKS cluster. | `string` | n/a | yes |
| vpc\_id | VPC where the cluster and workers will be deployed. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| aws\_alb\_ingress\_controller\_helm\_release\_metadata | Block status of the deployed aws-alb-ingress-controller helm release. |
| aws\_xray\_daemon\_helm\_release\_metadata | Block status of the deployed fluentd-cloudwatch helm release. |
| cloudwatch\_agent\_helm\_release\_metadata | Block status of the deployed fluentd-cloudwatch helm release. |
| external\_dns\_helm\_release\_metadata | Block status of the deployed external-dns helm release. |
| fluentd\_cloudwatch\_helm\_release\_metadata | Block status of the deployed fluentd-cloudwatch helm release. |