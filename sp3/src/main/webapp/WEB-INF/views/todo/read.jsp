<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

      <!DOCTYPE html>
      <html lang="ko">

      <head>
        <title>Todo 상세보기</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
      </head>

      <body>

        <div class="container mt-5">
          <h2>Todo 상세보기</h2>
          <form id="form" action="/todo/read" method="post">
            <input type="hidden" name="id" value="${todo.id}">

            <div class="mb-3 mt-3">
              <label class="form-label">번호:</label>
              <input type="text" class="form-control" value="${todo.id}" readonly>
            </div>

            <div class="mb-3">
              <label class="form-label">제목:</label>
              <input type="text" class="form-control" value="<c:out value='${todo.title}'/>" readonly>
            </div>

            <div class="mb-3">
              <label class="form-label">설명:</label>
              <textarea class="form-control" rows="4" readonly><c:out value='${todo.description}'/></textarea>
            </div>

            <div class="mb-3 form-check">
              <input type="checkbox" class="form-check-input" ${todo.done ? 'checked' : '' } disabled>
              <label class="form-check-label">완료</label>
            </div>

            <div class="mb-3">
              <label class="form-label">등록일:</label>
              <input type="text" class="form-control"
                value="<fmt:formatDate value='${todo.created_at}' pattern='yyyy-MM-dd HH:mm:ss'/>" readonly>
            </div>

            <div class="mt-4">
              <button type="button" class="btn btn-primary update">수정</button>
              <button type="button" class="btn btn-danger delete">삭제</button>
              <button type="button" class="btn btn-info list">목록</button>
            </div>
          </form>
        </div>

        <script type="text/javascript">
          const formObj = document.querySelector("form");

          document.querySelector(".update").addEventListener("click", () => {
            formObj.action = "/todo/modify";
            formObj.method = "post";
            formObj.submit();
          });

          document.querySelector(".delete").addEventListener("click", () => {
            if (confirm("정말 삭제하시겠습니까?")) {
              formObj.action = "/todo/delete/" + "${todo.id}";
              formObj.method = "post";
              formObj.submit();
            }
          });

          document.querySelector(".list").addEventListener("click", () => {
            location.href = "/todo/list";
          });
        </script>

      </body>

      </html>