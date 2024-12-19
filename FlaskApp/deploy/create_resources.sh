#!/bin/bash

# Variables
AWS_REGION="us-east-1"                          # Update this to your preferred region
CLUSTER_NAME="flask-ecs-cluster"
TASK_FAMILY="flask-ecs-task"
SERVICE_NAME="flask-ecs-service"
IMAGE_URL="072298625118.dkr.ecr.us-east-1.amazonaws.com/flask-ecs-app:latest"  # Replace with your ECR image URL
ALB_NAME="flask-app-alb"
TARGET_GROUP_NAME="flask-ecs-target-group"
SECURITY_GROUP_NAME="flask-ecs-sg"
IAM_EXECUTION_ROLE_NAME="stock_predictor_execution_role"
IAM_TASK_ROLE_NAME="stock_predictor_task_role"
IAM_POLICY_ARN="arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
S3_BUCKET_NAME="capstone-stock-predictable-project"
LOG_GROUP_NAME="/ecs/flask-app"

# 1. Check and Create VPC
echo "Checking for existing VPC..."
VPC_ID=$(aws ec2 describe-vpcs --region ${AWS_REGION} --filters Name=tag:Name,Values=flask-ecs-vpc --query "Vpcs[0].VpcId" --output text)
if [ "$VPC_ID" == "None" ]; then
    echo "Creating VPC..."
    VPC_ID=$(aws ec2 create-vpc --cidr-block 10.0.0.0/16 --region ${AWS_REGION} --query "Vpc.VpcId" --output text)
    aws ec2 create-tags --resources ${VPC_ID} --tags Key=Name,Value=flask-ecs-vpc
fi
echo "VPC ID: ${VPC_ID}"

# 2. Create Public Subnets
# 3. Create Private Subnets
echo "Checking for existing Private Subnets..."

PRIVATE_SUBNET_1=$(aws ec2 describe-subnets \
    --region ${AWS_REGION} \
    --filters "Name=tag:Name,Values=flask-private-subnet-1" \
    --query "Subnets[0].SubnetId" --output text)

if [ "$PRIVATE_SUBNET_1" == "None" ]; then
    echo "Creating Private Subnet 1 in ${AWS_REGION}a..."
    PRIVATE_SUBNET_1=$(aws ec2 create-subnet \
        --vpc-id ${VPC_ID} \
        --cidr-block 10.0.3.0/24 \
        --availability-zone ${AWS_REGION}a \
        --query "Subnet.SubnetId" --output text)
    aws ec2 create-tags --resources ${PRIVATE_SUBNET_1} --tags Key=Name,Value=flask-private-subnet-1
fi

PRIVATE_SUBNET_2=$(aws ec2 describe-subnets \
    --region ${AWS_REGION} \
    --filters "Name=tag:Name,Values=flask-private-subnet-2" \
    --query "Subnets[0].SubnetId" --output text)

if [ "$PRIVATE_SUBNET_2" == "None" ]; then
    echo "Creating Private Subnet 2 in ${AWS_REGION}b..."
    PRIVATE_SUBNET_2=$(aws ec2 create-subnet \
        --vpc-id ${VPC_ID} \
        --cidr-block 10.0.4.0/24 \
        --availability-zone ${AWS_REGION}b \
        --query "Subnet.SubnetId" --output text)
    aws ec2 create-tags --resources ${PRIVATE_SUBNET_2} --tags Key=Name,Value=flask-private-subnet-2
fi
echo "Private Subnets: ${PRIVATE_SUBNET_1}, ${PRIVATE_SUBNET_2}"

echo "Checking for existing Subnets..."
SUBNET_1=$(aws ec2 describe-subnets \
    --region ${AWS_REGION} \
    --filters "Name=tag:Name,Values=flask-public-subnet-1" \
    --query "Subnets[0].SubnetId" --output text)

if [ "$SUBNET_1" == "None" ]; then
    echo "Creating Subnet 1 in ${AWS_REGION}a..."
    SUBNET_1=$(aws ec2 create-subnet \
        --vpc-id ${VPC_ID} \
        --cidr-block 10.0.1.0/24 \
        --availability-zone ${AWS_REGION}a \
        --query "Subnet.SubnetId" --output text)
    aws ec2 create-tags --resources ${SUBNET_1} --tags Key=Name,Value=flask-public-subnet-1
