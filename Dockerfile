# Ubuntu 기반 Java 17 이미지 사용
FROM ubuntu:22.04

# 시간대 설정 (interactive 모드 방지)
ENV DEBIAN_FRONTEND=noninteractive

# 작업 디렉토리 설정
WORKDIR /app

# Java 17 및 Maven 설치
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk maven && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 프로젝트 복사
COPY . .

# Java 환경변수를 찾아서 설정하고 Maven 실행
RUN export JAVA_HOME=$(find /usr/lib/jvm -name "java-17-openjdk-*" -type d | head -1) && \
    echo "JAVA_HOME is: $JAVA_HOME" && \
    mvn dependency:go-offline -B

RUN export JAVA_HOME=$(find /usr/lib/jvm -name "java-17-openjdk-*" -type d | head -1) && \
    mvn clean package -DskipTests

# PostgreSQL 환경변수 기본값 설정
ENV DB_DRIVER=org.postgresql.Driver
ENV DB_URL=jdbc:postgresql://localhost:5432/demo_db
ENV DB_USERNAME=postgres
ENV DB_PASSWORD=password
ENV DB_VALIDATION_QUERY="SELECT 1"

# Render PostgreSQL 감지 및 자동 설정 스크립트
RUN echo '#!/bin/bash\n\
echo "🚀 애플리케이션 시작..."\n\
\n\
# DATABASE_URL이 있으면 PostgreSQL 설정으로 변경\n\
if [ -n "$DATABASE_URL" ]; then\n\
  echo "🔄 Render DATABASE_URL 감지: $DATABASE_URL"\n\
  \n\
  # PostgreSQL 환경변수 강제 설정\n\
  export DB_DRIVER="org.postgresql.Driver"\n\
  export DB_URL="$DATABASE_URL"\n\
  export DB_USERNAME="spring_user"\n\
  export DB_PASSWORD="$(echo $DATABASE_URL | sed -n '"'"'s/.*:\([^@]*\)@.*/\1/p'"'"')"\n\
  export DB_VALIDATION_QUERY="SELECT 1"\n\
  \n\
  echo "✅ PostgreSQL 설정 완료:"\n\
  echo "   - Driver: $DB_DRIVER"\n\
  echo "   - URL: $DB_URL"\n\
  echo "   - User: $DB_USERNAME"\n\
else\n\
  echo "📦 로컬 MySQL 설정 사용"\n\
fi\n\
\n\
# Java 실행\n\
export JAVA_HOME=$(find /usr/lib/jvm -name "java-17-openjdk-*" -type d | head -1)\n\
echo "☕ JAVA_HOME: $JAVA_HOME"\n\
\n\
exec "$@"' > /app/entrypoint.sh && chmod +x /app/entrypoint.sh

# 포트 노출
EXPOSE 8080

# Entrypoint 설정
ENTRYPOINT ["/app/entrypoint.sh"]

# WAR 파일 실행 (Jetty 내장)
CMD export JAVA_HOME=$(find /usr/lib/jvm -name "java-17-openjdk-*" -type d | head -1) && \
    echo "🚀 Starting Spring Boot Application with PostgreSQL..." && \
    echo "📊 Database: $DB_URL" && \
    java -jar target/spring-mybatis-demo.war 