# 🚂 Railway 배포 가이드

## ⚠️ 중요: MySQL 연결 설정

Railway에서는 Docker Compose의 다중 서비스를 지원하지 않으므로, MySQL을 별도로 설정해야 합니다.

## 📋 배포 단계별 가이드

### 1단계: Railway 프로젝트 생성
1. [Railway](https://railway.app) 로그인
2. "New Project" → "Deploy from GitHub repo" 선택
3. 이 저장소 선택

### 2단계: MySQL 서비스 추가 (필수!)
```bash
# Railway 대시보드에서:
1. 프로젝트 선택
2. "Add Service" 클릭  
3. "Database" → "Add MySQL" 선택
4. MySQL 서비스가 생성될 때까지 대기
```

### 3단계: 환경 변수 설정
Railway 대시보드에서 애플리케이션 서비스의 Variables 탭에서 다음 환경변수들을 설정:

```env
# MySQL 플러그인이 생성한 변수 참조
DB_HOST=${{MySQL.MYSQL_URL}}
DB_PORT=${{MySQL.MYSQL_PORT}}
DB_NAME=${{MySQL.MYSQL_DATABASE}}
DB_USERNAME=${{MySQL.MYSQL_USER}}
DB_PASSWORD=${{MySQL.MYSQL_PASSWORD}}
```

> 💡 `${{MySQL.xxxx}}` 형식으로 Railway의 MySQL 플러그인 변수를 참조할 수 있습니다.

### 4단계: 데이터베이스 초기화
MySQL 연결 후 초기 데이터 생성을 위해 다음 SQL을 실행:

```sql
-- Railway MySQL 콘솔에서 실행
CREATE DATABASE IF NOT EXISTS demo_db;
USE demo_db;

-- 사용자 테이블 생성
CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    age INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 초기 데이터 삽입
INSERT INTO users (name, email, age) VALUES
('홍길동', 'hong@example.com', 30),
('김철수', 'kim@example.com', 25),
('이영희', 'lee@example.com', 28),
('박민수', 'park@example.com', 35),
('정수진', 'jung@example.com', 32);
```

### 5단계: 배포 확인
1. Railway에서 자동 배포 시작
2. 빌드 로그 확인
3. 배포 완료 후 제공된 URL에서 테스트:
   - `https://your-app.railway.app/` - 홈페이지
   - `https://your-app.railway.app/health` - 헬스체크
   - `https://your-app.railway.app/users` - 사용자 관리 화면
   - `https://your-app.railway.app/api/users` - REST API

## 🔧 문제 해결

### 연결 오류 (Connection refused)
```bash
# 환경변수가 올바르게 설정되었는지 확인
1. Railway 대시보드 → Variables 탭 확인
2. MySQL 서비스가 실행 중인지 확인
3. DB_HOST가 올바른 호스트명을 가리키는지 확인
```

### MySQL 플러그인 변수 확인
Railway MySQL 플러그인에서 제공하는 변수들:
- `${{MySQL.MYSQL_URL}}` - 호스트명
- `${{MySQL.MYSQL_PORT}}` - 포트 (보통 3306)
- `${{MySQL.MYSQL_DATABASE}}` - 데이터베이스명
- `${{MySQL.MYSQL_USER}}` - 사용자명
- `${{MySQL.MYSQL_PASSWORD}}` - 비밀번호

### 대안: 외부 MySQL 사용
Railway MySQL 대신 외부 MySQL(예: PlanetScale, AWS RDS)을 사용하는 경우:
```env
DB_HOST=your-external-mysql-host.com
DB_PORT=3306
DB_NAME=your_database_name
DB_USERNAME=your_username
DB_PASSWORD=your_password
```

## 📊 배포 후 확인 사항

✅ **체크리스트:**
- [ ] MySQL 서비스 실행 중
- [ ] 환경변수 모두 설정됨
- [ ] 데이터베이스 및 테이블 생성됨
- [ ] 헬스체크 엔드포인트 정상 응답 (`/health`)
- [ ] 웹 인터페이스 접근 가능 (`/users`)
- [ ] REST API 정상 동작 (`/api/users`)

## 🚀 성능 최적화

### 프로덕션 권장 설정
```env
# HikariCP 설정 (database.properties에서 수정)
db.initialSize=2
db.maxActive=5
db.maxIdle=3
db.minIdle=1
db.maxWait=5000
```

Railway의 무료 플랜에서는 리소스가 제한적이므로 연결 풀 크기를 줄이는 것이 좋습니다.

---

💡 **도움이 필요하시면 Railway Discord 또는 GitHub Issues로 문의하세요!**

## 🌐 배포 후 접속 URL

```
# Railway가 제공하는 도메인 예시
https://spring-app-production-abc123.up.railway.app

# 주요 엔드포인트
/                    - 홈페이지
/health             - 헬스체크  
/users              - 사용자 관리 웹 UI
/api/users          - REST API
/api/users/count    - 사용자 수
```

## ✨ 자동으로 처리되는 것들

✅ **인프라:** 서버, 네트워크, 로드밸런서  
✅ **데이터베이스:** MySQL 8.0 컨테이너  
✅ **HTTPS:** SSL 인증서 자동 적용  
✅ **도메인:** 고유 URL 자동 할당  
✅ **모니터링:** 로그, 메트릭 대시보드  
✅ **스케일링:** 트래픽에 따른 자동 확장  

## 🔄 업데이트 방법

```bash
# 로컬에서 코드 수정 후
git add .
git commit -m "기능 추가"
git push origin main

# Railway에서 자동 재배포!
```

## 💰 요금

- **Hobby Plan**: 월 $5 (충분한 리소스)
- **프리티어**: 월 500시간 무료
- **Sleep 모드**: 미사용시 자동 정지로 비용 절약 