# Vault Backup

This Helm Chart runs a cron job to backup Vault data stored in a GCS bucket into another GCS bucket.

## Requirements

To use the Helm Chart, you need to have the following:

- A GCS Bucket for backing up to
- A [Vault](https://www.vaultproject.io/) server setup with a Kubernetes Auth
Backend for the
    Kubernetes pod to authenticate with Vault and a GCS Secrets Engine Roleset configured for
    the pod to retrieve credentials for GCS.
- A Vault cluster that persists data in a GCS bucket

You can automate most of this using our
[Terraform Module](https://github.com/basisai/terraform-modules-gcp/blob/master/modules/vault_backup).
