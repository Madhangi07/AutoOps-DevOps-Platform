# AutoOps — DevOps Monitoring Platform

## Project Overview
AutoOps is a production-grade self-monitoring infrastructure automation platform
built on AWS using Terraform, Ansible, Jenkins, Docker, Prometheus, and Grafana.

## Architecture

### Infrastructure (Terraform)
- 3 EC2 instances (t3.micro) provisioned via Terraform
- 1 Security Group with ports: 22, 80, 8080, 9090, 9100, 3000
- S3 bucket for Terraform remote state
- Region: us-east-1

### Servers
| Server | IP | Role |
|---|---|---|
| App Server | 3.86.102.81 | Runs AutoOps Dashboard (Docker) |
| Jenkins Server | 3.95.154.196 | CI/CD Pipeline |
| Monitoring Server | 54.234.218.120 | Prometheus + Grafana |

### Configuration Management (Ansible)
- Installs Docker on all 3 servers
- Installs and starts node_exporter on all 3 servers
- Deploys Prometheus and Grafana containers on monitoring server

### CI/CD Pipeline (Jenkins)
Pipeline stages:
1. Checkout — pulls code from GitHub
2. Build Docker Image — builds autoops-dashboard image
3. Test — verifies app starts correctly
4. Deploy — transfers image to app server and runs container
5. Health Check — verifies app is live at port 80

### Application (Docker)
- Node.js Express app
- Displays live EC2 system metrics
- CPU, Memory, Disk, Uptime, Load Average
- Runs on port 80

### Monitoring (Prometheus + Grafana)
- Prometheus scrapes node_exporter metrics every 15 seconds
- Targets: all 3 EC2 servers on port 9100
- Grafana dashboard (ID: 1860) visualizes all metrics
- Metrics: CPU, Memory, Network, Disk, System Load

## Tools Used
- AWS EC2, S3, IAM
- Terraform
- Ansible
- Jenkins
- Docker
- Prometheus
- Grafana
- GitHub

## Repository Structure
```
AutoOps-DevOps-Platform/
├── terraform/       # Infrastructure as Code
├── ansible/         # Server configuration
├── jenkins/         # CI/CD pipeline
├── docker/          # Application container
├── monitoring/      # Prometheus config
└── docs/            # Documentation
```

## Resume Description
Built AutoOps, a production-grade self-monitoring infrastructure automation
platform on AWS. Provisioned 3-tier EC2 infrastructure with Terraform (remote
S3 state), configured servers using Ansible playbooks, implemented a Jenkins
CI/CD pipeline integrating Docker, and deployed Prometheus + Grafana monitoring
— all within a 24-hour sprint.