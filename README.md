# Ticketing Platform — DevOps CI/CD Project

A containerized ticketing platform deployed on Kubernetes using Helm, with a complete CI/CD pipeline implemented with Jenkins, Docker Hub, GitHub Webhooks, NGINX Ingress, Prometheus, and Grafana.

The project demonstrates a production-style DevOps workflow from source code commit to automated build, testing, container image publishing, Kubernetes deployment, and infrastructure monitoring.

---

## Architecture

```text
                    Developer
                        |
                        v
                    GitHub
                        |
                     Webhook
                        |
                        v
                    Jenkins
                        |
          +-------------+-------------+
          |                           |
          v                           v
    Build & Test                 Docker Build
          |                           |
          +-------------+-------------+
                        |
                        v
                    Docker Hub
                        |
                        v
                  Helm Deployment
                        |
                        v
              Kubernetes / Kind
                        |
                +-------+-------+
                |               |
                v               v
             Ingress         Monitoring
                |               |
                v               v
            Frontend       Prometheus
                |               |
                v               v
             Backend          Grafana
                |
                v
            PostgreSQL
                |
                v
                PVC


project/
│
├── backend/
│   ├── app/
│   │   ├── main.py
│   │   └── requirements.txt
│   └── Dockerfile
│
├── frontend/
│   ├── Dockerfile
│   ├── index.html
│   └── nginx.conf
│
├── helm/
│   └── ticketing/
│       ├── Chart.yaml
│       ├── values.yaml
│       ├── templates/
│       │   ├── backend.yaml
│       │   ├── backend-config.yaml
│       │   ├── frontend.yaml
│       │   ├── postgres.yaml
│       │   ├── postgres-secret.yaml
│       │   ├── ingress.yaml
│       │   ├── namespace.yaml
│       │   └── jenkins-rbac.yaml
│       └── secrets.yaml
│
├── scripts/
│   └── backup-db.sh
│
├── docker-compose.yml
├── Jenkinsfile
├── kind-config.yaml
├── .gitignore
└── README.md


Project Goals

This project was built to demonstrate practical experience with:

Linux
Git
GitHub
Docker
Docker Compose
Jenkins
CI/CD
Docker Hub
Kubernetes
Helm
Kubernetes RBAC
ConfigMaps
Secrets
Persistent Volumes
NGINX Ingress
Prometheus
Grafana
Alertmanager
Infrastructure monitoring
Automated application deployment
Future Improvements

Possible future improvements include:

TLS/HTTPS with cert-manager
Horizontal Pod Autoscaling
NetworkPolicies
More comprehensive automated tests
SonarQube or static code analysis
Trivy container image scanning
External secret management
Production Kubernetes cluster
Centralized logging with Loki
Backup and restore automation
Database migrations
Separate staging and production environments





Author

Kerollos Ehab

DevOps / IT Infrastructure enthusiast
