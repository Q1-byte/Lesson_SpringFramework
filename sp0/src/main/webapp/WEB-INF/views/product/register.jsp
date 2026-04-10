<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

        <%@include file="/WEB-INF/views/includes/header.jsp" %>

            <div class="row justify-content-center">
                <div class="col-lg-12">
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Product Register</h6>
                        </div>

                        <div class="card-body">
                            <form action="/product/register" method="post" enctype="multipart/form-data" class="p-3">
                                <div class="mb-3">
                                    <label class="form-label">Product Name</label>
                                    <input type="text" name="name" class="form-control" required>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Category</label>
                                    <input type="text" name="category" class="form-control">
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Price</label>
                                    <input type="number" name="price" class="form-control" required>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Description</label>
                                    <textarea class="form-control" name="description" rows="3"></textarea>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">상품 이미지</label>
                                    <input type="file" name="imageFile" class="form-control" accept="image/*">
                                    <div id="imagePreview" class="mt-2"></div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Register ID</label>
                                    <input type="text" name="regid" class="form-control" />
                                </div>

                                <div class="d-flex justify-content-end">
                                    <button type="submit" class="btn btn-primary btn-lg">Submit</button>
                                    <a href="/product/list" class="btn btn-secondary btn-lg ms-2">Cancel</a>
                                </div>
                            </form>

                            <script>
                                // 이미지 미리보기
                                document.querySelector('input[name="imageFile"]').addEventListener('change', function(e) {
                                    const preview = document.getElementById('imagePreview');
                                    preview.innerHTML = '';
                                    
                                    if (this.files && this.files[0]) {
                                        const reader = new FileReader();
                                        reader.onload = function(e) {
                                            preview.innerHTML = '<img src="' + e.target.result + '" style="max-width:200px; max-height:200px; border-radius:8px;">';
                                        }
                                        reader.readAsDataURL(this.files[0]);
                                    }
                                });
                            </script>
                        </div>

                    </div>
                </div>
            </div>


            <%@include file="/WEB-INF/views/includes/footer.jsp" %>