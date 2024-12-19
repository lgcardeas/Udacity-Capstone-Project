#!/bin/bash

# Variables
AWS_REGION="us-east-1"
CLUSTER_NAME="flask-ecs-cluster"
TASK_FAMILY="flask-ecs-task"
SERVICE_NAME="flask-ecs-service"
IMAGE_URL="072298625118.dkr.ecr.us-east-1.amazonaws.com/flask-ecs-app:latest"
ALB_NAME="flask-app-alb"
TARGET_GROUP_NAME="flask-ecs-target-group"
SECURITY_GROUP_NAME="flask-ecs-sg"
IAM_EXECUTION_ROLE_NAME="stock_predictor_execution_role"
IAM_TASK_ROLE_NAME="stock_predictor_task_role"
IAM_POLICY_ARN="arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
LOG_GROUP_NAME="/ecs/flask-app"
BUCKET_NAME="capstone-stock-predictable-project"

# 1. Check and Create VPC
echo "Checking for existing VPC..."
VPC_ID=$(aws ec2 describe-vpcs \
    --region ${AWS_REGION} \
    --filters Name=tag:Name,Values=flask-ecs-vpc \
    --query "Vpcs[0].VpcId" --output text)

if [ "$VPC_ID" == "None" ]; then
    echo "Creating VPC..."
    VPC_ID=$(aws ec2 create-vpc \
        --cidr-block 10.0.0.0/16 \
        --region ${AWS_REGION} \
        --query "Vpc.VpcId" --output text)
    aws ec2 create-tags \
        --resources ${VPC_ID} \
        --tags Key=Name,Value=flask-ecs-vpc
fi
echo "VPC ID: ${VPC_ID}"

# Create IAM Execution Role
# Check for IAM Execution Role
echo "Checking for IAM Execution Role..."
EXECUTION_ROLE_ARN=$(aws iam get-role \
    --role-name ${IAM_EXECUTION_ROLE_NAME} \
    --query "Role.Arn" \
    --output text 2>/dev/null || echo "None")

if [ "$EXECUTION_ROLE_ARN" == "None" ]; then
    echo "Creating IAM Execution Role..."
    EXECUTION_ROLE_ARN=$(aws iam create-role \
        --role-name ${IAM_EXECUTION_ROLE_NAME} \
        --assume-role-policy-document '{
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Effect": "Allow",
                    "Principal": {
                        "Service": "ecs-tasks.amazonaws.com"
                    },
                    "Action": "sts:AssumeRole"
                }
            ]
        }' \
        --query "Role.Arn" --output text)
    echo "Execution Role created: ${EXECUTION_ROLE_ARN}"
fi

# Check and Attach Inline Policy to Execution Role
EXECUTION_POLICY_NAME="ExecutionPolicy"
echo "Checking for Execution Role Inline Policy..."
EXISTING_POLICY=$(aws iam get-role-policy \
    --role-name ${IAM_EXECUTION_ROLE_NAME} \
    --policy-name ${EXECUTION_POLICY_NAME} \
    2>/dev/null || echo "None")

if [ "$EXISTING_POLICY" == "None" ]; then
    echo "Attaching inline policy to IAM Execution Role..."
    aws iam put-role-policy \
        --role-name ${IAM_EXECUTION_ROLE_NAME} \
        --policy-name ${EXECUTION_POLICY_NAME} \
        --policy-document '{
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Effect": "Allow",
                    "Action": [
                        "ecr:GetAuthorizationToken",
                        "ecr:BatchCheckLayerAvailability",
                        "ecr:GetDownloadUrlForLayer",
                        "ecr:BatchGetImage",
                        "logs:CreateLogStream",
                        "logs:PutLogEvents"
                    ],
                    "Resource": "*"
                }
            ]
        }'
    echo "Inline policy attached to Execution Role."
else
    echo "Inline policy already exists on Execution Role."
fi

# Check for IAM Task Role
echo "Checking for IAM Task Role..."
TASK_ROLE_ARN=$(aws iam get-role \
    --role-name ${IAM_TASK_ROLE_NAME} \
    --query "Role.Arn" \
    --output text 2>/dev/null || echo "None")

