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

# Entrypoint 스크립트 생성 (Render DATABASE_URL 파싱)
RUN echo '#!/bin/bash\n\
if [ -n "$DATABASE_URL" ]; then\n\
  echo "🔄 DATABASE_URL 감지됨: $DATABASE_URL"\n\
  \n\
  # PostgreSQL URL 파싱: postgresql://user:pass@host:port/dbname\n\
  export DB_DRIVER="org.postgresql.Driver"\n\
  export DB_URL="jdbc:$DATABASE_URL"\n\
  \n\
  # URL에서 개별 정보 파싱\n\
  PARSED_URL=$(echo $DATABASE_URL | sed "s/postgresql:\\/\\///g")\n\
  USER_PASS=$(echo $PARSED_URL | cut -d"@" -f1)\n\
  HOST_PORT_DB=$(echo $PARSED_URL | cut -d"@" -f2)\n\
  \n\
  export DB_USERNAME=$(echo $USER_PASS | cut -d":" -f1)\n\
  export DB_PASSWORD=$(echo $USER_PASS | cut -d":" -f2)\n\
  \n\
  HOST_PORT=$(echo $HOST_PORT_DB | cut -d"/" -f1)\n\
  export DB_HOST=$(echo $HOST_PORT | cut -d":" -f1)\n\
  export DB_PORT=$(echo $HOST_PORT | cut -d":" -f2)\n\
  export DB_NAME=$(echo $HOST_PORT_DB | cut -d"/" -f2)\n\
  \n\
  export DB_VALIDATION_QUERY="SELECT 1"\n\
  \n\
  echo "✅ PostgreSQL 설정 완료:"\n\
  echo "   - 드라이버: $DB_DRIVER"\n\
  echo "   - 호스트: $DB_HOST:$DB_PORT"\n\
  echo "   - 데이터베이스: $DB_NAME"\n\
  echo "   - 사용자: $DB_USERNAME"\n\
else\n\
  echo "📦 로컬 MySQL 설정 사용"\n\
fi\n\
\n\
export JAVA_HOME=$(find /usr/lib/jvm -name "java-17-openjdk-*" -type d | head -1)\n\
echo "☕ JAVA_HOME: $JAVA_HOME"\n\
\n\
exec mvn jetty:run' > /app/entrypoint.sh && chmod +x /app/entrypoint.sh

# 포트 노출
EXPOSE 8080

# Entrypoint 실행
ENTRYPOINT ["/app/entrypoint.sh"] 