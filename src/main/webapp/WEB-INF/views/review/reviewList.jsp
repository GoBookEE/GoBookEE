<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.sql.Timestamp,java.util.List,com.gobookee.review.model.dto.*,com.gobookee.common.DateTimeFormatUtil"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
List<ReviewListResponse> reviews = (List<ReviewListResponse>) request.getAttribute("list");
%>
<style>
body {
	background-color: #f8f9fa;
}

.nav-tabs .nav-link.active {
	color: #198754;
	border-bottom: 2px solid #198754;
}

.review-card img {
	border-radius: 10px;
}

.review-meta {
	font-size: 0.85rem;
	color: #6c757d;
}
</style>
<main>
	<div class="container py-4">
		<!-- Category Tabs -->
		<ul class="nav nav-tabs mb-4">
			<li class="nav-item"><a class="nav-link" href="#">초등</a></li>
			<li class="nav-item"><a class="nav-link" href="#">중등</a></li>
			<li class="nav-item"><a class="nav-link" href="#">고등</a></li>
			<li class="nav-item"><a class="nav-link" href="#">수험서/자격증</a></li>
			<li class="nav-item"><a class="nav-link active" href="#">IT/개발</a>
			</li>
		</ul>

		<h5 class="mb-3 fw-bold">이번 달 베스트 리뷰</h5>
		<div class="row row-cols-1 row-cols-md-4 g-4 mb-5">
			<%if(reviews!=null&& !reviews.isEmpty()){ 
				for(ReviewListResponse b : reviews){%>
			<div class="col">
				<div class="card h-100 review-card"
					onclick="location.assign('<%=request.getContextPath()%>/review/reviewseq?seq=<%=b.getReviewSeq() %>')">
					<img src="images/book1.jpg" class="card-img-top" alt="book1">
					<div class="card-body">
						<h6 class="card-title"><%=b.getReviewTitle() %></h6>
						<p class="card-text small">자바를 처음 배우는 분들에게 강력 추천합니다.</p>
					</div>
					<div class="card-footer bg-white border-top-0">
						<small class="review-meta">★ <%=b.getReviewRate() %> | ♥ <%=b.getRecommendCount() %></small>
					</div>
				</div>
			</div>
		
		<%}
			}else{ %>
		<div>
			<p>조회된 데이터가 없습니다.</p>
			<div>
				<%} %>
			</div>

			<select id="sortSelect">
				<option value="latest">최신순</option>
				<option value="recommend">추천순</option>
			</select>
			<div id="reviewContainer" class="list-group"></div>

			<div id="pageBar"></div>

			<script>
const test = `${b.reviewTitle}`;
console.log("test:", test);
let currentSort = "latest"; // 현재 정렬 기준 기억

//정렬 드롭다운 이벤트
$(document).ready(function () {
    loadReviews("latest");

    $("#sortSelect").on("change", function () {
        currentSort = $(this).val();
        loadReviews(currentSort, 1);
    });

});

//페이지바 클릭 이벤트
$(document).on("click", "#pageBar a.page-link", function (e) {
 e.preventDefault();
 const page = $(this).data("page");
 if (page) {
     loadReviews(currentSort, page);
 }
});

function loadReviews(sortType,cPage = 1) {
    $.ajax({
        url: "<%=request.getContextPath()%>/review/sortlist",
        type: "GET",
        data: { sort: sortType, cPage: cPage },
        dataType: "json",
        success: function (response) {
            const container = $("#reviewContainer");
            const pageBarDiv = $("#pageBar");

            container.empty();
            pageBarDiv.empty();
            console.log(Array.isArray(response.reviews));
            const reviews = response.reviews;
            const pageBar = response.pageBar;
			console.log(reviews);
			console.log(pageBar);
            if (!reviews || reviews.length === 0) {
                container.append("<div>리뷰가 없습니다.</div>");
            } else {
                reviews.forEach(function (b) {
                	console.log(b);
                	console.log("test:", `${b.reviewTitle}`);
                	console.log(b.reviewTitle);
                	
                    const itemHtml = `
                    <div class="list-group-item list-group-item-action d-flex gap-3 py-4" 
                    onclick="location.assign('<%=request.getContextPath()%>/review/reviewseq?seq=\${b.reviewSeq}')">
                    	<img src='https://image.aladin.co.kr/product/36319/21/coversum/k442038541_1.jpg' 
                    	alt='latest1' width='100' height='120' class='rounded'>
                        <div class="d-flex flex-column">
                        	
                            <strong class="mb-1">\${b.reviewTitle}</strong>
                            <small class="text-muted">\${b.reviewContents}</small>
                            <small class="text-muted">\${b.bookTitle}</small>
                            <small class="review-meta mt-2">♥ \${b.recommendCount}</small>
                        </div>
                    </div>`;
                    console.log(itemHtml);
                    container.append(itemHtml);
                });
            }

            pageBarDiv.html(pageBar);
        },
        error: function () {
            alert("리뷰 불러오는 중 오류.");
        }
    });
}
</script>
		</div>
</main>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>