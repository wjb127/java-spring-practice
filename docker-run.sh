#!/bin/bash

echo "🐳 Spring MVC + MyBatis + PostgreSQL Docker 실행"
echo "====================================="

# Docker Compose 실행
echo "📦 Docker 컨테이너 시작 중..."
docker-compose up -d

echo "⏳ PostgreSQL 데이터베이스 초기화 대기 중..."
sleep 10

echo "✅ 서비스가 시작되었습니다!"
echo ""
echo "🌐 접속 정보:"
echo "   - 애플리케이션: http://localhost:8080"
echo "   - 사용자 관리: http://localhost:8080/users"
echo "   - REST API: http://localhost:8080/api/users"
echo "   - PostgreSQL: localhost:5432 (postgres/password)"
echo ""
echo "📋 유용한 명령어:"
echo "   - 로그 보기: docker-compose logs -f"
echo "   - 서비스 중지: docker-compose down"
echo "   - 모든 데이터 삭제: docker-compose down -v"
echo ""

# 로그 스트림 시작
echo "📄 실시간 로그 (Ctrl+C로 종료):"
docker-compose logs -f 