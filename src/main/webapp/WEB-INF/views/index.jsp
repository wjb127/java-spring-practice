<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Spring MVC Demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .hero-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 80px 0;
            text-align: center;
        }
        .feature-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        .api-badge {
            font-size: 0.8rem;
            padding: 0.3rem 0.6rem;
        }
    </style>
</head>
<body class="bg-light">
    <!-- Hero Section -->
    <div class="hero-section">
        <div class="container">
            <h1 class="display-4 fw-bold mb-4">
                <i class="fas fa-rocket me-3"></i>${message}
            </h1>
            <p class="lead mb-5">Spring Framework + MyBatis + MySQL을 활용한 웹 애플리케이션</p>
            <div class="d-flex justify-content-center gap-3">
                <a href="/users" class="btn btn-light btn-lg">
                    <i class="fas fa-users me-2"></i>사용자 관리 시스템
                </a>
                <a href="/api/users" class="btn btn-outline-light btn-lg" target="_blank">
                    <i class="fas fa-code me-2"></i>API 테스트
                </a>
            </div>
        </div>
    </div>

    <div class="container mt-5">
        <!-- 주요 기능 카드들 -->
        <div class="row mb-5">
            <div class="col-md-6 mb-4">
                <div class="card feature-card h-100 border-0 shadow">
                    <div class="card-body text-center p-4">
                        <div class="mb-3">
                            <i class="fas fa-users fa-3x text-primary"></i>
                        </div>
                        <h4 class="card-title">사용자 관리 시스템</h4>
                        <p class="card-text text-muted">
                            직관적인 웹 인터페이스로 사용자를 쉽게 관리할 수 있습니다.
                            생성, 조회, 수정, 삭제 기능을 모두 지원합니다.
                        </p>
                        <a href="/users" class="btn btn-primary">
                            <i class="fas fa-arrow-right me-1"></i>시작하기
                        </a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-6 mb-4">
                <div class="card feature-card h-100 border-0 shadow">
                    <div class="card-body text-center p-4">
                        <div class="mb-3">
                            <i class="fas fa-code fa-3x text-success"></i>
                        </div>
                        <h4 class="card-title">REST API</h4>
                        <p class="card-text text-muted">
                            표준 REST API를 제공하여 다양한 클라이언트와 
                            쉽게 연동할 수 있습니다.
                        </p>
                        <a href="#api-docs" class="btn btn-success">
                            <i class="fas fa-book me-1"></i>API 문서
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- API 문서 섹션 -->
        <div id="api-docs" class="card shadow mb-5">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0">
                    <i class="fas fa-book me-2"></i>API 엔드포인트
                </h5>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>메서드</th>
                                <th>엔드포인트</th>
                                <th>설명</th>
                                <th>테스트</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><span class="badge bg-info api-badge">GET</span></td>
                                <td><code>/health</code></td>
                                <td>애플리케이션 상태 확인</td>
                                <td><a href="/health" target="_blank" class="btn btn-sm btn-outline-primary">테스트</a></td>
                            </tr>
                            <tr>
                                <td><span class="badge bg-info api-badge">GET</span></td>
                                <td><code>/api/users</code></td>
                                <td>모든 사용자 조회</td>
                                <td><a href="/api/users" target="_blank" class="btn btn-sm btn-outline-primary">테스트</a></td>
                            </tr>
                            <tr>
                                <td><span class="badge bg-info api-badge">GET</span></td>
                                <td><code>/api/users/{id}</code></td>
                                <td>특정 사용자 조회</td>
                                <td><a href="/api/users/1" target="_blank" class="btn btn-sm btn-outline-primary">테스트</a></td>
                            </tr>
                            <tr>
                                <td><span class="badge bg-info api-badge">GET</span></td>
                                <td><code>/api/users/count</code></td>
                                <td>사용자 수 조회</td>
                                <td><a href="/api/users/count" target="_blank" class="btn btn-sm btn-outline-primary">테스트</a></td>
                            </tr>
                            <tr>
                                <td><span class="badge bg-warning api-badge">POST</span></td>
                                <td><code>/api/users</code></td>
                                <td>새 사용자 생성</td>
                                <td><span class="text-muted">Postman 등 도구 사용</span></td>
                            </tr>
                            <tr>
                                <td><span class="badge bg-primary api-badge">PUT</span></td>
                                <td><code>/api/users/{id}</code></td>
                                <td>사용자 정보 수정</td>
                                <td><span class="text-muted">Postman 등 도구 사용</span></td>
                            </tr>
                            <tr>
                                <td><span class="badge bg-danger api-badge">DELETE</span></td>
                                <td><code>/api/users/{id}</code></td>
                                <td>사용자 삭제</td>
                                <td><span class="text-muted">Postman 등 도구 사용</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- 기술 스택 -->
        <div class="card shadow mb-5">
            <div class="card-header bg-success text-white">
                <h5 class="mb-0">
                    <i class="fas fa-cogs me-2"></i>기술 스택
                </h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <ul class="list-unstyled">
                            <li class="mb-2"><i class="fab fa-java text-danger me-2"></i><strong>Java 17</strong></li>
                            <li class="mb-2"><i class="fas fa-leaf text-success me-2"></i><strong>Spring Framework 5.3.29</strong></li>
                            <li class="mb-2"><i class="fas fa-database text-info me-2"></i><strong>MyBatis 3.5.13</strong></li>
                        </ul>
                    </div>
                    <div class="col-md-6">
                        <ul class="list-unstyled">
                            <li class="mb-2"><i class="fas fa-database text-primary me-2"></i><strong>MySQL 8.0</strong></li>
                            <li class="mb-2"><i class="fas fa-swimming-pool text-warning me-2"></i><strong>HikariCP</strong></li>
                            <li class="mb-2"><i class="fas fa-server text-secondary me-2"></i><strong>Apache Tomcat</strong></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <!-- 사용자 JSON 예시 -->
        <div class="card shadow mb-5">
            <div class="card-header bg-dark text-white">
                <h5 class="mb-0">
                    <i class="fas fa-code me-2"></i>사용자 JSON 예시
                </h5>
            </div>
            <div class="card-body">
                <pre class="bg-dark text-light p-3 rounded"><code>{
  "name": "홍길동",
  "email": "hong@example.com", 
  "age": 30
}</code></pre>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white text-center py-4 mt-5">
        <div class="container">
            <p class="mb-2">
                <i class="fas fa-heart text-danger me-1"></i>
                Spring MVC + MyBatis + MySQL 데모 애플리케이션
            </p>
            <p class="mb-0 text-muted">Powered by Spring Framework</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 