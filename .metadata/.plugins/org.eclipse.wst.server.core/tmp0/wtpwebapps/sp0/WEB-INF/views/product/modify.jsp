<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ include file="/WEB-INF/views/includes/header.jsp" %>

            <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
                <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

                    <div class="row justify-content-center">
                        <div class="col-lg-12">
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 fw-bold text-primary">Product Modify</h6>
                                </div>

                                <div class="card-body">
                                    <form id="actionForm" action="/product/modify" method="post" enctype="multipart/form-data">

                                        <div class="mb-3 input-group input-group-lg">
                                            <span class="input-group-text">Num</span>
                                            <input type="text" name="num" class="form-control"
                                                value="<c:out value='${product.num}'/>" readonly>
                                        </div>

                                        <div class="mb-3 input-group input-group-lg">
                                            <span class="input-group-text">Name</span>
                                            <input type="text" name="name" class="form-control"
                                                value="<c:out value='${product.name}'/>">
                                        </div>

                                        <div class="mb-3 input-group input-group-lg">
                                            <span class="input-group-text">Category</span>
                                            <input type="text" name="category" class="form-control"
                                                value="<c:out value='${product.category}'/>">
                                        </div>

                                        <div class="mb-3 input-group input-group-lg">
                                            <span class="input-group-text">Price</span>
                                            <input type="number" name="price" class="form-control"
                                                value="<c:out value='${product.price}'/>">
                                        </div>

                                        <div class="mb-3 input-group input-group-lg">
                                            <span class="input-group-text">Description</span>
                                            <textarea class="form-control" name="description"
                                                rows="3"><c:out value="${product.description}"/></textarea>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label fw-bold">상품 이미지</label>
                                            <div id="currentImage" class="mb-2">
                                                <c:if test="${not empty product.pictureurl}">
                                                    <p class="text-muted small">현재 이미지:</p>
                                                    <img src="/resources/images/${product.pictureurl}" 
                                                         style="max-width:150px; max-height:150px; border-radius:8px; border:1px solid #ddd;">
                                                </c:if>
                                            </div>
                                            <input type="file" name="imageFile" class="form-control" accept="image/*">
                                            <input type="hidden" name="pictureurl" value="<c:out value='${product.pictureurl}'/>">
                                            <div id="imagePreview" class="mt-2"></div>
                                            <small class="text-muted">새 이미지를 선택하면 기존 이미지가 교체됩니다.</small>
                                        </div>

                                        <div class="mb-3 input-group input-group-lg">
                                            <span class="input-group-text">Writer</span>
                                            <input type="text" name="regid" class="form-control"
                                                value="<c:out value='${product.regid}'/>" readonly>
                                        </div>

                                        <div class="mb-3 input-group input-group-lg">
                                            <span class="input-group-text">RegDate</span>
                                            <input type="text" class="form-control"
                                                value="${fn:replace(fn:substring(product.regdate, 0, 16), 'T', ' ')}" readonly>
                                            <input type="hidden" name="regdate" value="<c:out value='${product.regdate}'/>">
                                        </div>

                                    </form>

                                    <div class="float-end">
                                        <button type="button" class="btn btn-info btnList">목록</button>

                                        <sec:authentication property="principal" var="secInfo" />
                                        <sec:authentication property="authorities" var="roles" />

                                        <c:if test="true">
                                            <button type="button" class="btn btn-warning btnModify">수정</button>
                                            <button type="button" class="btn btn-danger btnRemove">삭제</button>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <script type="text/javascript">

                        const formObj = document.querySelector("#actionForm");
                        document.querySelector(".btnModify").addEventListener("click", () => {
                            formObj.action = "/product/modify";
                            formObj.method = "post";
                            formObj.submit();
                        });

                        document.querySelector(".btnList").addEventListener("click", () => {
                            self.location = "/product/list";
                        });

                        document.querySelector(".btnRemove").addEventListener("click", () => {
                            formObj.action = "/product/remove";
                            formObj.method = "post";
                            formObj.submit();
                        });

                        // 이미지 미리보기
                        document.querySelector('input[name="imageFile"]').addEventListener('change', function(e) {
                            const preview = document.getElementById('imagePreview');
                            preview.innerHTML = '';
                            
                            if (this.files && this.files[0]) {
                                const reader = new FileReader();
                                reader.onload = function(e) {
                                    preview.innerHTML = '<p class="text-muted small">새 이미지:</p><img src="' + e.target.result + '" style="max-width:150px; max-height:150px; border-radius:8px; border:1px solid #ddd;">';
                                }
                                reader.readAsDataURL(this.files[0]);
                            }
                        });
                    </script>


                    <%@ include file="/WEB-INF/views/includes/footer.jsp" %>