#!/bin/bash

echo "🐳 Docker Hub 배포 스크립트"
echo "=========================="

# Docker Hub 사용자명 (실제 사용시 변경 필요)
DOCKER_USERNAME="wjb127"
IMAGE_NAME="spring-mybatis-mysql-app"
VERSION="latest"

echo "📦 Docker 이미지 빌드 중..."
docker build -t $DOCKER_USERNAME/$IMAGE_NAME:$VERSION .

echo "🔐 Docker Hub 로그인 필요..."
echo "docker login 명령어를 실행하세요"

echo "📤 이미지 푸시를 위한 명령어:"
echo "docker push $DOCKER_USERNAME/$IMAGE_NAME:$VERSION"

echo ""
echo "🌍 다른 환경에서 실행하는 방법:"
echo "docker pull $DOCKER_USERNAME/$IMAGE_NAME:$VERSION"
echo "docker run -p 8080:8080 $DOCKER_USERNAME/$IMAGE_NAME:$VERSION"

echo ""
echo "💡 또는 GitHub에서 직접 실행:"
echo "git clone https://github.com/wjb127/java-spring-practice.git"
echo "cd java-spring-practice"
echo "docker-compose up --build" 