#!/bin/bash

# Exit immediately on error
set -e

# Variables
region="us-east-1"
repository_name="flask-ecs-app"
cluster_name="flask-ecs-cluster"
service_name="flask-ecs-service"
task_family="flask-ecs-task"
log_group="/ecs/flask-app"

cd ..

# Validate AWS CLI configuration
if ! aws sts get-caller-identity --query Account --output text >/dev/null 2>&1; then
    echo "AWS CLI is not configured properly. Please run 'aws configure'."
    exit 1
fi

# Fetch AWS account ID
account=$(aws sts get-caller-identity --query Account --output text)

# Login to ECR
echo "Logging into Amazon ECR..."
aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${account}.dkr.ecr.${region}.amazonaws.com

# Check if the ECR repository exists; if not, create it
if ! aws ecr describe-repositories --region ${region} --repository-names ${repository_name} >/dev/null 2>&1; then
    echo "Creating ECR repository: ${repository_name}..."
    aws ecr create-repository --repository-name ${repository_name} --region ${region}
fi

# Create and use a new builder instance for multi-platform builds
echo "Setting up Docker Buildx builder..."
if ! docker buildx inspect mybuilder >/dev/null 2>&1; then
    docker buildx create --name mybuilder --use
    docker buildx inspect --bootstrap
else
    docker buildx use mybuilder
fi

# Build and push the Docker image for the specified platforms
echo "Building and pushing Docker image..."
docker buildx build --platform linux/amd64,linux/arm64 -f Dockerfile_prod -t ${account}.dkr.ecr.${region}.amazonaws.com/${repository_name}:latest --push .

# Get the image's SHA digest from ECR
echo "Fetching the image digest..."
image_digest=$(aws ecr describe-images --repository-name ${repository_name} --region ${region} \
    --query "sort_by(imageDetails,&imagePushedAt)[-1].imageDigest" --output text)

full_image_url="${account}.dkr.ecr.${region}.amazonaws.com/${repository_name}@${image_digest}"

echo "Latest image URL: ${full_image_url}"

# Check if the CloudWatch log group exists; if not, create it
if ! aws logs describe-log-groups --log-group-name-prefix "${log_group}" --region ${region} --query "logGroups[?logGroupName=='${log_group}']" --output text >/dev/null 2>&1; then
    echo "Creating CloudWatch log group: ${log_group}..."
    aws logs create-log-group --log-group-name "${log_group}" --region ${region}
else
    echo "CloudWatch log group already exists: ${log_group}"
fi

# Register a new ECS task definition
echo "Registering new ECS Task Definition..."
task_definition_arn=$(aws ecs register-task-definition \
    --family ${task_family} \
    --execution-role-arn arn:aws:iam::${account}:role/stock_predictor_flask_app \
    --network-mode awsvpc \
    --requires-compatibilities FARGATE \
    --cpu "512" \
    --memory "1024" \
    --container-definitions "[
        {
            \"name\": \"flask-container\",
            \"image\": \"${full_image_url}\",
            \"portMappings\": [
                {
                    \"containerPort\": 5000,
                    \"protocol\": \"tcp\"
                }
            ],
            \"essential\": true,
            \"logConfiguration\": {
                \"logDriver\": \"awslogs\",
                \"options\": {
                    \"awslogs-group\": \"${log_group}\",
                    \"awslogs-region\": \"${region}\",
                    \"awslogs-stream-prefix\": \"ecs\"
                }
            }
        }
    ]" \
    --query "taskDefinition.taskDefinitionArn" --output text)

echo "Registered new task definition: ${task_definition_arn}"

# Update ECS Service to use the new task definition
echo "Updating ECS Service..."
aws ecs update-service \
    --cluster ${cluster_name} \
    --service ${service_name} \
    --task-definition ${task_definition_arn} \
    --force-new-deployment

echo "ECS Service updated successfully to use the latest image."