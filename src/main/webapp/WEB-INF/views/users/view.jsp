<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사용자 상세정보 - ${user.name}</title>
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
                    <h2><i class="fas fa-user text-primary me-2"></i>사용자 상세정보</h2>
                    <div>
                        <a href="/users" class="btn btn-secondary me-2">
                            <i class="fas fa-arrow-left me-1"></i>목록으로
                        </a>
                        <a href="/users/${user.id}/edit" class="btn btn-warning">
                            <i class="fas fa-edit me-1"></i>수정
                        </a>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-8 mx-auto">
                        <div class="card shadow">
                            <div class="card-header bg-primary text-white">
                                <h5 class="mb-0">
                                    <i class="fas fa-id-card me-2"></i>
                                    ${user.name} (ID: ${user.id})
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-4">
                                            <label class="form-label text-muted">
                                                <i class="fas fa-user me-2"></i>이름
                                            </label>
                                            <div class="fs-5 fw-bold">${user.name}</div>
                                        </div>
                                        
                                        <div class="mb-4">
                                            <label class="form-label text-muted">
                                                <i class="fas fa-envelope me-2"></i>이메일
                                            </label>
                                            <div class="fs-5">
                                                <a href="mailto:${user.email}" class="text-decoration-none">
                                                    ${user.email}
                                                </a>
                                            </div>
                                        </div>
                                        
                                        <div class="mb-4">
                                            <label class="form-label text-muted">
                                                <i class="fas fa-birthday-cake me-2"></i>나이
                                            </label>
                                            <div class="fs-5">${user.age}세</div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <div class="mb-4">
                                            <label class="form-label text-muted">
                                                <i class="fas fa-calendar-plus me-2"></i>생성일
                                            </label>
                                            <div class="fs-6">
                                                ${user.createdAt}
                                            </div>
                                        </div>
                                        
                                        <div class="mb-4">
                                            <label class="form-label text-muted">
                                                <i class="fas fa-calendar-check me-2"></i>수정일
                                            </label>
                                            <div class="fs-6">
                                                ${user.updatedAt}
                                            </div>
                                        </div>
                                        
                                        <div class="mb-4">
                                            <label class="form-label text-muted">
                                                <i class="fas fa-hashtag me-2"></i>사용자 ID
                                            </label>
                                            <div class="fs-6">
                                                <span class="badge bg-primary fs-6">${user.id}</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer bg-light">
                                <div class="d-flex justify-content-between">
                                    <a href="/users" class="btn btn-outline-secondary">
                                        <i class="fas fa-list me-1"></i>사용자 목록
                                    </a>
                                    <div>
                                        <a href="/users/${user.id}/edit" class="btn btn-warning me-2">
                                            <i class="fas fa-edit me-1"></i>수정
                                        </a>
                                        <button type="button" class="btn btn-danger" onclick="confirmDelete()">
                                            <i class="fas fa-trash me-1"></i>삭제
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 삭제 확인 모달 -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">사용자 삭제 확인</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p><strong>${user.name}</strong> 사용자를 정말 삭제하시겠습니까?</p>
                    <p class="text-danger">이 작업은 되돌릴 수 없습니다.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <form method="post" action="/users/${user.id}/delete" style="display: inline;">
                        <button type="submit" class="btn btn-danger">
                            <i class="fas fa-trash me-1"></i>삭제
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmDelete() {
            var modal = new bootstrap.Modal(document.getElementById('deleteModal'));
            modal.show();
        }
    </script>
</body>
</html> 