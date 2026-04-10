<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>접근 제한</title>

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
    .denied-box {
        text-align: center;
        padding: 50px;
        background: var(--card-bg);
        border-radius: 16px;
        box-shadow: 0 10px 40px rgba(0,0,0,0.3);
        border: 1px solid var(--border-color);
        max-width: 500px;
    }
    .denied-icon {
        font-size: 5rem;
        color: #dc3545;
        margin-bottom: 20px;
    }
    .denied-code {
        font-size: 4rem;
        font-weight: 700;
        color: #dc3545;
        margin-bottom: 10px;
    }
    .denied-title {
        font-size: 1.5rem;
        color: var(--text-color);
        margin-bottom: 15px;
    }
    .denied-message {
        color: var(--text-muted);
        margin-bottom: 30px;
        line-height: 1.7;
    }
</style>
</head>

<body>

<div class="denied-box">
    <i class="bi bi-shield-x denied-icon"></i>
    <div class="denied-code">403</div>
    <h2 class="denied-title">접근이 거부되었습니다</h2>
    <p class="denied-message">
        이 페이지는 <strong>관리자 전용</strong> 페이지입니다.<br>
        관리자 권한이 있는 계정으로 로그인해주세요.<br><br>
        <sec:authorize access="isAuthenticated()">
            <span class="badge bg-secondary">
                현재 로그인: <sec:authentication property="principal.username"/>
            </span><br>
            <span class="badge bg-warning text-dark mt-2">
                권한: <sec:authentication property="principal.authorities"/>
            </span>
        </sec:authorize>
    </p>
    
    <div class="d-flex gap-2 justify-content-center">
        <sec:authorize access="isAuthenticated()">
            <a href="/account/logout" class="btn btn-outline-danger">
                <i class="bi bi-box-arrow-right me-1"></i>로그아웃
            </a>
        </sec:authorize>
        <a href="/account/login" class="btn btn-primary">
            <i class="bi bi-box-arrow-in-right me-1"></i>관리자 로그인
        </a>
    </div>
</div>

<script>
// 테마 적용
const savedTheme = localStorage.getItem('theme') || 
    (window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');
document.documentElement.setAttribute('data-theme', savedTheme);
</script>

</body>
</html>
