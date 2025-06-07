# 🆓 Render 무료 플랜 완벽 가이드

## ✅ **무료로 사용할 수 있는 서비스**

### 1️⃣ **Web Service (무료 플랜)**
```yaml
- type: web
  plan: free  # 🔥 필수! 이거 빠지면 유료
```

**무료 제한사항:**
- ⏰ **Sleep 모드**: 15분 비활성 후 자동 중지
- 🔄 **Cold Start**: 첫 요청 시 30초-2분 시작 시간
- 📊 **750시간/월**: 월 사용 제한 (약 31일)
- 💾 **512MB RAM**: 메모리 제한

### 2️⃣ **PostgreSQL Database (무료 플랜)**
```yaml
databases:
  - name: postgres-db
    plan: free  # 무료 PostgreSQL
```

**무료 제한사항:**
- 💾 **1GB 저장공간**: 데이터 제한
- 📊 **월 대역폭 제한**: 100GB/월
- ⚡ **성능 제한**: 느린 IO 성능

## 🚨 **유료 요금 발생하는 경우**

### ❌ **자동 유료 전환되는 상황**
1. **`plan: free` 누락** → 기본값(유료) 적용
2. **무료 한도 초과** → 자동 업그레이드
3. **잘못된 플랜 이름** → 유료 플랜 적용
4. **추가 서비스 사용** (Redis, 외부 도메인 등)

### ✅ **완전 무료 설정 체크리스트**
```yaml
services:
  - type: web
    plan: free        # ✅ 필수!
    env: docker       # ✅ 지원됨
    
databases:
  - plan: free        # ✅ 필수!
    
# ❌ 다음은 유료:
# - type: private-service
# - type: background-worker  
# - type: cron-job
# - plan: starter/standard/pro
```

## 🔄 **무료 플랜 최적화 팁**

### 1️⃣ **Sleep 모드 대응**
```bash
# Health Check 엔드포인트로 Keep-Alive
# 외부 모니터링 서비스 사용 (UptimeRobot 등)
```

### 2️⃣ **Cold Start 최소화**
```dockerfile
# 가벼운 이미지 사용
FROM openjdk:17-jre-slim  # JRE만 사용
```

### 3️⃣ **메모리 최적화**
```yaml
envVars:
  - key: JAVA_OPTS
    value: "-Xmx256m -Xms128m"  # 메모리 제한
```

## 🎯 **배포 시나리오별 비용**

| 시나리오 | Web Service | Database | 월 비용 | 제한사항 |
|----------|:-----------:|:--------:|:-------:|----------|
| **개발/테스트** | Free | Free | $0 | Sleep 모드, 느림 |
| **소규모 프로젝트** | Free | Free | $0 | 사용량 제한 |
| **중간 트래픽** | Starter ($7) | Free | $7 | 항상 온, 빠름 |
| **프로덕션** | Standard ($25) | Starter ($7) | $32 | 고성능, 백업 |

## 🚀 **지금 해야 할 일**

### 1️⃣ **무료 설정으로 다시 배포**
```bash
git add render.yaml
git commit -m "Render 무료 플랜 설정 수정"
git push origin main
```

### 2️⃣ **Render 대시보드에서 확인**
- Blueprint 다시 실행
- **"Free Plan"** 표시 확인
- 결제 정보 요구 안함 확인

### 3️⃣ **무료 한도 모니터링**
- Dashboard → Usage 탭에서 사용량 체크
- 750시간 한도 확인
- 1GB DB 용량 확인

## 💡 **대안 방안**

### Option 1: **결제 정보 등록 (추천)**
```
💳 신용카드만 등록, 무료 한도 내에서 사용
→ 한도 초과 시 자동 중지 설정 가능
→ 더 안정적인 서비스 이용
```

### Option 2: **다른 플랫폼 사용**
```
🌐 Railway: $5/월부터 (무료 크레딧 제공)
☁️ Vercel: 무료 (정적 사이트 + API)
🐳 Fly.io: 무료 계층 (더 관대한 제한)
```

---

**🎯 결론**: `plan: free` 누락이 유료 요금 발생 원인이었습니다! 