fi

SUBNET_2=$(aws ec2 describe-subnets \
    --region ${AWS_REGION} \
    --filters "Name=tag:Name,Values=flask-public-subnet-2" \
    --query "Subnets[0].SubnetId" --output text)

if [ "$SUBNET_2" == "None" ]; then
    echo "Creating Subnet 2 in ${AWS_REGION}b..."
    SUBNET_2=$(aws ec2 create-subnet \
        --vpc-id ${VPC_ID} \
        --cidr-block 10.0.2.0/24 \
        --availability-zone ${AWS_REGION}b \
        --query "Subnet.SubnetId" --output text)
    aws ec2 create-tags --resources ${SUBNET_2} --tags Key=Name,Value=flask-public-subnet-2
fi
echo "Public Subnets: ${SUBNET_1}, ${SUBNET_2}"

# 3. Internet Gateway Setup for ALB
echo "Setting up Internet Gateway..."

# Check for an existing Internet Gateway
IGW_ID=$(aws ec2 describe-internet-gateways \
    --filters Name=attachment.vpc-id,Values=${VPC_ID} \
    --query "InternetGateways[0].InternetGatewayId" --output text)

if [ "$IGW_ID" == "None" ]; then
    echo "Creating Internet Gateway..."
    IGW_ID=$(aws ec2 create-internet-gateway --query "InternetGateway.InternetGatewayId" --output text)
    aws ec2 attach-internet-gateway --internet-gateway-id ${IGW_ID} --vpc-id ${VPC_ID}
    aws ec2 create-tags --resources ${IGW_ID} --tags Key=Name,Value=flask-internet-gateway
else
    echo "Internet Gateway already exists: ${IGW_ID}"
fi

# Check for an existing Route Table for public subnets
ROUTE_TABLE_ID=$(aws ec2 describe-route-tables \
    --filters "Name=vpc-id,Values=${VPC_ID}" "Name=tag:Name,Values=flask-public-route-table" \
    --query "RouteTables[0].RouteTableId" --output text)

if [ "$ROUTE_TABLE_ID" == "None" ]; then
    echo "Creating Route Table for public subnets..."
    ROUTE_TABLE_ID=$(aws ec2 create-route-table --vpc-id ${VPC_ID} --query "RouteTable.RouteTableId" --output text)
    aws ec2 create-tags --resources ${ROUTE_TABLE_ID} --tags Key=Name,Value=flask-public-route-table

    # Create a route to the Internet Gateway
    aws ec2 create-route --route-table-id ${ROUTE_TABLE_ID} --destination-cidr-block 0.0.0.0/0 --gateway-id ${IGW_ID}
else
    echo "Route Table already exists: ${ROUTE_TABLE_ID}"
fi

# Associate the Route Table with the Public Subnets
echo "Associating Route Table with Public Subnets..."
aws ec2 associate-route-table --route-table-id ${ROUTE_TABLE_ID} --subnet-id ${SUBNET_1} > /dev/null
aws ec2 associate-route-table --route-table-id ${ROUTE_TABLE_ID} --subnet-id ${SUBNET_2} > /dev/null

echo "Internet Gateway and Route Table setup completed successfully."

# 4. NAT Gateway Setup for Private Subnets
echo "Setting up NAT Gateway..."

# Check if NAT Gateway already exists
NAT_GATEWAY_ID=$(aws ec2 describe-nat-gateways \
    --filter Name=vpc-id,Values=${VPC_ID} Name=state,Values=available \
    --query "NatGateways[0].NatGatewayId" --output text)

