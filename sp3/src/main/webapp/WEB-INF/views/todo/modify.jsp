<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="ko">

            <head>
                <title>Todo 수정</title>
                <meta charset="utf-8">
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
            </head>

            <body>

                <div class="container mt-5">
                    <h2>Todo 수정</h2>
                    <form action="/todo/modifyPost" method="post">
                        <input type="hidden" name="id" value="${todo.id}">

                        <div class="mb-3 mt-3">
                            <label class="form-label">번호:</label>
                            <input type="text" class="form-control" value="${todo.id}" readonly>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">제목: <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="title" value="<c:out value='${todo.title}'/>"
                                required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">설명:</label>
                            <textarea class="form-control" name="description"
                                rows="4"><c:out value='${todo.description}'/></textarea>
                        </div>

                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="doneCheck" name="done" value="true"
                                ${todo.done ? 'checked' : '' }>
                            <label class="form-check-label" for="doneCheck">완료</label>
                        </div>

                        <div class="mt-4">
                            <button type="submit" class="btn btn-primary">수정 완료</button>
                            <a href="/todo/read/${todo.id}" class="btn btn-secondary">취소</a>
                            <a href="/todo/list" class="btn btn-info">목록</a>
                        </div>
                    </form>
                </div>

            </body>

            </html>