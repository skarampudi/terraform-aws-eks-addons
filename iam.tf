# Associate IAM oidc provider
resource "aws_iam_openid_connect_provider" "this" {
  depends_on = [data.aws_eks_cluster.this]
  client_id_list  = [
    "sts.amazonaws.com"
  ]
  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]
  url             = data.aws_eks_cluster.this.identity.0.oidc.0.issuer
}

#  IAM role for fluentd-cloudwatch service account
resource "aws_iam_role" "fluentd_cloudwatch" {
  name               = "${var.cluster_name}-fluentd-cloudwatch-sa"
  assume_role_policy = data.aws_iam_policy_document.fluentd_cloudwatch_role_policy.json
}

resource "aws_iam_role_policy_attachment" "fluentd_cloudwatch" {
  role       = aws_iam_role.fluentd_cloudwatch.id
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

#  IAM role for cloudwatch-agent service account
resource "aws_iam_role" "cloudwatch_agent" {
  name               = "${var.cluster_name}-cloudwatch-agent-sa"
  assume_role_policy = data.aws_iam_policy_document.cloudwatch_agent_role_policy.json
}

resource "aws_iam_role_policy_attachment" "cloudwatch_agent" {
  role       = aws_iam_role.cloudwatch_agent.id
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

#  IAM role for aws-xray-daemon service account
resource "aws_iam_role" "aws_xray_daemon" {
  name               = "${var.cluster_name}-aws-xray-daemon-sa"
  assume_role_policy = data.aws_iam_policy_document.aws_xray_daemon_role_policy.json
}

resource "aws_iam_role_policy_attachment" "aws_xray_daemon" {
  role       = aws_iam_role.aws_xray_daemon.id
  policy_arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
}

#  IAM role for aws-alb-ingress-controller service account
resource "aws_iam_role" "aws_alb_ingress_controller" {
  name               = "${var.cluster_name}-aws-alb-ingress-controller-sa"
  assume_role_policy = data.aws_iam_policy_document.aws_alb_ingress_controller_role_policy.json
}

# IAM policy for aws-alb-ingress-controller role
resource "aws_iam_role_policy" "aws_alb_ingress_controller" {
  name = "${var.cluster_name}-aws-alb-ingress-controller-sa"
  role = aws_iam_role.aws_alb_ingress_controller.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "acm:DescribeCertificate",
        "acm:ListCertificates",
        "acm:GetCertificate"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:AuthorizeSecurityGroupIngress",
        "ec2:CreateSecurityGroup",
        "ec2:CreateTags",
        "ec2:DeleteTags",
        "ec2:DeleteSecurityGroup",
        "ec2:DescribeAccountAttributes",
        "ec2:DescribeAddresses",
        "ec2:DescribeInstances",
        "ec2:DescribeInstanceStatus",
        "ec2:DescribeInternetGateways",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeSubnets",
        "ec2:DescribeTags",
        "ec2:DescribeVpcs",
        "ec2:ModifyInstanceAttribute",
        "ec2:ModifyNetworkInterfaceAttribute",
        "ec2:RevokeSecurityGroupIngress"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "elasticloadbalancing:AddListenerCertificates",
        "elasticloadbalancing:AddTags",
        "elasticloadbalancing:CreateListener",
        "elasticloadbalancing:CreateLoadBalancer",
        "elasticloadbalancing:CreateRule",
        "elasticloadbalancing:CreateTargetGroup",
        "elasticloadbalancing:DeleteListener",
        "elasticloadbalancing:DeleteLoadBalancer",
        "elasticloadbalancing:DeleteRule",
        "elasticloadbalancing:DeleteTargetGroup",
        "elasticloadbalancing:DeregisterTargets",
        "elasticloadbalancing:DescribeListenerCertificates",
        "elasticloadbalancing:DescribeListeners",
        "elasticloadbalancing:DescribeLoadBalancers",
        "elasticloadbalancing:DescribeLoadBalancerAttributes",
        "elasticloadbalancing:DescribeRules",
        "elasticloadbalancing:DescribeSSLPolicies",
        "elasticloadbalancing:DescribeTags",
        "elasticloadbalancing:DescribeTargetGroups",
        "elasticloadbalancing:DescribeTargetGroupAttributes",
        "elasticloadbalancing:DescribeTargetHealth",
        "elasticloadbalancing:ModifyListener",
        "elasticloadbalancing:ModifyLoadBalancerAttributes",
        "elasticloadbalancing:ModifyRule",
        "elasticloadbalancing:ModifyTargetGroup",
        "elasticloadbalancing:ModifyTargetGroupAttributes",
        "elasticloadbalancing:RegisterTargets",
        "elasticloadbalancing:RemoveListenerCertificates",
        "elasticloadbalancing:RemoveTags",
        "elasticloadbalancing:SetIpAddressType",
        "elasticloadbalancing:SetSecurityGroups",
        "elasticloadbalancing:SetSubnets",
        "elasticloadbalancing:SetWebACL"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "iam:CreateServiceLinkedRole",
        "iam:GetServerCertificate",
        "iam:ListServerCertificates"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "cognito-idp:DescribeUserPoolClient"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "waf-regional:GetWebACLForResource",
        "waf-regional:GetWebACL",
        "waf-regional:AssociateWebACL",
        "waf-regional:DisassociateWebACL"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "tag:GetResources",
        "tag:TagResources"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "waf:GetWebACL"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

#  IAM role for external dns service account
resource "aws_iam_role" "external_dns" {
  name               = "${var.cluster_name}-external-dns-sa"
  assume_role_policy = data.aws_iam_policy_document.external_dns_assume_role_policy.json
}

# IAM policy for external dns role
resource "aws_iam_role_policy" "external_dns" {
  name = "${var.cluster_name}-external-dns-sa"
  role = aws_iam_role.external_dns.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "route53:ChangeResourceRecordSets"
      ],
      "Resource": [
        "arn:aws:route53:::hostedzone/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "route53:ListHostedZones",
        "route53:ListResourceRecordSets"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
} 
EOF
}