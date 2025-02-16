# Raspberry Pi Monitoring Stack with AI Tools

## Hit the Star! :star:

If you find this repository useful, please consider giving it a star. Your support is greatly appreciated! :pray:

## Introduction

This repository provides a comprehensive Docker stack for Raspberry Pi that combines powerful monitoring tools with modern AI capabilities. The stack includes monitoring solutions using Grafana, Prometheus, Cadvisor, and Node-Exporter, as well as AI tools like Ollama and Open WebUI for local AI interactions, and n8n for workflow automation.

This stack is based on the following components:
- [Grafana](http://grafana.org/) - Visualization and analytics
- [Prometheus](https://prometheus.io/) - Metrics collection and storage
- [cAdvisor](https://github.com/google/cadvisor) - Container metrics
- [NodeExporter](https://github.com/prometheus/node_exporter) - Hardware and OS metrics
- [Caddy](https://caddyserver.com/) - Reverse proxy with automatic HTTPS
- [Ollama](https://ollama.ai/) - Local AI model running
- [Open WebUI](https://openwebui.com/) - Web interface for AI interactions
- [n8n](https://n8n.io/) - Workflow automation

## Prerequisites

Before installing the stack, ensure you have:
- Docker installed
- Docker Compose installed
- A Raspberry Pi running Raspberry Pi OS or compatible Linux distribution

## Installation and Configuration

1. Clone this repository:
```bash
git clone https://github.com/oijkn/Docker-Raspberry-PI-Stack.git
```

2. Create required directories for configuration files:
```bash
mkdir -p grafana/provisioning && \
mkdir -p prometheus && \
sudo chown -R 472:472 grafana/ && \
sudo chown -R 65534:65534 prometheus/
```

Note: All data directories are now managed through Docker named volumes, which provides better isolation and portability. The volumes will be automatically created when you start the stack.

3. Configure environment variables:
Copy the example `.env` file and adjust it to your needs:
```bash
cp .env.example .env
```

The `.env` file contains the following configurations:

- **Timezone Configuration**
  - `GENERIC_TIMEZONE`: Set your timezone (default: UTC)

- **Ollama Configuration**
  - `OLLAMA_DOCKER_TAG`: Ollama Docker image tag (default: latest)

- **Open WebUI Configuration**
  - `WEBUI_DOCKER_TAG`: WebUI Docker image tag (default: main)
  - `WEBUI_SECRET_KEY`: Secret key for WebUI security

- **Grafana Configuration**
  - `GF_SECURITY_ADMIN_USER`: Admin username (default: admin)
  - `GF_SECURITY_ADMIN_PASSWORD`: Admin password (default: admin)
  - `GF_SERVER_HTTP_PORT`: Grafana port (default: 3030)
  - `GF_INSTALL_PLUGINS`: Pre-installed Grafana plugins

- **n8n Configuration**
  - `N8N_HOST`: Your n8n domain
  - `N8N_PORT`: n8n port (default: 5678)
  - `N8N_PROTOCOL`: Protocol (http/https)
  - `NODE_ENV`: Environment (production/development)
  - `WEBHOOK_URL`: Your n8n webhook URL

- **Prometheus Configuration**
  - `PROMETHEUS_RETENTION_TIME`: Data retention period (default: 1y)
  - `PROMETHEUS_RETENTION_SIZE`: Optional storage size limit

4. Start the stack:
```bash
docker-compose up -d
```

## Data Persistence

The stack uses Docker named volumes for data persistence:
- `caddy_data` and `caddy_config`: Caddy certificates and configuration
- `grafana_data`: Grafana databases and settings
- `prometheus_data`: Prometheus time series data
- `ollama_data`: Ollama models and configuration
- `webui_data`: Open WebUI settings and data
- `n8n_data`: n8n workflows and data

These volumes are automatically created and managed by Docker, ensuring data persistence across container restarts and updates.

## Available Services

The stack exposes the following services:
- Grafana: Port 3030
- Open WebUI: Port 3000
- n8n: Port 5678 (accessed via Caddy)
- Caddy: Ports 80 and 443 for HTTPS

Internal services (not directly exposed):
- Prometheus: Port 9090
- cAdvisor: Port 8080
- Node Exporter: Port 9100
- Ollama: Port 11434

## Monitoring Configuration

### Grafana

Grafana is preconfigured with:
- Data sources provisioning in `grafana/provisioning/datasources`
- Dashboards provisioning in `grafana/provisioning/dashboards`
- Persistent storage in Docker volume

### Prometheus

Prometheus is configured with:
- Long-term metrics storage (1 year retention)
- Configurable storage size limit
- Scraping configuration for all monitoring services

### AI Tools

#### Ollama
- Runs local AI models
- Persistent storage in Docker volume
- Accessible via Open WebUI

#### Open WebUI
- Provides web interface for AI interactions
- Connects to Ollama service
- Custom configuration via environment variables

### Workflow Automation

#### n8n
- Accessible via HTTPS through Caddy
- Persistent workflow storage
- Timezone configurable via environment variables

## Network Configuration

All services run on an internal Docker network for security, with Caddy handling external access and HTTPS termination.

## Troubleshooting

If you encounter issues with container metrics, enable cgroup on your Raspberry Pi:
```bash
sudo sed -i 's/^GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="cgroup_enable=cpuset cgroup_enable=memory cgroup_memory=1 swapaccount=1"/' /etc/default/grub
sudo update-grub
sudo reboot
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details