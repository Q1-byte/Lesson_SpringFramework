<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


                <%@ include file="/WEB-INF/views/includes/header.jsp" %>




	<div class="container my-5">
		<div class="row justify-content-center">
			<div class="col-lg-6 col-md-8">
				<div class="card shadow-sm border-0" style="background:#fff;">
					<div class="p-4 pb-0 text-center border-bottom">
						<div class="mx-auto mb-3" style="background:#f5f6fa;border-radius:12px;width:180px;height:180px;display:flex;align-items:center;justify-content:center;">
							<img src="/resources/images/<c:out value='${product.pictureurl}'/>" alt="상품 이미지" style="max-width:140px;max-height:140px;object-fit:contain;" />
						</div>
						<h2 class="fw-bold mb-1" style="font-size:2rem;letter-spacing:-1px;"><c:out value='${product.name}'/></h2>
						<div class="mb-2">
							<span class="badge bg-primary" style="font-size:1em;"><c:out value='${product.category}'/></span>
						</div>
						<div class="mb-2">
							<span class="text-muted small">상품번호 <c:out value='${product.num}'/></span>
						</div>
						<div class="mb-3">
							<span class="fw-bold" style="font-size:1.1rem;color:#222;">₩ <fmt:formatNumber value="${product.price}" type="number"/></span>
						</div>
					</div>
					<div class="p-4">
						<div class="mb-4">
							<div class="text-secondary small mb-1">상품설명</div>
							<div class="border rounded p-3 bg-light" style="min-height:80px;">
								<c:out value='${product.description}'/>
							</div>
						</div>
						<div class="row g-2 mb-3">
							<div class="col-6">
								<div class="text-muted small">작성자</div>
								<div class="fw-semibold"><c:out value='${product.regid}'/></div>
							</div>
							<div class="col-6">
								<div class="text-muted small">등록일</div>
								<div class="fw-semibold">${fn:replace(fn:substring(product.regdate, 0, 16), 'T', ' ')}</div>
							</div>
						</div>
						<div class="d-flex gap-2 justify-content-end mt-4">
								<a href='/product/list' class="btn btn-outline-primary px-4">목록</a>
								<a href='/product/modify/${product.num}' class="btn btn-warning px-4">수정</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="row justify-content-center mt-4">
		<div class="col-lg-6 col-md-8">
			<div class="card border-0 shadow-sm mb-4">
				<div class="card-header bg-white border-bottom pb-2">
					<strong>댓글</strong>
				</div>
				<div class="card-body p-3">
					<!-- 댓글 목록 -->
					<ul class="list-group mb-3" id="replyList">
						<!-- JS로 동적 렌더링 -->
					</ul>
					<!-- 댓글 입력 -->
					<form id="replyForm" class="d-flex gap-2">
						<input type="text" id="replyText" class="form-control" maxlength="200" placeholder="댓글을 입력하세요" required>
						<input type="text" id="replyer" class="form-control" maxlength="20" placeholder="작성자" required style="max-width:120px;">
						<input type="hidden" id="num" value="${product.num}" />
						<button type="submit" class="btn btn-primary">등록</button>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script>
		const productNum = document.getElementById('num').value;

		// 댓글 목록 불러오기
		function loadReplies() {
		fetch('/reply/list/' + productNum)
			.then(res => res.json())
			.then(list => {
			const ul = document.getElementById('replyList');
			ul.innerHTML = '';

			// 댓글이 없을 경우
			if (list.length === 0) {
				ul.innerHTML =
				'<li class="list-group-item text-center text-muted">댓글이 없습니다.</li>';
				return;
			}

			// 댓글 목록 출력
			list.forEach(reply => {
				const li = document.createElement('li');
				li.className =
				'list-group-item d-flex justify-content-between align-items-center';

				li.innerHTML = `
				<div>
					<span class="fw-semibold">\${reply.replyer}</span>
					<span class="text-muted small ms-2">
					\${reply.replydate ? new Date(reply.replydate).toISOString().substring(0, 10) : ''}
					</span><br>
					<span>\${reply.replyText}</span>
				</div>
				<button
					class="btn btn-sm btn-outline-danger"
					onclick="removeReply(\${reply.rno})">
					삭제
				</button>
				`;

				ul.appendChild(li);
			});
			});
		}

		// 댓글 등록 처리
		document
		.getElementById('replyForm')
		.addEventListener('submit', function (e) {
			e.preventDefault();

			const replyText = document.getElementById('replyText').value.trim();
			const replyer = document.getElementById('replyer').value.trim();

			// 입력값 검증
			if (!replyText || !replyer) return;

			fetch('/reply/register', {
			method: 'POST',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify({
				replyText,
				replyer,
				num: productNum
			})
			})
			.then(res => res.json())
			.then(() => {
				document.getElementById('replyText').value = '';
				loadReplies();
			});
		});

		// 댓글 삭제 처리
		function removeReply(rno) {
		if (!confirm('댓글을 삭제하시겠습니까?')) return;
	
		fetch('/reply/remove/' + rno, { method: 'POST' })
			.then(res => res.json())
			.then(() => loadReplies());
		}
	
	  // 페이지 로드시 댓글 목록 호출
		loadReplies();
	</script>


		<%@ include file="/WEB-INF/views/includes/footer.jsp" %>