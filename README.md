# Infrastructure as Code

This repository contains infrastructure automation using OpenTofu (for AWS
resources) and Ansible (for system configuration).

## OpenTofu

The `opentofu/` directory contains infrastructure definitions for AWS resources
including:

- DNS management via Route53
- S3 backend for state storage

### Linting

We use pre-commit hooks for automated linting and validation:

```bash
# Install pre-commit
pip install pre-commit

# Install hooks (run from repository root)
pre-commit install

# Run manually
./scripts/lint.sh
```

The pre-commit configuration includes automated linting and formatting for all
file types (shell scripts, markdown, YAML, Nix, and OpenTofu/Terraform with
security scanning).

## Ansible

### Misc Notes

- When building a new system, the ansible user will not exist the first time
  and it may be necessary to override the user to use when provisioning with
  the `-u` username argument. For example, when using the EC2 Ubuntu images,
  the default user will be `ubuntu`.