if [ "$NAT_GATEWAY_ID" == "None" ]; then
    echo "Creating NAT Gateway..."
    # Allocate an Elastic IP
    EIP_ALLOC_ID=$(aws ec2 allocate-address --domain vpc --query "AllocationId" --output text)

    if [ -z "$EIP_ALLOC_ID" ]; then
        echo "Failed to allocate Elastic IP for NAT Gateway. Exiting."
        exit 1
    fi

    # Create NAT Gateway in the public subnet
    NAT_GATEWAY_ID=$(aws ec2 create-nat-gateway \
        --subnet-id ${SUBNET_1} \
        --allocation-id ${EIP_ALLOC_ID} \
        --query "NatGateway.NatGatewayId" --output text)

    if [ -z "$NAT_GATEWAY_ID" ]; then
        echo "Failed to create NAT Gateway. Exiting."
        exit 1
    fi

    aws ec2 create-tags --resources ${NAT_GATEWAY_ID} --tags Key=Name,Value=flask-nat-gateway

    echo "Waiting for NAT Gateway to be available..."
    aws ec2 wait nat-gateway-available --nat-gateway-ids ${NAT_GATEWAY_ID}
else
    echo "NAT Gateway already exists: ${NAT_GATEWAY_ID}"
fi

# Create or update the Route Table for private subnets
PRIVATE_ROUTE_TABLE_ID=$(aws ec2 describe-route-tables \
    --filters "Name=vpc-id,Values=${VPC_ID}" "Name=tag:Name,Values=flask-private-route-table" \
    --query "RouteTables[0].RouteTableId" --output text)

if [ "$PRIVATE_ROUTE_TABLE_ID" == "None" ]; then
    echo "Creating Route Table for private subnets..."
    PRIVATE_ROUTE_TABLE_ID=$(aws ec2 create-route-table --vpc-id ${VPC_ID} --query "RouteTable.RouteTableId" --output text)
    aws ec2 create-tags --resources ${PRIVATE_ROUTE_TABLE_ID} --tags Key=Name,Value=flask-private-route-table

    # Add a route to the NAT Gateway
    aws ec2 create-route --route-table-id ${PRIVATE_ROUTE_TABLE_ID} --destination-cidr-block 0.0.0.0/0 --nat-gateway-id ${NAT_GATEWAY_ID}
else
    echo "Private Route Table already exists: ${PRIVATE_ROUTE_TABLE_ID}"
fi

# Associate the Route Table with the Private Subnets
echo "Associating Route Table with Private Subnets..."
aws ec2 associate-route-table --route-table-id ${PRIVATE_ROUTE_TABLE_ID} --subnet-id ${PRIVATE_SUBNET_1} > /dev/null
aws ec2 associate-route-table --route-table-id ${PRIVATE_ROUTE_TABLE_ID} --subnet-id ${PRIVATE_SUBNET_2} > /dev/null

echo "NAT Gateway and Private Route Table setup completed successfully."

# Create Security Groups for ALB and ECS Tasks
echo "Checking for existing Security Groups..."

# ALB Security Group
ALB_SG_ID=$(aws ec2 describe-security-groups \
    --filters Name=tag:Name,Values=flask-alb-sg \
    --query "SecurityGroups[0].GroupId" --output text)

if [ "$ALB_SG_ID" == "None" ]; then
    echo "Creating ALB Security Group..."
    ALB_SG_ID=$(aws ec2 create-security-group \
        --group-name flask-alb-sg \
        --description "Security Group for ALB" \
        --vpc-id ${VPC_ID} \
        --query "GroupId" --output text)
    aws ec2 create-tags --resources ${ALB_SG_ID} --tags Key=Name,Value=flask-alb-sg
    # Allow HTTP/HTTPS traffic from the internet
    aws ec2 authorize-security-group-ingress \
        --group-id ${ALB_SG_ID} \
        --protocol tcp --port 80 --cidr 0.0.0.0/0
    aws ec2 authorize-security-group-ingress \
        --group-id ${ALB_SG_ID} \
        --protocol tcp --port 443 --cidr 0.0.0.0/0
fi
echo "ALB Security Group: ${ALB_SG_ID}"

# ECS Task Security Group
ECS_SG_ID=$(aws ec2 describe-security-groups \
    --filters Name=tag:Name,Values=flask-ecs-sg \
    --query "SecurityGroups[0].GroupId" --output text)

if [ "$ECS_SG_ID" == "None" ]; then
    echo "Creating ECS Task Security Group..."
    ECS_SG_ID=$(aws ec2 create-security-group \
        --group-name flask-ecs-sg \
        --description "Security Group for ECS Tasks" \
        --vpc-id ${VPC_ID} \
        --query "GroupId" --output text)
    aws ec2 create-tags --resources ${ECS_SG_ID} --tags Key=Name,Value=flask-ecs-sg
    # Allow traffic from ALB
    aws ec2 authorize-security-group-ingress \
        --group-id ${ECS_SG_ID} \
        --protocol tcp --port 5000 --source-group ${ALB_SG_ID}
