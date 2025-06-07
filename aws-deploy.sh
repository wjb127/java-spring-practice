#!/bin/bash

echo "🚀 AWS ECS 배포 스크립트"
echo "======================"

# 환경 변수 설정
AWS_REGION="us-east-1"
CLUSTER_NAME="spring-app-cluster"
SERVICE_NAME="spring-app-service"
TASK_DEFINITION="spring-app-task"

echo "📦 Docker 이미지 ECR에 푸시..."
# ECR 로그인
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin <AWS_ACCOUNT_ID>.dkr.ecr.$AWS_REGION.amazonaws.com

# 이미지 태그 및 푸시
docker tag spring-mybatis-app:latest <AWS_ACCOUNT_ID>.dkr.ecr.$AWS_REGION.amazonaws.com/spring-mybatis-app:latest
docker push <AWS_ACCOUNT_ID>.dkr.ecr.$AWS_REGION.amazonaws.com/spring-mybatis-app:latest

echo "🎯 ECS 클러스터 생성..."
aws ecs create-cluster --cluster-name $CLUSTER_NAME

echo "📋 태스크 정의 등록..."
aws ecs register-task-definition --cli-input-json file://task-definition.json

echo "🚀 서비스 생성..."
aws ecs create-service \
    --cluster $CLUSTER_NAME \
    --service-name $SERVICE_NAME \
    --task-definition $TASK_DEFINITION \
    --desired-count 1

echo "✅ 배포 완료!"
echo "ECS 콘솔에서 서비스 상태를 확인하세요." 