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

# 포트 노출
EXPOSE 8080

# 애플리케이션 실행 (환경변수 설정과 함께)
CMD export JAVA_HOME=$(find /usr/lib/jvm -name "java-17-openjdk-*" -type d | head -1) && mvn jetty:run 