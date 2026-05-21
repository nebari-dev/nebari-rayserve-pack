---
title: Get started
description: Install the Nebari Ray Serve pack on a standalone Kubernetes cluster or via ArgoCD on Nebari.
sidebar_position: 1
---

# Get started

This section is for **operators** installing the pack on a Kubernetes cluster.

The pack supports two install paths:

- **Standalone** — `helm install` against any Kubernetes cluster, including
  a local [kind](https://kind.sigs.k8s.io/) cluster. The simplest path for
  local dev and CI; no Nebari dependencies. Access the dashboard and serve
  endpoint via `kubectl port-forward`.
- **Nebari (ArgoCD + GitOps)** — the recommended production path. The chart
  creates NebariApp resources that the nebari-operator picks up to provision
  Envoy Gateway routing, TLS, and (optional) Keycloak OIDC auth. Requires
  the nebari-operator and Envoy Gateway to already be installed.

End users connecting to an already-deployed cluster should jump to
[How-to guides](../how-tos/) instead.

## What's in this section

- **[Deploy the pack](./deploy)** — the full install walkthrough for both
  paths, plus configuration knobs (NebariApp, Ray cluster sizing, GPU,
  worker probes, production image baking) and the operator troubleshooting
  index.
