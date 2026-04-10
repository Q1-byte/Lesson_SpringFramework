<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <title>회원 수정</title>
                <meta charset="utf-8">
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
            </head>

            <body>

                <div class="container mt-3">
                    <h2>회원 수정</h2>
                    <form action="/member/modifyPost" method="post">
                        <input type="hidden" name="mno" value="${member.mno}">
                        <div class="mb-3 mt-3">
                            <label>번호:</label>
                            <input type="text" class="form-control" value="${member.mno}" readonly>
                        </div>
                        <div class="mb-3">
                            <label>이름:</label>
                            <input type="text" class="form-control" name="name" value="<c:out value='${member.name}'/>"
                                required>
                        </div>
                        <div class="mb-3">
                            <label>이메일:</label>
                            <input type="email" class="form-control" name="email"
                                value="<c:out value='${member.email}'/>" required>
                        </div>
                        <div class="mb-3">
                            <label>비밀번호:</label>
                            <input type="password" class="form-control" name="password"
                                value="<c:out value='${member.password}'/>" required>
                        </div>

                        <button type="submit" class="btn btn-primary">수정 완료</button>
                        <a href="/member/read/${member.mno}" class="btn btn-secondary">취소</a>
                        <a href="/member/list" class="btn btn-info">목록</a>
                    </form>
                </div>

            </body>

            </html>