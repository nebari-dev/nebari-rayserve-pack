---
title: Reference
description: Full reference for the Nebari Ray Serve pack — values.yaml options, architecture and Kubernetes resources.
sidebar_position: 3
---

# Reference

Look-up material for the pack: every chart value, the Kubernetes
resources the pack creates at runtime, and the relationships between
them.

## What's in this section

- **[`values.yaml` reference](./values)** — every chart value with its
  default, type, and a one-line description. Grouped by area (NebariApp,
  Ray cluster, RayService, worker probes, GPU, serve applications).
- **[Architecture](./architecture)** — the Kubernetes resources the pack
  creates, the role of each (KubeRay operator, RayService CRD, head/worker
  pods, services, optional NebariApp), and how they interact during
  install, request serving, and rolling upgrades.
