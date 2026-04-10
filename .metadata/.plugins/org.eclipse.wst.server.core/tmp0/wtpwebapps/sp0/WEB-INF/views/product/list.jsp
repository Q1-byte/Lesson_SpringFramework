<%-- JSP 기본 설정: Java 사용 + UTF-8 인코딩 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%-- JSTL Core 태그 사용 선언 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- 공통 헤더 include (네비게이션, CSS, JS 포함) --%>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<div class="row justify-content-center">
    <div class="col-lg-12">
        <div class="card shadow mb-4">

            <%-- 카드 헤더: 제목 + 검색/등록 폼 --%>
            <div class="card-header py-3 d-flex justify-content-between align-items-center">

                <%-- 페이지 제목 --%>
                <h6 class="m-0 font-weight-bold text-primary">상품 리스트</h6>

                <%-- 검색 폼 (GET 방식) --%>
                <form class="d-flex" method="get" action="/product/list" style="gap:8px;">

                    <%-- 검색 타입 선택 --%>
                    <select name="type" class="form-select form-select-sm">
                        <option value="all" ${type=='all' ? 'selected' : ''}>통합검색</option>
                        <option value="num" ${type=='num' ? 'selected' : ''}>상품번호</option>
                        <option value="name" ${type=='name' ? 'selected' : ''}>상품명</option>
                        <option value="category" ${type=='category' ? 'selected' : ''}>카테고리</option>
                        <option value="price" ${type=='price' ? 'selected' : ''}>가격</option>
                        <option value="regid" ${type=='regid' ? 'selected' : ''}>작성자</option>
                    </select>

                    <%-- 검색 키워드 입력 --%>
                    <input type="text" name="keyword"
                            class="form-control form-control-sm"
                            placeholder="검색어"
                            value="${keyword != null ? keyword : ''}">

                    <%-- 검색 버튼 --%>
                    <button type="submit" class="btn btn-sm btn-success">검색</button>

                    <%-- 상품 등록 페이지 이동 --%>
                    <a href="/product/register" class="btn btn-primary btn-sm ms-2">등록</a>
                </form>
            </div>

            <div class="card-body">

                <%-- 상품 목록 테이블 --%>
                <table class="table table-boardered" id="dataTable">

                    <thead>
                        <tr>
                            <%-- Num 정렬 --%>
                            <th>
                                <%-- 기본 정렬 값 설정 --%>
                                <c:set var="numNextOrder" value="num"/>
                                <c:set var="numNextDir" value="asc"/>
                                <c:if test="${order == 'num' && dir == 'asc'}">
                                    <c:set var="numNextDir" value="desc"/>
                                </c:if>
                                <c:if test="${order == 'num' && dir == 'desc'}">
                                    <c:set var="numNextDir" value="asc"/>
                                </c:if>
                                <a href="?type=${type}&keyword=${keyword}&order=${numNextOrder}&dir=${numNextDir}">
                                    상품번호
                                    <c:if test="${order == 'num'}">
                                        <c:choose>
                                            <c:when test="${dir == 'asc'}">▲</c:when>
                                            <c:when test="${dir == 'desc'}">▼</c:when>
                                        </c:choose>
                                    </c:if>
                                </a>
                            </th>

                            <th>이미지</th>
                            <th>상품이름</th>
                            <th>카테고리</th>

                            <%-- Price 정렬 --%>
                            <th>
                                <c:set var="nextOrder" value="price"/>
                                <c:set var="nextDir" value="asc"/>

                                <c:if test="${order == 'price' && dir == 'asc'}">
                                    <c:set var="nextDir" value="desc"/>
                                </c:if>
                                <%-- price desc 상태에서 다시 클릭 시 기본(num)으로 복귀 --%>
                                <c:if test="${order == 'price' && dir == 'desc'}">
                                    <c:set var="nextOrder" value="num"/>
                                    <c:set var="nextDir" value="desc"/>
                                </c:if>

                                <a href="?type=${type}&keyword=${keyword}&order=${nextOrder}&dir=${nextDir}">
                                    가격
                                    <c:if test="${order == 'price'}">
                                        <c:choose>
                                            <c:when test="${dir == 'asc'}">▲</c:when>
                                            <c:when test="${dir == 'desc'}">▼</c:when>
                                        </c:choose>
                                    </c:if>
                                </a>
                            </th>

                            <th>작성자</th>
                            <th>작성일</th>
                        </tr>
                    </thead>

                    <%-- 상품 데이터 출력 영역 --%>
                    <tbody class="tbody">
                        <c:forEach var="product" items="${dto.list}">
                            <tr data-num="${product.num}">
                                <td><c:out value="${product.num}"/></td>

                                <%-- 상품 이미지 --%>
                                <td>
                                    <img src="/resources/images/${product.pictureurl}"
                                         alt="이미지"
                                         style="max-width:60px; max-height:60px;">
                                </td>

                                <%-- 상품명 (상세보기 링크) --%>
                                <td>
                                    <a href="/product/read/${product.num}">
                                        <c:out value="${product.name}"/>
                                    </a>
                                </td>

                                <td><c:out value="${product.category}"/></td>
                                <td>₩ <fmt:formatNumber value="${product.price}" type="number"/></td>
                                <td><c:out value="${product.regid}"/></td>
                                <td>${fn:replace(fn:substring(product.regdate, 0, 16), 'T', ' ')}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <%-- 페이징 처리 --%>
                <div class="d-flex justify-content-center">
                    <ul class="pagination" 
                         data-type="${type}" 
                         data-keyword="${keyword}" 
                         data-order="${order}" 
                         data-dir="${dir}">

                        <%-- 이전 페이지 --%>
                        <c:if test="${dto.prev}">
                            <li class="page-item">
                                <a class="page-link" href="${dto.start - 1}">Prev</a>
                            </li>
                        </c:if>

                        <%-- 페이지 번호 목록 --%>
                        <c:forEach var="num" items="${dto.pageNums}">
                            <li class="page-item ${dto.page == num ? 'active' : ''}">
                                <a class="page-link" href="${num}">${num}</a>
                            </li>
                        </c:forEach>

                        <%-- 다음 페이지 --%>
                        <c:if test="${dto.next}">
                            <li class="page-item">
                                <a class="page-link" href="${dto.end + 1}">Next</a>
                            </li>
                        </c:if>

                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<%-- 삭제 완료 알림 모달 --%>
