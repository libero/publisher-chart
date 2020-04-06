Libero Publisher vanilla Helm chart
===================================

Scope
-----

This repository contains a functional Helm chart for the deployment of Libero Publisher.

The product is set up with a vanilla configuration:

- a single `article-store`
- a single `article-page`

The chart is intended for installation on environments supporting the development of Libero products. Direct reuse of this chart from other organizations is not supported.

The chart can be forked and adapted liberally to create a new deployment solution, as it reflects a production-ready architecture.

Usage
-----

First, build the chart:

```
helm repo add stable https://kubernetes-charts.storage.googleapis.com
helm dependency build helm/publisher
```

Then to install or upgrade a release named `publisher--test` in the default namespace:

```
helm upgrade -i publisher--test helm/publisher
```

Or to install or upgrade in a chosen namespace:

```
helm upgrade -n my-namespace -i publisher--test helm/publisher
```

Getting help
------------

- Report a bug or request a feature on [GitHub](https://github.com/libero/publisher/issues/new/choose).
- Ask a question on the [Libero Community Slack](https://libero.pub/join-slack).
- Read the [code of conduct](https://libero.pub/code-of-conduct).
