<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

      <!DOCTYPE html>
      <html lang="ko">

      <head>
        <title>Todo 등록</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
      </head>

      <body>

        <div class="container mt-5">
          <h2>New Todo 등록</h2>
          <form action="/todo/register" method="post">
            <div class="mb-3 mt-3">
              <label for="title" class="form-label">제목: <span class="text-danger">*</span></label>
              <input type="text" class="form-control" id="title" placeholder="제목 ..." name="title" required>
            </div>

            <div class="mb-3">
              <label for="description" class="form-label">설명:</label>
              <textarea class="form-control" id="description" rows="4" placeholder="설명 ..."
                name="description"></textarea>
            </div>

            <div class="mt-4">
              <button type="submit" class="btn btn-primary">등록</button>
              <a href="/todo/list" class="btn btn-secondary">취소</a>
            </div>
          </form>
        </div>

      </body>

      </html>