fi
echo "ECS Security Group: ${ECS_SG_ID}"

# Create ALB and Attach Security Group
echo "Checking for ALB..."
ALB_ARN=$(aws elbv2 describe-load-balancers --names ${ALB_NAME} --query "LoadBalancers[0].LoadBalancerArn" --output text 2>/dev/null)

if [ -z "$ALB_ARN" ] || [ "$ALB_ARN" == "None" ]; then
    echo "Creating ALB..."
    ALB_ARN=$(aws elbv2 create-load-balancer \
        --name ${ALB_NAME} \
        --subnets ${SUBNET_1} ${SUBNET_2} \
        --security-groups ${ALB_SG_ID} \  # Attach ALB security group directly
        --scheme internet-facing \
        --type application \
        --query "LoadBalancers[0].LoadBalancerArn" --output text)
    echo "ALB created: ${ALB_ARN}"
else
    echo "ALB already exists: ${ALB_ARN}"
fi
# # At this point, ALB and ECS security groups are ready!

# 6. Create or Check IAM Role for ECS Task Execution
echo "Checking for existing IAM Role..."echo "Checking for Execution Role..."
EXECUTION_ROLE_ARN=$(aws iam get-role --role-name ${IAM_EXECUTION_ROLE_NAME} --query "Role.Arn" --output text 2>/dev/null)

if [ -z "$EXECUTION_ROLE_ARN" ]; then
    echo "Creating Execution Role ${IAM_EXECUTION_ROLE_NAME}..."
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
        }' --query "Role.Arn" --output text)

    # Attach ECR, CloudWatch permissions to the execution role
    aws iam attach-role-policy \
        --role-name ${IAM_EXECUTION_ROLE_NAME} \
        --policy-arn arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy
fi
echo "Execution Role ARN: ${EXECUTION_ROLE_ARN}"

echo "Checking for Task Role..."
TASK_ROLE_ARN=$(aws iam get-role --role-name ${IAM_TASK_ROLE_NAME} --query "Role.Arn" --output text 2>/dev/null)

if [ -z "$TASK_ROLE_ARN" ]; then
    echo "Creating Task Role ${IAM_TASK_ROLE_NAME}..."
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
        }' --query "Role.Arn" --output text)

    # Attach S3 read-only permissions to the task role
    aws iam put-role-policy \
        --role-name ${IAM_TASK_ROLE_NAME} \
        --policy-name "S3ReadAccessPolicy" \
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
                        \"arn:aws:s3:::${S3_BUCKET_NAME}\",
                        \"arn:aws:s3:::${S3_BUCKET_NAME}/*\"
                    ]
                }
            ]
        }"
fi
echo "Task Role ARN: ${TASK_ROLE_ARN}"

# Ensure the CloudWatch log group exists
echo "Checking for CloudWatch log group..."
LOG_GROUP_EXISTS=$(aws logs describe-log-groups --log-group-name-prefix "${LOG_GROUP_NAME}" --region "${AWS_REGION}" --query "logGroups[?logGroupName=='${LOG_GROUP_NAME}'] | [0]" --output text)

if [ "$LOG_GROUP_EXISTS" == "None" ] || [ -z "$LOG_GROUP_EXISTS" ]; then
    echo "Creating CloudWatch log group: ${LOG_GROUP_NAME}..."
    aws logs create-log-group --log-group-name "${LOG_GROUP_NAME}" --region "${AWS_REGION}"
else
    echo "CloudWatch log group already exists: ${LOG_GROUP_NAME}"
fi

# 7. Register ECS Task Definition
echo "Registering ECS Task Definition..."
aws ecs register-task-definition \
  --family ${TASK_FAMILY} \
  --execution-role-arn ${EXECUTION_ROLE_ARN} \
  --task-role-arn ${TASK_ROLE_ARN} \
  --network-mode awsvpc \
  --requires-compatibilities FARGATE \
  --cpu "512" \
  --memory "1024" \
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
  --query "taskDefinition.taskDefinitionArn" \
  --output text

