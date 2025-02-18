# Project: Data Orchestration with Mage, Docker Compose, Terraform, and dlt for BigQuery

## Overview
This project sets up a data orchestration pipeline using [Mage](https://github.com/mage-ai/mage-ai), a modern open-source ETL tool, with Docker, Docker Compose, and Terraform for infrastructure management. The configuration includes a `docker-compose.yml` file to manage services, a `Dockerfile` to define the Mage container, and Terraform scripts to provision infrastructure. Additionally, we use [`dlt`](https://github.com/dlt-hub/dlt) to ingest data into Google BigQuery.

## Prerequisites
Ensure you have the following installed on your system:
- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [Python 3.7+](https://www.python.org/downloads/)
- Google Cloud SDK (for authentication with BigQuery)

## Project Structure
```
├── Dockerfile
├── terraformdemo/
│   ├── docker-compose.yml
│   ├── main.tf  # Terraform configuration file
│   ├── variables.tf  # Terraform variables file
│   ├── outputs.tf  # Terraform outputs file
├── mage_zoomcamp/  # Persistent volume for Mage
│   ├── docker-compose.yml
├── dlt/  # dlt pipeline for BigQuery ingestion
│   ├── DLT_upload_to_GCP.py  # Python script for data ingestion
    ├── big_query_datawarehousing.sql # SQL query for data warehousing
│   ├── requirements.txt  # Required Python packages
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

## Data Ingestion to BigQuery using dlt
We use `dlt` to extract and load data into Google BigQuery.

### 1. Install Dependencies
Navigate to the `dlt_pipeline/` directory and install required Python packages:
```bash
cd dlt_pipeline
pip install -r requirements.txt
```

### 2. Authenticate with Google Cloud
Ensure you have a Google Cloud service account JSON key file and set up authentication:
```bash
export GOOGLE_APPLICATION_CREDENTIALS="/path/to/your-service-account-key.json"
```

### 3. Run the Ingestion Script
Run the `ingest.py` script to fetch data and load it into BigQuery:
```bash
python ingest.py
```

### Example `ingest.py` Script
```python
import dlt
from dlt.sources import google_sheets

# Define the BigQuery pipeline
pipeline = dlt.pipeline(
    pipeline_name="bigquery_ingestion",
    destination="bigquery",
    dataset_name="your_dataset",
)

# Load data into BigQuery
data = [{"id": 1, "name": "Test Record"}, {"id": 2, "name": "Another Record"}]
pipeline.run(data, table_name="sample_table")
```

### 4. Verify Data in BigQuery
Once the script runs successfully, you can check your dataset in Google BigQuery:
```sql
SELECT * FROM `your_project.your_dataset.sample_table`;
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

