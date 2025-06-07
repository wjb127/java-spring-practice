# 🚂 Railway 배포 가이드

## ⚠️ 중요: PostgreSQL 연결 설정

Railway에서는 Docker Compose의 다중 서비스를 지원하지 않으므로, PostgreSQL을 별도로 설정해야 합니다.

## 📋 배포 단계별 가이드

### 1단계: GitHub 연결
```bash
# Railway 대시보드에서:
1. "New Project" 클릭
2. "Deploy from GitHub repo" 선택  
3. 이 저장소 선택
```

### 2단계: PostgreSQL 서비스 추가 (필수!)
```bash
# Railway 대시보드에서:
1. 프로젝트 대시보드로 이동
2. "Add Service" 클릭
3. "Database" → "Add PostgreSQL" 선택
4. PostgreSQL 서비스가 생성될 때까지 대기
```

### 3단계: 환경변수 설정
```bash
# 스프링 앱 서비스의 Variables 탭에서 설정:
# PostgreSQL 플러그인이 생성한 변수 참조
DB_HOST=${{Postgres.PGHOST}}
DB_PORT=${{Postgres.PGPORT}}
DB_NAME=${{Postgres.PGDATABASE}}
DB_USERNAME=${{Postgres.PGUSER}}
DB_PASSWORD=${{Postgres.PGPASSWORD}}
```

> 💡 `${{Postgres.xxxx}}` 형식으로 Railway의 PostgreSQL 플러그인 변수를 참조할 수 있습니다.

### 4단계: 데이터베이스 초기화
PostgreSQL 연결 후 초기 데이터 생성을 위해 다음 SQL을 실행:

```sql
-- Railway PostgreSQL 콘솔에서 실행
-- 또는 pgAdmin/DBeaver 등 GUI 도구 사용

-- 사용자 테이블 생성 및 데이터 삽입은 schema.sql에서 자동 실행됩니다
SELECT COUNT(*) FROM users;
```

### 5단계: 배포 확인
```bash
# Railway 대시보드에서:
1. 빌드 로그 확인
2. 애플리케이션 URL 접속
3. /users 페이지 정상 동작 확인
```

## 🔧 수동 환경변수 설정 (대안)

Railway 플러그인 변수 대신 수동으로 설정할 수도 있습니다:

```bash
# Variables 탭에서 직접 입력:
DB_HOST=your-postgres-host
DB_PORT=5432
DB_NAME=railway
DB_USERNAME=postgres
DB_PASSWORD=your-password
SPRING_PROFILES_ACTIVE=production
```

## 🐛 트러블슈팅

### 1. 배포 실패 시
```bash
# 빌드 로그에서 확인할 포인트:
1. Docker 빌드 성공 여부
2. PostgreSQL 서비스가 실행 중인지 확인
3. 환경변수가 올바르게 설정되었는지 확인
```

### PostgreSQL 플러그인 변수 확인
Railway PostgreSQL 플러그인에서 제공하는 변수들:
- `${{Postgres.PGHOST}}` - 호스트명
- `${{Postgres.PGPORT}}` - 포트 (보통 5432)
- `${{Postgres.PGDATABASE}}` - 데이터베이스명
- `${{Postgres.PGUSER}}` - 사용자명
- `${{Postgres.PGPASSWORD}}` - 비밀번호

### 대안: 외부 PostgreSQL 사용
Railway PostgreSQL 대신 외부 PostgreSQL(예: Supabase, AWS RDS)을 사용하는 경우:
```bash
DB_HOST=your-external-postgres-host.com
DB_PORT=5432
DB_NAME=demo_db
DB_USERNAME=your-username
DB_PASSWORD=your-password
```

## ✅ 배포 체크리스트

- [ ] GitHub 저장소 연결됨
- [ ] PostgreSQL 서비스 실행 중
- [ ] 환경변수 모두 설정됨
- [ ] 빌드 성공
- [ ] 애플리케이션 URL 접속 가능
- [ ] 데이터베이스 연결 정상
- [ ] /users 페이지 정상 동작

## 🚀 완료!

Railway 배포가 완료되면 다음과 같은 환경을 얻을 수 있습니다:

```bash
✅ **운영 환경 주소:** https://your-project.railway.app
✅ **데이터베이스:** PostgreSQL (관리형)
✅ **SSL:** 자동 적용
✅ **CDN:** 자동 최적화
✅ **모니터링:** 기본 제공
✅ **로그:** 실시간 확인 가능
```

> 🎉 이제 Railway에서 Spring + MyBatis + PostgreSQL 애플리케이션이 실행됩니다!

---

## 📞 문제 해결

배포 중 문제가 생기면:
1. Railway 대시보드의 **Deployments** 탭에서 로그 확인
2. **Variables** 탭에서 환경변수 재확인  
3. PostgreSQL 서비스 **Data** 탭에서 연결 테스트

---

**Railway 무료 플랜:**
- ✅ **최대 5개 프로젝트**
- ✅ **$5 월 크레딧** (충분함)
- ✅ **자동 배포**
- ✅ **데이터베이스:** PostgreSQL (관리형)