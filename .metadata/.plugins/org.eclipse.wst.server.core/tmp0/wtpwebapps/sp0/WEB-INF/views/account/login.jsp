<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>관리자 로그인</title>

<!-- Bootstrap 5 CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
<link href="<c:url value='/resources/css/style.css'/>" rel="stylesheet">

<style>
    body { 
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .login-box {
        width: 100%;
        max-width: 420px;
        padding: 40px;
        background: var(--card-bg);
        border-radius: 16px;
        box-shadow: 0 10px 40px rgba(0,0,0,0.3);
        border: 1px solid var(--border-color);
    }
    .login-header {
        text-align: center;
        margin-bottom: 30px;
    }
    .login-header i {
        font-size: 3rem;
        color: var(--primary-color);
        margin-bottom: 15px;
    }
    .login-header h3 {
        color: var(--text-color);
        font-weight: 700;
    }
    .login-header p {
        color: var(--text-muted);
        font-size: 0.9rem;
    }
    .form-control {
        padding: 12px 15px;
        border-radius: 8px;
    }
    .btn-login {
        padding: 12px;
        font-weight: 600;
        border-radius: 8px;
    }
</style>
</head>

<body>

<div class="login-box">

    <div class="login-header">
        <i class="bi bi-shield-lock"></i>
        <h3>관리자 로그인</h3>
        <p>상품 관리 시스템에 접근하려면<br>관리자 계정으로 로그인하세요.</p>
    </div>

    <!-- 로그인 실패 메시지 -->
    <c:if test="${param.error != null}">
        <div class="alert alert-danger d-flex align-items-center">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>
            아이디 또는 비밀번호가 올바르지 않습니다.
        </div>
    </c:if>

    <!-- 로그아웃 메시지 -->
    <c:if test="${param.logout != null}">
        <div class="alert alert-success d-flex align-items-center">
            <i class="bi bi-check-circle-fill me-2"></i>
            정상적으로 로그아웃되었습니다.
        </div>
    </c:if>

    <!-- Spring Security 로그인 처리 -->
    <form method="post" action="/account/login">

        <div class="mb-3">
            <label class="form-label"><i class="bi bi-person me-1"></i>아이디</label>
            <input type="text" name="username" class="form-control" placeholder="관리자 아이디 입력" required autofocus>
        </div>

        <div class="mb-3">
            <label class="form-label"><i class="bi bi-key me-1"></i>비밀번호</label>
            <input type="password" name="password" class="form-control" placeholder="비밀번호 입력" required>
        </div>

        <!-- remember-me -->
        <div class="form-check mb-4">
            <input class="form-check-input" type="checkbox" name="remember-me" id="rememberMe">
            <label class="form-check-label" for="rememberMe">
                로그인 상태 유지
            </label>
        </div>

        <button type="submit" class="btn btn-primary w-100 btn-login">
            <i class="bi bi-box-arrow-in-right me-2"></i>로그인
        </button>

    </form>
    
    <div class="text-center mt-4">
        <small class="text-muted">
            <i class="bi bi-info-circle me-1"></i>
            관리자 권한이 없으면 접근이 제한됩니다.
        </small>
    </div>
    
    <!-- 테스트 계정 정보 (접기/펼치기) -->
    <div class="mt-3">
        <button class="btn btn-sm btn-outline-secondary w-100" type="button" 
                data-bs-toggle="collapse" data-bs-target="#testAccountInfo">
            <i class="bi bi-key-fill me-1"></i>테스트 계정 보기
        </button>
        <div class="collapse mt-2" id="testAccountInfo">
            <div class="card card-body" style="background: var(--card-bg); border: 1px solid var(--border-color);">
                <small>
                    <table class="table table-sm table-borderless mb-0" style="color: var(--text-color);">
                        <tr>
                            <td><strong>관리자</strong></td>
                            <td><code>admin</code> / <code>1234</code></td>
                        </tr>
                        <tr>
                            <td><strong>일반회원</strong></td>
                            <td><code>user1</code> / <code>1234</code></td>
                        </tr>
                    </table>
                </small>
            </div>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
// 테마 적용
const savedTheme = localStorage.getItem('theme') || 
    (window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');
document.documentElement.setAttribute('data-theme', savedTheme);
</script>

</body>
</html>
