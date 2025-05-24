<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.sql.Timestamp,java.util.List,com.gobookee.review.model.dto.*,com.gobookee.common.DateTimeFormatUtil"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
ReviewViewResponse review = (ReviewViewResponse) request.getAttribute("review");
List<CommentsViewResponse> comments = review.getComments();
%>
<section>
	<main>
		<div class="container py-4">
			<!-- 이전/더보기 상단 바 -->
			<div
				class="d-flex justify-content-between align-items-center py-2 border-bottom mb-3">
				<button class="btn btn-link text-dark text-decoration-none"
					onclick="history.back()">
					<i class="bi bi-arrow-left"></i> 뒤로
				</button>
				<div class="dropdown">
					<button class="btn btn-link text-dark" id="moreMenu"
						data-bs-toggle="dropdown" aria-expanded="false">
						<i class="bi bi-three-dots-vertical"></i>
					</button>
					<ul class="dropdown-menu dropdown-menu-end"
						aria-labelledby="moreMenu">
						<li><a class="dropdown-item" href="#">게시물 수정</a></li>
						<li><a class="dropdown-item" href="#">게시물 삭제</a></li>
					</ul>
				</div>
			</div>

			<!-- 상단 태그 -->
			<div class="mb-2 text-muted small">IT/개발</div>

			<!-- 제목 -->
			<h5 class="fw-bold mb-2">예시가 깔끔한 스프링 데이터 입문자 가이드 추천</h5>

			<!-- 유저 정보 -->
			<div class="d-flex align-items-center mb-3">
				<img src="https://via.placeholder.com/40"
					class="rounded-circle me-2" alt="user" width="40" height="40">
				<div>
					<div class="fw-semibold">on.the.milkyway</div>
					<small class="text-muted">2025.5.3</small>
				</div>
			</div>

			<!-- 책 정보 카드 -->
			<div
				class="d-flex border rounded p-3 mb-3 align-items-center bg-light">
				<img
					src="https://image.aladin.co.kr/product/36319/21/coversum/k442038541_1.jpg"
					alt="book-cover" width="90" height="120" class="me-3 rounded">
				<div>
					<h6 class="mb-1"><%=review.getBookTitle()%></h6>
					<p class="mb-1 text-muted small">초보자를 위한 프로젝트로 배우는 프로젝트 예제 중심의
						스프링 데이터 실습서</p>
					<div class="text-muted small">황재호 저 | 맹구출판 | 2015년 8월</div>
					<div class="review-meta mt-2">
						리뷰 <strong><%=review.getRecommendCount()%></strong>개 | 평점 <strong
							class="text-success">★ 4.0</strong>
					</div>
				</div>
			</div>

			<!-- 본문 내용 -->
			<p class="mb-3">정리로운 내용을 알기 쉽게 구성으로 입문자에게 뛰어난 느낌을 지울 수 없습니다. 저자의
				노력과 그만큼의 노하우는 정성스러운 책 내용에서도 보입니다...</p>

			<!-- 추천/공유 버튼 -->
			<div class="d-flex align-items-center gap-3 mb-3">
				<div class="text-success d-flex align-items-center">
					<i class="bi bi-hand-thumbs-up-fill me-1"></i> 35
				</div>
				<div class="text-muted d-flex align-items-center">
					<i class="bi bi-chat-left-text me-1"></i> 2
				</div>
				<div class="text-muted ms-auto">
					<i class="bi bi-share-fill"></i>
				</div>
			</div>

			<!-- 댓글 영역 -->
			<!-- <div class="border-top pt-3">
            <h6 class="fw-bold">댓글</h6>
            <p class="text-muted small">등록된 댓글이 없습니다.</p>
            <form class="d-flex mt-2">
                <input type="text" class="form-control me-2" placeholder="댓글을 입력하세요">
                <button class="btn btn-outline-success">등록</button>
            </form>
        </div> -->
			<div class="border-top pt-3">
				<h6 class="fw-bold mb-3">댓글</h6>
				<%-- 댓글 작성 폼 --%>
				<form class="d-flex mt-3" method="post"
					action="<%=request.getContextPath()%>/review/insertComment">
					<input type="hidden" name="reviewSeq"
						value="<%=review.getReviewSeq()%>"> <input type="text"
						class="form-control me-2" name="commentContent"
						placeholder="댓글을 입력하세요">
					<button class="btn btn-outline-success">등록</button>
				</form>
				<%-- <%
				if (comments != null && comments.size() > 0) {
					for (CommentsViewResponse c : comments) {
						boolean isReply = (c.getCommentLevel() != 1);
				%>
				<div
					class="border rounded p-2 mb-2 <%=isReply ? "ms-4 bg-light" : ""%>">
					<div class="d-flex justify-content-between">
						<div>
							<strong><%=c.getUserNickName()%></strong> <small
								class="text-muted ms-2"> <%=DateTimeFormatUtil.format(c.getCommentsCreateTime())%>
							</small>
						</div>
						<%
						if (!isReply) {
						%>
						<button class="btn btn-sm btn-outline-secondary btn-insert2"
							value="<%=c.getCommentsSeq()%>">답글</button>
						<%
						}
						%>
					</div>
					<div class="mt-1"><%=c.getCommentsContents()%></div>
				</div>
				<%
				}
				} else {
				%>
				<p class="text-muted small">등록된 댓글이 없습니다.</p>
				<%
				}
				%> --%>
				<%
				if (comments != null && comments.size() > 0) {
					for (CommentsViewResponse c : comments) {
						boolean isReply = (c.getCommentLevel() != 1);
				%>
				<%-- 댓글 (레벨 1) --%>
				<%
				if (!isReply) {
				%>
				<div class="border rounded p-2 mb-2">
					<div class="d-flex justify-content-between">
						<div>
							<strong><%=c.getUserNickName()%></strong> <small
								class="text-muted ms-2"><%=DateTimeFormatUtil.format(c.getCommentsCreateTime())%></small>
						</div>
						<div>
							<button class="btn btn-sm btn-outline-secondary btn-reply-toggle"
								data-comment-id="<%=c.getCommentsSeq()%>">답글</button>
						</div>
					</div>
					<div class="mt-1"><%=c.getCommentsContents()%></div>

					<!-- 대댓글 영역 (토글) -->
					<%-- <div class="child-comments mt-2 d-none"
						id="child-comments-<%=c.getCommentsSeq()%>"> --%>
						<!-- 댓글의 대댓글 영역 -->
	<div class="child-comments mt-2" id="child-comments-<%= c.getCommentsSeq() %>" style="display: none;">
						
						<%
						for (CommentsViewResponse child : comments) {
							if (child.getCommentLevel() == 2 && child.getCommentsParentSeq() == c.getCommentsSeq()) {
						%>
						<div class="border rounded p-2 mb-2 bg-light ms-4">
							<div class="d-flex justify-content-between">
								<div>
									<strong><%=child.getUserNickName()%></strong> <small
										class="text-muted ms-2"><%=DateTimeFormatUtil.format(child.getCommentsCreateTime())%></small>
								</div>
							</div>
							<div class="mt-1"><%=child.getCommentsContents()%></div>
						</div>
						<%
						}
						}
						%>
						<%-- ✅ 대댓글 입력창 --%>
            <form class="d-flex mt-2 ms-4" method="post" action="<%=request.getContextPath()%>/review/insertComment">
                <input type="hidden" name="reviewSeq" value="<%= review.getReviewSeq() %>">
                <input type="hidden" name="parentCommentSeq" value="<%= c.getCommentsSeq() %>">
                <input type="text" class="form-control me-2" name="commentContent" placeholder="답글을 입력하세요">
                <button class="btn btn-outline-secondary btn-sm">등록</button>
            </form>
					</div>
				</div>
				<%
				}
				%>
				<%
				}
				} else {
				%>
				<p class="text-muted small">등록된 댓글이 없습니다.</p>
				<%
				}
				%>


				
			</div>

		</div>

	</main>
</section>
<!-- <script>
$(document).ready(function () {
    // 답글 보기 토글
    $(".btn-reply-toggle").on("click", function () {
        const id = $(this).data("comment-id");
        $("#child-comments-" + id).slideToggle(200);

        const btn = $(this);
        const isShown = $("#child-comments-" + id).is(":visible");
        btn.text(isShown ? "답글 닫기" : "답글");
    });
});
</script> -->
<script>
$(document).ready(function () {
    $(".btn-reply-toggle").on("click", function () {
        const id = $(this).data("comment-id");
        const target = $("#child-comments-" + id);
        
        // 문제 디버깅용 로그
        console.log("Toggle ID:", id);
        console.log("Element found?", target.length);

        target.slideToggle(200, function () {
            const isShown = target.is(":visible");
            $(`button[data-comment-id='${id}']`).text(isShown ? "답글 닫기" : "답글");
        });
    });
});
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>