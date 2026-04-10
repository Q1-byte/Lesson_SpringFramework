<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

      <!DOCTYPE html>
      <html>

      <head>
        <meta charset="UTF-8">
        <title>Todo List</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
      </head>

      <body>
        <div class="container mt-5">
          <h1 class="mb-4">Todo List</h1>

          <div class="d-flex justify-content-end mb-3">
            <a href="/todo/register">
              <button type="button" class="btn btn-primary">To do</button>
            </a>
          </div>

          <table class="table table-hover">
            <thead class="table-light">
              <tr>
                <th scope="col" style="width: 5%;">ID</th>
                <th scope="col" style="width: 5%;">완료</th>
                <th scope="col" style="width: 25%;">제목</th>
                <th scope="col" style="width: 45%;">설명</th>
                <th scope="col" style="width: 20%;">등록일</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="todo" items="${todoList}">
                <tr>
                  <td>
                    <a href="/todo/read/${todo.id}">
                      <c:out value="${todo.id}"></c:out>
                    </a>
                  </td>
                  <td class="text-center">
                    <c:if test="${todo.done}">
                      <input type="checkbox" checked disabled>
                    </c:if>
                    <c:if test="${!todo.done}">
                      <input type="checkbox" disabled>
                    </c:if>
                  </td>
                  <td>
                    <a href="/todo/read/${todo.id}" class="text-decoration-none">
                      <c:out value="${todo.title}"></c:out>
                    </a>
                  </td>
                  <td>
                    <c:out value="${todo.description}"></c:out>
                  </td>
                  <td>
                    <fmt:formatDate value="${todo.created_at}" pattern="yyyy-MM-dd HH:mm" />
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </body>

      </html>