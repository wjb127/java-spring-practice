# 멀티 스테이지 빌드를 사용하여 효율적인 이미지 생성
FROM maven:3.9.6-eclipse-temurin-17 AS builder

# 작업 디렉토리 설정
WORKDIR /app

# Maven 의존성 캐싱을 위해 pom.xml을 먼저 복사
COPY pom.xml .

# 의존성 다운로드 (캐시 활용)
RUN mvn dependency:go-offline -B

# 소스 코드 복사
COPY src ./src

# 애플리케이션 빌드
RUN mvn clean package -DskipTests

# 실행 환경
FROM eclipse-temurin:17-jdk-slim

# 작업 디렉토리 설정
WORKDIR /app

# Maven 설치 (Jetty 플러그인 실행용)
RUN apt-get update && \
    apt-get install -y maven && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 빌드된 프로젝트 전체 복사 (Jetty 플러그인 실행을 위해)
COPY --from=builder /app /app

# 포트 노출
EXPOSE 8080

# 애플리케이션 실행
CMD ["mvn", "jetty:run"] 