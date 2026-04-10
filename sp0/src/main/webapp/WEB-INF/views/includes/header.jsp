<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Admin Panel</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
  
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

  <!-- Top Navbar -->
  <header class="header">
    <nav class="navbar navbar-expand-lg navbar-custom px-4">
      <a class="navbar-brand" href="/product/list"><i class="bi bi-gear-fill me-2"></i>관리자 페이지</a>
      <div class="collapse navbar-collapse">
        <ul class="navbar-nav me-auto">
          <li class="nav-item"><a class="nav-link" href="/product/list">상품 리스트</a></li>
        </ul>
        <span class="navbar-text d-flex align-items-center gap-3">
          <!-- 다크모드 토글 버튼 -->
          <button id="themeToggle" class="btn btn-sm btn-outline-light" title="테마 변경">
            <span id="themeIcon">🌙</span>
          </button>
          <sec:authorize access="isAuthenticated()">
            <span class="text-white">
              <i class="bi bi-person-circle me-1"></i>
              <strong><sec:authentication property="principal.username"/></strong>
            </span>
            <a href="/account/logout" class="btn btn-sm btn-outline-light">
              <i class="bi bi-box-arrow-right me-1"></i>로그아웃
            </a>
          </sec:authorize>
        </span>
      </div>
    </nav>
  </header>

  <!-- Sidebar + Content -->
  <div class="main-wrapper">
    <!-- Sidebar -->
    <div class="sidebar pt-3">
      <div class="list-group list-group-flush">
        <a href="/product/list" class="list-group-item active">상품 리스트</a>
      </div>
    </div>

    <!-- Main Content -->
    <div class="content">    