# AWS Integration Guide

This guide explains how to connect your deep learning project to Amazon Web Services (AWS) using Docker and Elastic Container Registry (ECR). It enables cloud-based deployment of your containerized environments.

## Requirements
- PyCharm **Professional Edition** or an **educational license** (free for students via [JetBrains Student Pack](https://www.jetbrains.com/academy/student-pack/))
- Docker and Docker Compose installed
- The container image must be built (but not running)

## Step-by-Step Instructions
The instructions are build for Debian-based systems. On any other OS search for your commands.

1. Install AWS CLI
    ```bash
    sudo apt install awscli -y
    ```
2. Configure AWS CLI
    ```bash
    aws configure
    ```
    You will be prompted to enter:
    - AWS Access Key ID
    - AWS Secret Access Key
    - Default region name (e.g. eu-central-1)
    - Default output format (e.g. json)
3. Create a remote repository
    ```bash
    aws ecr create-repository --repository-name <NAME_FOR_REPOSITORY>
    ```
4. Authenticate Docker with ECR 
    Replace \<AWS_ACCOUNT_ID\> and \<REGION\> with the actual values:
    ```bash
    aws ecr get-login-password \
    | docker login --username AWS \
    --password-stdin <AWS_ACCOUNT_ID>.dkr.ecr.<REGION>.amazonaws.com
    ``` 
5. Tag your local image
    ```bash
    docker tag <LOCAL_IMAGE_NAME>:latest \
    <AWS_ACCOUNT_ID>.dkr.ecr.<REGION>.amazonaws.com/<NAME_FOR_REPOSITORY>:latest
    ```
6. Push the image to ECR
    ```bash
    docker push <AWS_ACCOUNT_ID>.dkr.ecr.<REGION>.amazonaws.com/<NAME_FOR_REPOSITORY>:latest
    ```

## Deploying the Container on ECS
1. Create an ECS Cluster
    ```bash
    aws ecs create-cluster --cluster-name <CLUSTER_NAME>
    ```
2. Register a Task Definition
    Create a file task-def.json with the following content (simplified example):
    ```json
    {
        "family": "dl-template-task",
        "containerDefinitions": [
            {
            "name": "torch-cpu",
            "image": "<AWS_ACCOUNT_ID>.dkr.ecr.<REGION>.amazonaws.com/<NAME_FOR_REPOSITORY>:latest",
            "memory": 1024,
            "cpu": 512,
            "essential": true,
            "portMappings": [
                {
                "containerPort": 8888,
                "hostPort": 8888
                }
            ]
            }
        ],
        "requiresCompatibilities": ["FARGATE"],
        "networkMode": "awsvpc",
        "cpu": "512",
        "memory": "1024",
        "executionRoleArn": "arn:aws:iam::<AWS_ACCOUNT_ID>:role/ecsTaskExecutionRole"
    }
    ```
    Then register it:
    ```bash
    aws ecs register-task-definition --cli-input-json file://task-def.json
    ```
3. Run the Task
    ```bash
    aws ecs run-task \
    --cluster <CLUSTER_NAME> \
    --launch-type FARGATE \
    --network-configuration "awsvpcConfiguration={subnets=[<SUBNET_ID>],securityGroups=[<SECURITY_GROUP_ID>],assignPublicIp=ENABLED}" \
    --task-definition dl-template-task
    ```

> **Notes**
> - For GPU support, use EC2 launch type instead of Fargate.
> - Make sure your IAM role (ecsTaskExecutionRole) has permissions for ECR and ECS.
> - You can monitor your task in the AWS ECS Console.
