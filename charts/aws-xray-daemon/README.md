# AWS X-Ray Daemon on EKS or Kubernetes

* Set up the [X-Ray agent](https://aws.amazon.com/blogs/compute/application-tracing-on-kubernetes-with-aws-x-ray) as a DaemonSet on your Amazon EKS cluster or Kubernetes cluster for application Tracing.

```console
$ helm install ./aws-xray-daemon
```

## Introduction

This chart bootstraps a [X-Ray agent](https://aws.amazon.com/blogs/compute/application-tracing-on-kubernetes-with-aws-x-ray) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.4+ with Beta APIs enabled
- [kube2iam](../../stable/kube2iam) installed to used the **awsRole** config option

## Installing the Chart

To install the chart:

```console
# or add a role to aws with the correct policy to add to xray
$ helm install --name aws-xray-daemon ./aws-xray-daemon
```

The command deploys aws xray agent on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `aws-xray-daemon` deployment:

```console
$ helm delete aws-xray-daemon
```
The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the aws-xray-daemon chart and their default values.


| Parameter            | Description                                  | Default                          |
| ---------------------| -------------------------------------------- | ---------------------------------|
| `image.repository`   | Image repository                             | `amazon/aws-xray-daemon`        |
| `image.tag`          | Image tag                                    | `1.230621.0`                     |
| `image.pullPolicy`   | Image pull policy                            | `IfNotPresent`                   |
| `data`               | xray agent ConfigMap values.                 | `example configuration`          |