if [ "$TASK_ROLE_ARN" == "None" ]; then
    echo "Creating IAM Task Role..."
    TASK_ROLE_ARN=$(aws iam create-role \
        --role-name ${IAM_TASK_ROLE_NAME} \
        --assume-role-policy-document '{
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Effect": "Allow",
                    "Principal": {
                        "Service": "ecs-tasks.amazonaws.com"
                    },
                    "Action": "sts:AssumeRole"
                }
            ]
        }' \
        --query "Role.Arn" --output text)
    echo "Task Role created: ${TASK_ROLE_ARN}"

    echo "Attaching inline policy to IAM Task Role..."
    aws iam put-role-policy \
        --role-name ${IAM_TASK_ROLE_NAME} \
        --policy-name "TaskRolePolicy" \
        --policy-document "{
            \"Version\": \"2012-10-17\",
            \"Statement\": [
                {
                    \"Effect\": \"Allow\",
                    \"Action\": [
                        \"s3:GetObject\",
                        \"s3:ListBucket\"
                    ],
                    \"Resource\": [
                        \"arn:aws:s3:::${BUCKET_NAME}\",
                        \"arn:aws:s3:::${BUCKET_NAME}/*\"
                    ]
                }
            ]
        }"
    echo "Inline policy attached to Task Role."
else
    echo "IAM Task Role already exists: ${TASK_ROLE_ARN}"
fi
# 2. Check and Create Subnets
echo "Checking for existing Private Subnets..."
PRIVATE_SUBNET_1=$(aws ec2 describe-subnets \
    --region ${AWS_REGION} \
    --filters Name=tag:Name,Values=flask-private-subnet-1 \
    --query "Subnets[0].SubnetId" --output text)

if [ "$PRIVATE_SUBNET_1" == "None" ]; then
    echo "Creating Private Subnet 1..."
    PRIVATE_SUBNET_1=$(aws ec2 create-subnet \
        --vpc-id ${VPC_ID} \
        --cidr-block 10.0.3.0/24 \
        --availability-zone ${AWS_REGION}a \
        --query "Subnet.SubnetId" --output text)
    aws ec2 create-tags \
        --resources ${PRIVATE_SUBNET_1} \
        --tags Key=Name,Value=flask-private-subnet-1
fi
echo "Private Subnet 1: ${PRIVATE_SUBNET_1}"

PRIVATE_SUBNET_2=$(aws ec2 describe-subnets \
    --region ${AWS_REGION} \
    --filters Name=tag:Name,Values=flask-private-subnet-2 \
    --query "Subnets[0].SubnetId" --output text)

if [ "$PRIVATE_SUBNET_2" == "None" ]; then
    echo "Creating Private Subnet 2..."
    PRIVATE_SUBNET_2=$(aws ec2 create-subnet \
        --vpc-id ${VPC_ID} \
        --cidr-block 10.0.4.0/24 \
        --availability-zone ${AWS_REGION}b \
        --query "Subnet.SubnetId" --output text)
    aws ec2 create-tags \
        --resources ${PRIVATE_SUBNET_2} \
        --tags Key=Name,Value=flask-private-subnet-2
fi
echo "Private Subnet 2: ${PRIVATE_SUBNET_2}"

echo "Checking for existing Public Subnets..."
PUBLIC_SUBNET_1=$(aws ec2 describe-subnets \
    --region ${AWS_REGION} \
    --filters Name=tag:Name,Values=flask-public-subnet-1 \
    --query "Subnets[0].SubnetId" --output text)

if [ "$PUBLIC_SUBNET_1" == "None" ]; then
    echo "Creating Public Subnet 1..."
    PUBLIC_SUBNET_1=$(aws ec2 create-subnet \
        --vpc-id ${VPC_ID} \
        --cidr-block 10.0.1.0/24 \
        --availability-zone ${AWS_REGION}a \
        --query "Subnet.SubnetId" --output text)
    aws ec2 create-tags \
        --resources ${PUBLIC_SUBNET_1} \
        --tags Key=Name,Value=flask-public-subnet-1
fi
echo "Public Subnet 1: ${PUBLIC_SUBNET_1}"

PUBLIC_SUBNET_2=$(aws ec2 describe-subnets \
    --region ${AWS_REGION} \
    --filters Name=tag:Name,Values=flask-public-subnet-2 \
    --query "Subnets[0].SubnetId" --output text)

if [ "$PUBLIC_SUBNET_2" == "None" ]; then
    echo "Creating Public Subnet 2..."
    PUBLIC_SUBNET_2=$(aws ec2 create-subnet \
        --vpc-id ${VPC_ID} \
        --cidr-block 10.0.2.0/24 \
        --availability-zone ${AWS_REGION}b \
        --query "Subnet.SubnetId" --output text)
    aws ec2 create-tags \
        --resources ${PUBLIC_SUBNET_2} \
        --tags Key=Name,Value=flask-public-subnet-2
