# Project: Data Orchestration with Mage, Docker Compose, and Terraform

## Overview
This project sets up a data orchestration pipeline using [Mage](https://github.com/mage-ai/mage-ai), a modern open-source ETL tool, with Docker, Docker Compose, and Terraform for infrastructure management. The configuration includes a `docker-compose.yml` file to manage services, a `Dockerfile` to define the Mage container, and Terraform scripts to provision infrastructure.

## Prerequisites
Ensure you have the following installed on your system:
- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- [Terraform](https://developer.hashicorp.com/terraform/downloads)

## Project Structure
```
├── Dockerfile
├── terraformdemo/
│   ├── docker-compose.yml
│   ├── main.tf  # Terraform configuration file
│   ├── variables.tf  # Terraform variables file
│   ├── outputs.tf  # Terraform outputs file
├── mage_data/  # Persistent volume for Mage
│   ├── docker-compose.yml
└── README.md
```

## Setup and Installation
### 1. Clone the Repository
```bash
git clone <repository-url>
cd <repository-name>
```

### 2. Build and Start the Containers
Run the following command to build the Docker image and start the Mage service:
```bash
docker-compose up -d --build
```
This will:
- Build the Docker image based on the `Dockerfile`
- Start the Mage UI and backend

### 3. Access Mage UI
Once the container is up and running, open your browser and navigate to:
```
http://localhost:6789
```
Here, you can create and manage your data pipelines.

## Using Terraform
### 1. Initialize Terraform
```bash
cd terraformdemo
terraform init
```

### 2. Plan Terraform Deployment
```bash
terraform plan
```

### 3. Apply Terraform Deployment
```bash
terraform apply
```

### 4. Destroy Terraform Infrastructure (if needed)
```bash
terraform destroy
```

## Stopping and Restarting the Containers
To stop the containers, run:
```bash
docker-compose down
```
To restart after changes:
```bash
docker-compose up -d --build
```

## Cleaning Up
If you want to remove all associated containers and volumes, run:
```bash
docker-compose down -v
```

## Logs and Debugging
To check logs for debugging, use:
```bash
docker-compose logs -f
```

## License
This project is licensed under the MIT License.

## Contributing
Feel free to submit issues or pull requests for improvements!

