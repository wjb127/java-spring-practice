<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <c:choose>
            <c:when test="${user.id != null}">사용자 수정 - ${user.name}</c:when>
            <c:otherwise>새 사용자 추가</c:otherwise>
        </c:choose>
    </title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="/">
                <i class="fas fa-users me-2"></i>사용자 관리 시스템
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="/">홈</a>
                <a class="nav-link" href="/users">사용자 관리</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2>
                        <c:choose>
                            <c:when test="${user.id != null}">
                                <i class="fas fa-edit text-warning me-2"></i>사용자 수정
                            </c:when>
                            <c:otherwise>
                                <i class="fas fa-plus text-success me-2"></i>새 사용자 추가
                            </c:otherwise>
                        </c:choose>
                    </h2>
                    <a href="/users" class="btn btn-secondary">
                        <i class="fas fa-arrow-left me-1"></i>목록으로
                    </a>
                </div>

                <div class="row">
                    <div class="col-md-8 mx-auto">
                        <div class="card shadow">
                            <div class="card-header">
                                <h5 class="mb-0">
                                    <c:choose>
                                        <c:when test="${user.id != null}">
                                            <i class="fas fa-edit me-2"></i>사용자 정보 수정
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fas fa-user-plus me-2"></i>새 사용자 정보 입력
                                        </c:otherwise>
                                    </c:choose>
                                </h5>
                            </div>
                            <div class="card-body">
                                <form method="post" id="userForm" 
                                      action="<c:choose><c:when test='${user.id != null}'>/users/${user.id}</c:when><c:otherwise>/users</c:otherwise></c:choose>">
                                    
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="name" class="form-label">
                                                    <i class="fas fa-user text-muted me-1"></i>이름 <span class="text-danger">*</span>
                                                </label>
                                                <input type="text" 
                                                       class="form-control" 
                                                       id="name" 
                                                       name="name" 
                                                       value="${user.name}" 
                                                       required 
                                                       minlength="2" 
                                                       maxlength="50"
                                                       placeholder="이름을 입력하세요">
                                                <div class="form-text">2-50자 사이로 입력해주세요.</div>
                                            </div>
                                        </div>
                                        
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="age" class="form-label">
                                                    <i class="fas fa-birthday-cake text-muted me-1"></i>나이 <span class="text-danger">*</span>
                                                </label>
                                                <input type="number" 
                                                       class="form-control" 
                                                       id="age" 
                                                       name="age" 
                                                       value="${user.age}" 
                                                       required 
                                                       min="1" 
                                                       max="150"
                                                       placeholder="나이를 입력하세요">
                                                <div class="form-text">1-150 사이의 숫자를 입력해주세요.</div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="email" class="form-label">
                                            <i class="fas fa-envelope text-muted me-1"></i>이메일 <span class="text-danger">*</span>
                                        </label>
                                        <input type="email" 
                                               class="form-control" 
                                               id="email" 
                                               name="email" 
                                               value="${user.email}" 
                                               required 
                                               maxlength="100"
                                               placeholder="이메일을 입력하세요 (예: user@example.com)">
                                        <div class="form-text">유효한 이메일 주소를 입력해주세요.</div>
                                    </div>

                                    <c:if test="${user.id != null}">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">
                                                        <i class="fas fa-hashtag text-muted me-1"></i>사용자 ID
                                                    </label>
                                                    <input type="text" class="form-control" value="${user.id}" readonly>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">
                                                        <i class="fas fa-calendar-plus text-muted me-1"></i>생성일
                                                    </label>
                                                    <input type="text" class="form-control" 
                                                           value="${user.createdAt}" readonly>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>

                                    <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                                        <a href="/users" class="btn btn-secondary me-md-2">
                                            <i class="fas fa-times me-1"></i>취소
                                        </a>
                                        <button type="submit" class="btn btn-primary">
                                            <c:choose>
                                                <c:when test="${user.id != null}">
                                                    <i class="fas fa-save me-1"></i>수정 완료
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fas fa-plus me-1"></i>추가 완료
                                                </c:otherwise>
                                            </c:choose>
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                        
                        <!-- 도움말 카드 -->
                        <div class="card mt-4">
                            <div class="card-body">
                                <h6 class="card-title">
                                    <i class="fas fa-info-circle text-info me-2"></i>입력 안내
                                </h6>
                                <ul class="list-unstyled mb-0">
                                    <li><i class="fas fa-check text-success me-2"></i>모든 필수 항목(*)을 입력해주세요.</li>
                                    <li><i class="fas fa-check text-success me-2"></i>이름은 2-50자 사이로 입력해주세요.</li>
                                    <li><i class="fas fa-check text-success me-2"></i>나이는 1-150 사이의 숫자로 입력해주세요.</li>
                                    <li><i class="fas fa-check text-success me-2"></i>이메일은 유효한 형식으로 입력해주세요.</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // 폼 유효성 검사
        document.getElementById('userForm').addEventListener('submit', function(e) {
            const name = document.getElementById('name').value.trim();
            const email = document.getElementById('email').value.trim();
            const age = document.getElementById('age').value;

            if (!name || name.length < 2 || name.length > 50) {
                e.preventDefault();
                alert('이름은 2-50자 사이로 입력해주세요.');
                document.getElementById('name').focus();
                return;
            }

            if (!email || !isValidEmail(email)) {
                e.preventDefault();
                alert('유효한 이메일 주소를 입력해주세요.');
                document.getElementById('email').focus();
                return;
            }

            if (!age || age < 1 || age > 150) {
                e.preventDefault();
                alert('나이는 1-150 사이의 숫자로 입력해주세요.');
                document.getElementById('age').focus();
                return;
            }
        });

        function isValidEmail(email) {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return emailRegex.test(email);
        }

        // 실시간 유효성 검사 피드백
        document.getElementById('name').addEventListener('input', function() {
            const value = this.value.trim();
            if (value.length > 0 && (value.length < 2 || value.length > 50)) {
                this.classList.add('is-invalid');
            } else {
                this.classList.remove('is-invalid');
                if (value.length >= 2) this.classList.add('is-valid');
            }
        });

        document.getElementById('email').addEventListener('input', function() {
            const value = this.value.trim();
            if (value.length > 0 && !isValidEmail(value)) {
                this.classList.add('is-invalid');
            } else {
                this.classList.remove('is-invalid');
                if (value.length > 0) this.classList.add('is-valid');
            }
        });

        document.getElementById('age').addEventListener('input', function() {
            const value = parseInt(this.value);
            if (this.value && (value < 1 || value > 150)) {
                this.classList.add('is-invalid');
            } else {
                this.classList.remove('is-invalid');
                if (this.value) this.classList.add('is-valid');
            }
        });
    </script>
</body>
</html> 