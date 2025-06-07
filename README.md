# Spring MVC + MyBatis + PostgreSQL 사용자 관리 시스템

Java Spring Framework를 사용한 웹 기반 사용자 관리 시스템입니다. REST API와 JSP 기반 웹 인터페이스를 모두 제공합니다.

## 🚀 주요 기능

### 📱 웹 인터페이스 (JSP)
- **사용자 목록** - 전체 사용자 목록 및 통계
- **사용자 상세보기** - 개별 사용자 정보 확인
- **사용자 추가** - 새로운 사용자 등록
- **사용자 수정** - 기존 사용자 정보 수정
- **사용자 삭제** - 사용자 삭제 (확인 모달 포함)

### 🔗 REST API
- `GET /api/users` - 모든 사용자 조회
- `GET /api/users/{id}` - 특정 사용자 조회
- `GET /api/users/count` - 사용자 수 조회
- `POST /api/users` - 새 사용자 생성
- `PUT /api/users/{id}` - 사용자 정보 수정
- `DELETE /api/users/{id}` - 사용자 삭제

## 🛠️ 기술 스택

- **Java 17**
- **Spring Framework 5.3.29** (Spring MVC)
- **MyBatis 3.5.13** (SQL 매퍼)
- **PostgreSQL** (데이터베이스)
- **HikariCP** (커넥션 풀)
- **JSP + JSTL** (뷰 템플릿)
- **Bootstrap 5** (UI 프레임워크)
- **Maven** (빌드 도구)
- **Jetty** (개발 서버)

## 📋 요구사항

- Java 17 이상
- Maven 3.6 이상
- PostgreSQL 12 이상

## 🔧 설치 및 실행

### 🐳 Docker로 실행 (권장)

가장 간단한 방법으로 모든 의존성이 자동으로 설정됩니다.

```bash
# 1. 프로젝트 클론
git clone https://github.com/wjb127/java-spring-practice.git
cd java-spring-practice

# 2. Docker Compose로 실행
./docker-run.sh

# 또는 수동으로 실행
docker-compose up --build
```

**접속 정보:**
- **애플리케이션**: http://localhost:8080
- **사용자 관리**: http://localhost:8080/users  
- **REST API**: http://localhost:8080/api/users
- **PostgreSQL**: localhost:5432 (postgres/password)

**Docker 명령어:**
```bash
# 서비스 중지
docker-compose down

# 로그 확인
docker-compose logs -f

# 데이터 초기화 (볼륨 삭제)
docker-compose down -v
```

### 🛠️ 로컬 환경에서 실행

### 1. 프로젝트 클론
```bash
git clone https://github.com/wjb127/java-spring-practice.git
cd java-spring-practice
```

### 2. PostgreSQL 설정
```bash
# Homebrew로 PostgreSQL 설치 (macOS)
brew install postgresql
brew services start postgresql

# PostgreSQL 접속 후 데이터베이스 생성
psql -U postgres

# schema.sql 실행
psql -U postgres -d demo_db < src/main/resources/schema.sql
```

### 3. 애플리케이션 실행
```bash
# 프로젝트 빌드
mvn clean compile

# Jetty 서버로 실행
mvn jetty:run
```

### 4. 접속
- **홈페이지**: http://localhost:8080/
- **사용자 관리**: http://localhost:8080/users
- **REST API**: http://localhost:8080/api/users

## 📁 프로젝트 구조

```
src/
├── main/
│   ├── java/com/example/demo/
│   │   ├── controller/          # 컨트롤러 (MVC)
│   │   │   ├── HomeController.java
│   │   │   ├── UserController.java      # REST API
│   │   │   └── UserWebController.java   # JSP 웹 인터페이스
│   │   ├── model/              # 엔티티
│   │   │   └── User.java
│   │   ├── mapper/             # MyBatis 매퍼
│   │   │   └── UserMapper.java
│   │   └── service/            # 비즈니스 로직
│   │       └── UserService.java
│   ├── resources/
│   │   ├── config/
│   │   │   └── database.properties
│   │   ├── mybatis/
│   │   │   ├── mybatis-config.xml
│   │   │   └── mappers/
│   │   │       └── UserMapper.xml
│   │   └── spring/
│   │       ├── applicationContext.xml
│   │       └── servlet-context.xml
│   └── webapp/
│       └── WEB-INF/
│           ├── views/
│           │   ├── index.jsp
│           │   └── users/
│           │       ├── list.jsp
│           │       ├── view.jsp
│           │       └── form.jsp
│           └── web.xml
└── database-schema.sql
```

## 💾 데이터베이스 스키마

```sql
CREATE DATABASE demo_db;
USE demo_db;

CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    age INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

## 🎨 UI 특징

- **Bootstrap 5** 기반 모던한 디자인
- **Font Awesome** 아이콘 사용
- **반응형 디자인** (모바일 친화적)
- **실시간 폼 유효성 검사**
- **모달 창**을 통한 삭제 확인
- **플래시 메시지**로 작업 결과 알림

## 📝 사용자 JSON 예시

```json
{
  "name": "홍길동",
  "email": "hong@example.com",
  "age": 30
}
```

## 🔍 API 테스트 예시

```bash
# 모든 사용자 조회
curl http://localhost:8080/api/users

# 특정 사용자 조회
curl http://localhost:8080/api/users/1

# 새 사용자 생성
curl -X POST http://localhost:8080/api/users \
  -H "Content-Type: application/json" \
  -d '{"name":"테스트","email":"test@example.com","age":25}'

# 사용자 수정
curl -X PUT http://localhost:8080/api/users/1 \
  -H "Content-Type: application/json" \
  -d '{"name":"홍길동수정","email":"hong_updated@example.com","age":31}'

# 사용자 삭제
curl -X DELETE http://localhost:8080/api/users/1
```

## 📄 라이선스

MIT License 