echo "Task Definition registered successfully."

#echo "Checking for Target Group..."
TARGET_GROUP_ARN=$(aws elbv2 describe-target-groups --names ${TARGET_GROUP_NAME} --query "TargetGroups[0].TargetGroupArn" --output text 2>/dev/null)

if [ -z "$TARGET_GROUP_ARN" ] || [ "$TARGET_GROUP_ARN" == "None" ]; then
    echo "Creating Target Group..."
    TARGET_GROUP_ARN=$(aws elbv2 create-target-group \
      --name ${TARGET_GROUP_NAME} \
      --protocol HTTP \
      --port 5000 \
      --vpc-id ${VPC_ID} \
      --target-type ip \
      --query "TargetGroups[0].TargetGroupArn" --output text)
    echo "Target Group created: ${TARGET_GROUP_ARN}"
else
    echo "Target Group already exists: ${TARGET_GROUP_ARN}"
fi

echo "Checking for Listener..."
LISTENER_ARN=$(aws elbv2 describe-listeners \
    --load-balancer-arn ${ALB_ARN} \
    --query "Listeners[0].ListenerArn" --output text 2>/dev/null)

if [ -z "$LISTENER_ARN" ] || [ "$LISTENER_ARN" == "None" ]; then
    echo "Creating Listener..."
    aws elbv2 create-listener \
      --load-balancer-arn ${ALB_ARN} \
      --protocol HTTP \
      --port 80 \
      --default-actions Type=forward,TargetGroupArn=${TARGET_GROUP_ARN}
    echo "Listener created."
else
    echo "Listener already exists: ${LISTENER_ARN}"
fi

CLUSTER_STATUS=$(aws ecs describe-clusters --clusters ${CLUSTER_NAME} --query "clusters[?status=='ACTIVE'].status" --output text 2>/dev/null)

if [ -z "$CLUSTER_STATUS" ]; then
    echo "Creating ECS Cluster..."
    aws ecs create-cluster --cluster-name ${CLUSTER_NAME}
    echo "ECS Cluster created: ${CLUSTER_NAME}"
else
    echo "ECS Cluster already exists and is ACTIVE."
fi

# Ensure ECS Service-Linked Role Exists
echo "Checking for ECS Service-Linked Role..."
SLR_STATUS=$(aws iam get-role --role-name AWSServiceRoleForECS --query "Role.RoleName" --output text 2>/dev/null)

if [ -z "$SLR_STATUS" ] || [ "$SLR_STATUS" == "None" ]; then
    echo "Creating ECS Service-Linked Role..."
    aws iam create-service-linked-role --aws-service-name ecs.amazonaws.com
    echo "ECS Service-Linked Role created successfully."
else
    echo "ECS Service-Linked Role already exists: ${SLR_STATUS}"
fi

echo "Checking for ECS Service..."
SERVICE_ARN=$(aws ecs describe-services --cluster ${CLUSTER_NAME} --services ${SERVICE_NAME} --query "services[0].serviceArn" --output text 2>/dev/null)

if [ -z "$SERVICE_ARN" ] || [ "$SERVICE_ARN" == "None" ]; then
    echo "Creating ECS Service..."
    aws ecs create-service \
      --cluster ${CLUSTER_NAME} \
      --service-name ${SERVICE_NAME} \
      --task-definition ${TASK_FAMILY} \
      --desired-count 1 \
      --launch-type FARGATE \
      --network-configuration "awsvpcConfiguration={subnets=[${PRIVATE_SUBNET_1},${PRIVATE_SUBNET_2}],securityGroups=[${ECS_SG}],assignPublicIp=ENABLED}" \
      --load-balancers "targetGroupArn=${TARGET_GROUP_ARN},containerName=flask-container,containerPort=5000"
    echo "ECS Service created successfully."
else
    echo "ECS Service already exists: ${SERVICE_ARN}"
fi

echo "Waiting for ECS Service to stabilize..."
    aws ecs wait services-stable \
    --cluster ${CLUSTER_NAME} \
    --services ${SERVICE_NAME}
    echo "ECS Service is now stable."  