# Railway 배포 가이드

## 🚀 간단 배포 (3단계)

### 1단계: Railway 계정 생성
- https://railway.app 접속
- GitHub 계정으로 로그인

### 2단계: 프로젝트 배포
1. **New Project** 클릭
2. **Deploy from GitHub repo** 선택  
3. **java-spring-practice** 리포지토리 선택
4. **Deploy Now** 클릭

### 3단계: 완료!
- Railway가 자동으로 Dockerfile 감지
- 5-10분 후 배포 완료
- 자동 할당된 도메인 확인

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