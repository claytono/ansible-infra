# Infrastructure as Code

This repository contains infrastructure automation using OpenTofu (for AWS
resources) and Ansible (for system configuration).

## Development Setup

This repository uses Nix flakes to provide a consistent development
environment with all required tools.

### Prerequisites

- [Nix](https://nixos.org/download.html) with flakes enabled

### Getting Started

```bash
# Enter the development environment (automatically installs all tools)
nix develop

# Run linting
./scripts/lint

# Run CI locally using act
./scripts/ci-local
```

The development environment includes OpenTofu, Ansible, AWS CLI, and all
necessary linting tools.

## OpenTofu

The `opentofu/` directory contains infrastructure definitions for AWS resources
including:

- DNS management via Route53
- S3 backend for state storage

### Linting

We use pre-commit hooks for automated linting and validation:

```bash
# From within the Nix development environment
# Install hooks (run from repository root)
pre-commit install

# Run manually
./scripts/lint
```

The pre-commit configuration includes automated linting and formatting for all
file types (shell scripts, markdown, YAML, and OpenTofu/Terraform with
security scanning).

## Ansible

### Misc Notes

- When building a new system, the ansible user will not exist the first time
  and it may be necessary to override the user to use when provisioning with
  the `-u` username argument. For example, when using the EC2 Ubuntu images,
  the default user will be `ubuntu`.
