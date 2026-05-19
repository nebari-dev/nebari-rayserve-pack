---
title: Troubleshoot
description: First-aid guide for the most common failures — version mismatch, network policy, crashlooping replicas, NebariApp not Ready.
sidebar_position: 2
---

# Troubleshoot

Quick index of the failure modes that come up most often. Each entry
links to the deeper write-up where the recovery steps live. Start
here, narrow to the right page, follow the steps.

## First checks

If you're not sure what's broken, run these three commands and read the
output before diving into anything else:

```bash
# Is the Ray cluster up?
kubectl get rayservice -n rayserve

# Are the pods running?
kubectl get pods -n rayserve

# If NebariApps are involved, are they Ready?
kubectl get nebariapp -n rayserve
```

The output tells you which layer to focus on:

- **RayService `NotRunning`** → operator or KubeRay layer. See
  [Deploy → Operator troubleshooting](../get-started/deploy#operator-troubleshooting).
- **Pods `Pending` / `CrashLoopBackOff` / `0/1 Ready`** → Ray pod itself.
  Most common: stale image pull, broken probes, OOMKilled. See
  [Crashlooping replicas](#crashlooping-replicas) below.
- **Pods Running but `ray.init` from notebook fails** → client-side. See
  [Version mismatch](#ray-version-mismatch).
- **NebariApp not Ready** → routing layer. See
  [NebariApp issues](#nebariapp-not-reaching-ready).

## End-user failures

### Ray version mismatch

The most common end-user failure. The Ray client's binary protocol is
sensitive to Ray version *and* Python minor version — Python 3.9 client
cannot talk to a Python 3.10 cluster, and Ray 2.43 client cannot talk to
a Ray 2.40 cluster.

Symptom: `ray.init(...)` hangs indefinitely, or returns an opaque
"connection error" or "version mismatch" exception.

→ Full recovery steps:
[Use Ray Serve → `ray.init` hangs or fails with a version error](./use#rayinit-hangs-or-fails-with-a-version-error).

### Notebook can't reach the Ray service

The default JupyterHub singleuser network policy blocks egress to private
cluster IPs. `ray.init` hangs indefinitely; `curl` from a notebook
terminal to the head service times out.

→ Full recovery steps:
[Use Ray Serve → Notebook can't reach the Ray service](./use#notebook-cant-reach-the-ray-service-network-policy-blocks-egress).

### Crashlooping replicas

`serve.run(...)` returns successfully but requests fail, hang, or return
500s. The Serve replica's worker pod is failing — usually an
`ImportError` on a missing package, an OOMKilled (host or CUDA), or a
model that raises on every request.

→ Full recovery steps:
[Use Ray Serve → My model is crashlooping or returning errors](./use#my-model-is-crashlooping-or-returning-errors).

:::info[Screenshot placeholder]

A screenshot of the Ray Dashboard's Serve tab showing a deployment in
`UNHEALTHY` state — captured against a real failing deployment — would
help readers recognise this state. Pair it with a `kubectl logs --previous`
output sample.

:::

## Operator failures

### ArgoCD shows permanent `OutOfSync`

The KubeRay controller mutates `RayService` and `Service` resources
at runtime; without an `ignoreDifferences` block, ArgoCD's diff never
closes.

→ Full recovery steps:
[Deploy → ArgoCD shows permanent `OutOfSync`](../get-started/deploy#argocd-shows-permanent-outofsync).

### NebariApp not reaching Ready

Most common cause: the namespace doesn't carry the `nebari.dev/managed: "true"`
label, so the nebari-operator silently ignores NebariApp resources in it.

→ Full recovery steps:
[Deploy → NebariApp stuck with `RoutingReady: False`](../get-started/deploy#nebariapp-stuck-with-routingready-false).

### Dashboard returns 500 via NebariApp

The NebariApp's HTTPRoute is pointing at a service that doesn't exist —
typically because `nebariapp.service.name` was overridden to a custom
value that was never created.

→ Full recovery steps:
[Deploy → Dashboard returns 500 via NebariApp](../get-started/deploy#dashboard-returns-500-via-nebariapp).

### Worker pods stuck `0/1 Ready`

Usually means the chart's `worker.readinessProbe` got overridden to `{}`
(empty map) instead of `null`. KubeRay's default probe chains a Serve
HTTP check that fails on a cluster with no apps deployed.

→ Full recovery steps:
[Deploy → Worker pods stuck `0/1 Ready`](../get-started/deploy#worker-pods-stuck-01-ready).

## Still stuck?

- Compare `kubectl describe rayservice -n rayserve` against the
  [Architecture page](../references/architecture) to see which condition
  is failing.
- Open an issue at
  [nebari-rayserve-pack/issues](https://github.com/nebari-dev/nebari-rayserve-pack/issues)
  with the output of the three [First checks](#first-checks) commands and
  the last 200 lines of `kubectl logs` for the failing pod.
- For Ray-specific behaviour, the upstream
  [Ray Serve troubleshooting](https://docs.ray.io/en/latest/serve/troubleshooting.html)
  page covers controller, replica, and request-path failures in more
  depth.
