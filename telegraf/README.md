# Telegraf

This chart is based off the stable Telegraf chart with additional Consul Template and Vault agent
sidecars to allow for better configuration and handling of secrets.

If you do not plan to use Consul or Vault with Telegraf, you should use the
[stable chart](https://github.com/helm/charts/tree/master/stable/telegraf) instead.

## Requirements

- Consul
- Vault (optional)

## Configuration

Consul Template is configured by default to write to `/etc/telegraf/telegraf.conf` with a basic
set of no-op configuration. It can render one or more files
into `/etc/telegraf` directory which is where Telegraf expects the configuration to be at.

You can render additional `.conf` files into `/etc/telegraf//telegraf.d` to merge them.

You should modify the template files at least to scrape and output metrics.