<div class="modal" tabindex="-1" id="myModal">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title">Notification</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">
                <p><span id="modalResult"></span></p>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>

        </div>
    </div>
</div>

<script type="text/javascript" defer="defer">
    // 삭제 결과가 있을 경우 모달 표시
    const result = '${result}';

    if (result) {
        const myModal = new bootstrap.Modal(document.getElementById('myModal'));
        document.getElementById('modalResult').innerText = result;
        myModal.show();
    }

    // 페이징 클릭 이벤트 (JS로 page/size 유지)
    const pagingDiv = document.querySelector(".pagination");

    if (pagingDiv) {
        pagingDiv.addEventListener("click", (e) => {
            e.preventDefault();
            e.stopPropagation();

            const target = e.target;
            const targetPage = target.getAttribute("href");
            if (!targetPage || targetPage === '#') return;

            const size = ${dto.size} || 10;
            const type = pagingDiv.dataset.type || '';
            const keyword = pagingDiv.dataset.keyword || '';
            const order = pagingDiv.dataset.order || '';
            const dir = pagingDiv.dataset.dir || '';
            let url = `/product/list?page=\${targetPage}&size=\${size}`;
            if (type) url += `&type=\${encodeURIComponent(type)}`;
            if (keyword) url += `&keyword=\${encodeURIComponent(keyword)}`;
            if (order) url += `&order=\${encodeURIComponent(order)}`;
            if (dir) url += `&dir=\${encodeURIComponent(dir)}`;
            self.location = url;
        }, false);
    }
</script>

<%-- 공통 푸터 include --%>
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