fi
echo "Public Subnet 2: ${PUBLIC_SUBNET_2}"

# 3. Internet Gateway
echo "Setting up Internet Gateway..."
IGW_ID=$(aws ec2 describe-internet-gateways \
    --filters Name=attachment.vpc-id,Values=${VPC_ID} \
    --query "InternetGateways[0].InternetGatewayId" --output text)

if [ "$IGW_ID" == "None" ]; then
    echo "Creating Internet Gateway..."
    IGW_ID=$(aws ec2 create-internet-gateway \
        --query "InternetGateway.InternetGatewayId" --output text)
    aws ec2 attach-internet-gateway \
        --internet-gateway-id ${IGW_ID} \
        --vpc-id ${VPC_ID}
    aws ec2 create-tags \
        --resources ${IGW_ID} \
        --tags Key=Name,Value=flask-internet-gateway
fi
echo "Internet Gateway ID: ${IGW_ID}"

# 4. Security Groups
echo "Checking for ALB Security Group..."
ALB_SG_ID=$(aws ec2 describe-security-groups \
    --filters Name=tag:Name,Values=flask-alb-sg \
    --query "SecurityGroups[0].GroupId" --output text)

if [ "$ALB_SG_ID" == "None" ]; then
    echo "Creating ALB Security Group..."
    ALB_SG_ID=$(aws ec2 create-security-group \
        --group-name flask-alb-sg \
        --description "ALB Security Group" \
        --vpc-id ${VPC_ID} \
        --query "GroupId" --output text)
    aws ec2 create-tags \
        --resources ${ALB_SG_ID} \
        --tags Key=Name,Value=flask-alb-sg
    aws ec2 authorize-security-group-ingress \
        --group-id ${ALB_SG_ID} \
        --protocol tcp \
        --port 80 \
        --cidr 0.0.0.0/0
fi
echo "ALB Security Group ID: ${ALB_SG_ID}"

echo "Checking for ECS Security Group..."
ECS_SG_ID=$(aws ec2 describe-security-groups \
    --filters Name=tag:Name,Values=flask-ecs-sg \
    --query "SecurityGroups[0].GroupId" --output text)

if [ "$ECS_SG_ID" == "None" ]; then
    echo "Creating ECS Security Group..."
    ECS_SG_ID=$(aws ec2 create-security-group \
        --group-name flask-ecs-sg \
        --description "ECS Security Group" \
        --vpc-id ${VPC_ID} \
        --query "GroupId" --output text)
    aws ec2 create-tags \
        --resources ${ECS_SG_ID} \
        --tags Key=Name,Value=flask-ecs-sg
    aws ec2 authorize-security-group-ingress \
        --group-id ${ECS_SG_ID} \
        --protocol tcp \
        --port 5000 \
        --source-group ${ALB_SG_ID}
fi
echo "ECS Security Group ID: ${ECS_SG_ID}"

# 5. ALB and Target Group
echo "Checking for ALB..."
ALB_ARN=$(aws elbv2 describe-load-balancers \
    --names ${ALB_NAME} \
    --query "LoadBalancers[0].LoadBalancerArn" \
    --output text 2>/dev/null || echo "None")

if [ "$ALB_ARN" == "None" ]; then
    echo "ALB does not exist. Creating ALB..."
    ALB_ARN=$(aws elbv2 create-load-balancer \
        --name ${ALB_NAME} \
        --subnets ${PUBLIC_SUBNET_1} ${PUBLIC_SUBNET_2} \
        --security-groups ${ALB_SG_ID} \
        --scheme internet-facing \
        --type application \
        --query "LoadBalancers[0].LoadBalancerArn" \
        --output text)
    echo "ALB created: ${ALB_ARN}"
else
    echo "ALB already exists: ${ALB_ARN}"
fi

echo "Checking for Target Group..."
TARGET_GROUP_ARN=$(aws elbv2 describe-target-groups \
    --names ${TARGET_GROUP_NAME} \
    --query "TargetGroups[0].TargetGroupArn" \
    --output text 2>/dev/null || echo "None")

