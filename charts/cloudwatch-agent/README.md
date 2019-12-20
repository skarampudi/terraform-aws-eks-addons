# CloudWatch container insights

* Set up the (CloudWatch agent)[https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/deploy-container-insights-EKS.html] as a DaemonSet on your Amazon EKS cluster or Kubernetes cluster to send metrics to CloudWatch.

```console
$ helm install ./cloudwatch-container-insights
```

## Introduction

This chart bootstraps a [Cloudwatch agent](https://aws.amazon.com/cloudwatch/) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.4+ with Beta APIs enabled
- [kube2iam](../../stable/kube2iam) installed to used the **awsRole** config option

## Installing the Chart

To install the chart:

```console
# or add a role to aws with the correct policy to add to cloud watch
$ helm install --name cloudwatch-container-insights ./cloudwatch-container-insights --set awsRegion=<AWS Region>,eksClusterName=<Cluster Name>
```

The command deploys Cloudwatch Agent on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `cloudwatch-container-insights` deployment:

```console
$ helm delete cloudwatch-container-insights
```
The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the cloudwatch-container-insights chart and their default values.


| Parameter            | Description                                  | Default                          |
| ---------------------| -------------------------------------------- | ---------------------------------|
| `image.repository`   | Image repository                             | `amazon/cloudwatch-agent`        |
| `image.tag`          | Image tag                                    | `1.230621.0`                     |
| `image.pullPolicy`   | Image pull policy                            | `IfNotPresent`                   |
| `awsRegion`          | AWS Cloudwatch region                        | `us-east-1`                      |
| `eksClusterName`     | EKS Cluster name                             | `nil`                            |
| `data`               | CloudWatch agent ConfigMap values.           | `example configuration`          |