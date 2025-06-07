#!/bin/bash

# Docker Compose 기반 배포 스크립트들
# 진짜 백엔드 배포의 꽃! 🌸

echo "🚀 Docker Compose 기반 배포 스크립트"
echo "====================================="

# 1. 로컬 테스트
deploy_local() {
    echo "📦 로컬 환경에서 테스트 배포..."
    cp .env.example .env
    docker-compose -f docker-compose.production.yml up --build -d
    echo "✅ http://localhost:8080 에서 확인하세요!"
}

# 2. Azure Container Instances
deploy_azure() {
    echo "☁️ Azure Container Instances 배포..."
    # Azure CLI 로그인 확인
    az account show > /dev/null || az login
    
    # 리소스 그룹 생성
    az group create --name spring-mybatis-rg --location koreacentral
    
    # Docker Compose로 배포 (진짜 한 줄!)
    az container create \
        --resource-group spring-mybatis-rg \
        --file azure-container-instances.yml \
        --name spring-mybatis-app
    
    echo "✅ Azure에서 배포 완료!"
}

# 3. AWS ECS
deploy_aws() {
    echo "☁️ AWS ECS 배포..."
    # Docker Compose ECS 컨텍스트 생성
    docker context create ecs aws-context --from-env
    docker context use aws-context
    
    # Docker Compose 그대로 배포!
    docker compose -f docker-compose.production.yml up
    echo "✅ AWS ECS에서 배포 완료!"
}

# 4. DigitalOcean
deploy_digitalocean() {
    echo "🌊 DigitalOcean 배포..."
    # doctl 설정 확인
    doctl account get > /dev/null || echo "doctl auth init을 먼저 실행하세요"
    
    # App Platform 배포
    doctl apps create --spec .do/app.yaml
    echo "✅ DigitalOcean에서 배포 완료!"
}

# 5. 임의의 VPS (Ubuntu)
deploy_vps() {
    echo "🖥️ VPS 배포 (Docker Swarm)..."
    echo "VPS 서버에서 다음 명령어들을 실행하세요:"
    echo ""
    echo "# Docker 설치"
    echo "curl -fsSL https://get.docker.com | sh"
    echo "sudo usermod -aG docker \$USER"
    echo ""
    echo "# 프로젝트 클론"
    echo "git clone https://github.com/wjb127/java-spring-practice.git"
    echo "cd java-spring-practice"
    echo ""
    echo "# 환경변수 설정"
    echo "cp .env.example .env"
    echo "nano .env  # 패스워드 수정"
    echo ""
    echo "# Docker Swarm 배포"
    echo "docker swarm init"
    echo "docker stack deploy -c docker-compose.production.yml spring-app"
    echo ""
    echo "✅ 어떤 VPS에서든 동일하게 동작합니다!"
}

# 메뉴
case "$1" in
    "local")
        deploy_local
        ;;
    "azure")
        deploy_azure
        ;;
    "aws")
        deploy_aws
        ;;
    "digitalocean")
        deploy_digitalocean
        ;;
    "vps")
        deploy_vps
        ;;
    *)
        echo "사용법: $0 [local|azure|aws|digitalocean|vps]"
        echo ""
        echo "🔥 백엔드 배포의 꽃, Docker Compose!"
        echo "어느 플랫폼에서든 똑같이 배포됩니다 ✨"
        ;;
esac 