if [ "$TARGET_GROUP_ARN" == "None" ]; then
    echo "Target Group does not exist. Creating Target Group..."
    TARGET_GROUP_ARN=$(aws elbv2 create-target-group \
        --name ${TARGET_GROUP_NAME} \
        --protocol HTTP \
        --port 5000 \
        --vpc-id ${VPC_ID} \
        --target-type ip \
        --query "TargetGroups[0].TargetGroupArn" \
        --output text)
    echo "Target Group created: ${TARGET_GROUP_ARN}"
else
    echo "Target Group already exists: ${TARGET_GROUP_ARN}"
fi

echo "Checking for Listener..."
LISTENER_ARN=$(aws elbv2 describe-listeners \
    --load-balancer-arn ${ALB_ARN} \
    --query "Listeners[0].ListenerArn" \
    --output text 2>/dev/null || echo "None")

if [ "$LISTENER_ARN" == "None" ]; then
    echo "Creating Listener for ALB..."
    LISTENER_ARN=$(aws elbv2 create-listener \
        --load-balancer-arn ${ALB_ARN} \
        --protocol HTTP \
        --port 80 \
        --default-actions Type=forward,TargetGroupArn=${TARGET_GROUP_ARN} \
        --query "Listeners[0].ListenerArn" \
        --output text)
    echo "Listener created: ${LISTENER_ARN}"
else
    echo "Listener already exists: ${LISTENER_ARN}"
fi

# 6. Create ECS Cluster
echo "Checking for ECS Cluster..."
CLUSTER_STATUS=$(aws ecs describe-clusters \
    --clusters ${CLUSTER_NAME} \
    --query "clusters[?status=='ACTIVE'].status" \
    --output text)

if [ "$CLUSTER_STATUS" == "" ]; then
    echo "Creating ECS Cluster..."
    aws ecs create-cluster --cluster-name ${CLUSTER_NAME}
    echo "ECS Cluster created: ${CLUSTER_NAME}"
else
    echo "ECS Cluster already exists and is ACTIVE."
fi

# 7. Register Task Definition
echo "Registering Task Definition..."
TASK_DEFINITION_ARN=$(aws ecs register-task-definition \
    --family ${TASK_FAMILY} \
    --network-mode awsvpc \
    --requires-compatibilities FARGATE \
    --cpu "512" \
    --memory "1024" \
    --execution-role-arn ${EXECUTION_ROLE_ARN} \
    --task-role-arn ${TASK_ROLE_ARN} \
    --container-definitions "[
        {
            \"name\": \"flask-container\",
            \"image\": \"${IMAGE_URL}\",
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
                    \"awslogs-group\": \"${LOG_GROUP_NAME}\",
                    \"awslogs-region\": \"${AWS_REGION}\",
                    \"awslogs-stream-prefix\": \"ecs\"
                }
            }
        }
    ]" \
    --query "taskDefinition.taskDefinitionArn" --output text)

echo "Task Definition ARN: ${TASK_DEFINITION_ARN}"

# 8. Create ECS Service
echo "Creating ECS Service..."
SERVICE_ARN=$(aws ecs create-service \
    --cluster ${CLUSTER_NAME} \
    --service-name ${SERVICE_NAME} \
    --task-definition ${TASK_DEFINITION_ARN} \
    --desired-count 1 \
    --launch-type FARGATE \
    --network-configuration "awsvpcConfiguration={subnets=[${PRIVATE_SUBNET_1},${PRIVATE_SUBNET_2}],securityGroups=[${ECS_SG_ID}],assignPublicIp=ENABLED}" \
    --load-balancers "targetGroupArn=${TARGET_GROUP_ARN},containerName=flask-container,containerPort=5000" \
    --query "service.serviceArn" \
    --output text)

echo "ECS Service created: ${SERVICE_ARN}"

# Final Summary
echo "Final Summary:"
echo "VPC ID: ${VPC_ID}"
echo "Subnets: ${PUBLIC_SUBNET_1}, ${PUBLIC_SUBNET_2}, ${PRIVATE_SUBNET_1}, ${PRIVATE_SUBNET_2}"
echo "Internet Gateway ID: ${IGW_ID}"
echo "Security Groups: ALB=${ALB_SG_ID}, ECS=${ECS_SG_ID}"
echo "ALB ARN: ${ALB_ARN}"
echo "Target Group ARN: ${TARGET_GROUP_ARN}"
echo "Listener ARN: ${LISTENER_ARN}"
echo "ECS Cluster: ${CLUSTER_NAME}"
echo "Task Definition ARN: ${TASK_DEFINITION_ARN}"
echo "ECS Service ARN: ${SERVICE_ARN}"