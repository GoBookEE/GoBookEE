<%@ page pageEncoding="UTF-8" language="java" %>
<%@include file="WEB-INF/views/common/header.jsp" %>
<%@ page import="com.gobookee.users.model.dto.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.gobookee.main.model.dto.ReviewTopResponse" %>
<%@ page import="com.gobookee.review.model.dto.ReviewListResponse" %>
<%@ page import="com.gobookee.book.model.dto.Book" %>
<%@ page import="com.gobookee.study.model.dto.StudyList" %>
<%@ page import="com.gobookee.place.model.dto.PlaceViewResponse" %>
<%@ page import="com.gobookee.study.model.dto.Study" %>
<%
    List<ReviewTopResponse> top3review = (List<ReviewTopResponse>) request.getAttribute("top3review");
    List<ReviewListResponse> recent10review = (List<ReviewListResponse>) request.getAttribute("recent10review");
    List<Book> hot5book = (List<Book>) request.getAttribute("hot5book");
    List<Book> top9book = (List<Book>) request.getAttribute("top9book");
    List<StudyList> top9study = (List<StudyList>) request.getAttribute("top9study");
    List<PlaceViewResponse> ran5place = (List<PlaceViewResponse>) request.getAttribute("ran5place");
    List<User> top3user = (List<User>) request.getAttribute("top3user");

%>
<style>
    .number {
        display: flex;
        flex-direction: row;
        justify-content: space-between;
        height: 14px;
    }

    .progress {
        border-radius: 50px;
        background-color: #C1DFC6;
    }

    .progress-bar.bg-success {
        background: linear-gradient(90deg, #3D6C44 0%, #50A65D 100%);
        border-radius: 30px;
    }

    .rank-progress {
        position: relative;
        height: 20px;
        background: #d0ead0;
        border-radius: 30px;
        flex: 1;
        overflow: hidden;
    }

    .rank-bar {
        height: 100%;
        background: linear-gradient(to right, #198754, #40c870);
        border-radius: 30px;
    }

</style>
<script src="https://unpkg.com/fast-average-color/dist/index.browser.min.js"></script>
<main>
    <%
        if (loginUser != null) {
        }
    %>
    <div class="fw-bold d-flex justify-content-between align-items-center" style="padding: 20px 30px 0 20px;">
        <div style="font-size: 20px;color: #50A65D">리뷰 랭킹 TOP3 👑</div>
        <div style="font-size: 14px; cursor: pointer;"
             onclick="location.assign('<%=request.getContextPath()%>/review/listpage')">더보기<i
                style="font-size: 14px;padding-left: 5px;" class="bi bi-chevron-right"></i>
        </div>
    </div>
    <%
        int rank = 1;
        String rkIcon = "";
        for (ReviewTopResponse b : top3review) {
    %>

    <div class="book-card" style="box-shadow: none"
         onclick="location.assign('<%=request.getContextPath()%>/review/view?seq=<%=b.getReviewSeq()%>')">
        <div class="row book-card-row">
            <div class="book-card-img2 col col-3" style="overflow: hidden; padding: 20px ;height: 147px">
                <%
                    switch (rank) {
                        case 1:
                            rkIcon = "\uD83E\uDD47";
                            break;
                        case 2:
                            rkIcon = "🥈";
                            break;
                        case 3:
                            rkIcon = "🥉";
                            break;
                    }
                %>
                <i class="medal-icon"><%=rkIcon%>
                </i>
                <img src='<%=b.getBookCover()%>' alt='book cover'>
            </div>
            <div class="book-card-content col col-8">
                <div class="d-flex flex-column flex-grow-1">
                    <div class="book-card-t2"><%=b.getReviewTitle()%>
                    </div>
                    <div class="book-card-c2"><%=b.getReviewContents()%>
                    </div>
                    <div class="book-card-c3"><%=b.getBookTitle()%>
                    </div>
                    <div class="book-card-c2" style="color: #AFAFAF"><%=b.getBookAuthor()%> | <%=b.getBookPublisher()%>
                        | <%=b.getBookPubdate()%>
                    </div>
                </div>
                <div class="book-card-c4">
                    <div>
                        <div><i class="bi bi-star-fill"
                                style="font-size: 0.9rem; margin-right: 5px; color: #50A65D"></i><%=b.getReviewRate()%>
                        </div>
                    </div>
                    <div class="d-flex">
                        <div class="d-flex align-items-center text-muted">
                            <i class="bi bi-heart" style="font-size: 0.9rem; margin: 0;"></i> <%=b.getRecommendCount()%>
                        </div>
                        <div class="d-flex align-items-center text-muted">
                            <i class="bi bi-chat" style="font-size: 0.9rem; margin: 0;"></i> <%=b.getCommentsCount()%>
                        </div>
                    </div>

                </div>
            </div>

        </div>
    </div>
    <% rank++;
    } %>
    <div class="fw-bold d-flex justify-content-between align-items-center" style="padding: 20px 30px 0 20px;">
        <div style="font-size: 20px;color: #50A65D">따끈따끈한 리뷰!🔥</div>
        <div style="font-size: 14px; cursor: pointer;"
             onclick="location.assign('<%=request.getContextPath()%>/review/listpage')">더보기<i
                style="font-size: 14px;padding-left: 5px;" class="bi bi-chevron-right"></i>
        </div>
    </div>
    <div class="scroll-container book-card-scroll">
        <% for (ReviewListResponse b : recent10review) { %>
        <div class="card h-100 review-card scroll-item"
             onclick="location.assign('<%=request.getContextPath()%>/review/view?seq=<%=b.getReviewSeq() %>')">
            <div style="height: 170px;overflow: hidden;" class="book-card-img2">
                <img style="height: 90%;" src="<%=b.getBookCover() %>" alt="book1">
            </div>
            <div class="card-body" style="height: 120px">
                <h6 class="book-card-t2"><%=b.getReviewTitle() %>
                </h6>
                <p class="book-card-c2"><%=b.getReviewContents()%>
                </p>
                <div class="book-card-c3"><%=b.getBookTitle()%>
                </div>
            </div>
            <div class="card-footer bg-white border-top-0">
                <small class="review-meta">
                    <div><i class="bi bi-star-fill"
                            style="font-size: 0.9rem; margin-right: 5px; color: #50A65D"></i><%=b.getReviewRate()%>
                    </div>
                    <div><i class="bi bi-chat"
                            style="font-size: 0.9rem;margin-right: 4px"></i> <%=b.getCommentsCount()%>
                    </div>
                </small>
            </div>
        </div>
        <% } %>
    </div>
    <div class="fw-bold d-flex justify-content-between align-items-center" style="padding: 20px 30px 0 20px;">
        <div style="font-size: 20px;color: #50A65D">지금 뜨는 교육도서! 📚</div>
        <div style="font-size: 14px; cursor: pointer;"
             onclick="location.assign('<%=request.getContextPath()%>/books/booklist')">더보기
            <i style="font-size: 14px;padding-left: 5px;" class="bi bi-chevron-right"></i>
        </div>
    </div>
    <div class="scroll-container book-card-scroll">
        <% for (Book b : hot5book) { %>
        <div class="card h-100 review-card scroll-item" style=" width: 200px;"
             onclick="location.assign('<%=request.getContextPath()%>/books/bookdetail?bookSeq=<%=b.getBookSeq()%>')">
            <div style="height: 250px;overflow: hidden;" class="book-card-img2">
                <img style="height: 80%;" src="<%=b.getBookCover() %>" alt="book1">
            </div>

        </div>
        <% } %>
    </div>
    <div class="fw-bold d-flex justify-content-between align-items-center" style="padding: 20px 30px 0 20px;">
        <div style="font-size: 20px;color: #50A65D">리뷰가 많은 도서 랭킹 📝</div>
        <div style="font-size: 14px; cursor: pointer;"
             onclick="location.assign('<%=request.getContextPath()%>/books/booklist')">더보기
            <i style="font-size: 14px;padding-left: 5px;" class="bi bi-chevron-right"></i>
        </div>
    </div>
    <div class="scroll-container2">
        <%
            int count = 1;
            for (Book b : top9book) {
        %>
        <%if (count == 1 || count == 4 || count == 7) {%>
        <div class="book-group"><%}%>
            <div class="p-4 book-card" style="margin:0;"
                 onclick="location.assign('<%=request.getContextPath()%>/books/bookdetail?bookSeq=<%=b.getBookSeq()%>')">
                <div class="row book-card-row">
                    <div class="book-card-img2 col col-4" style="overflow: hidden; padding: 20px ;height: 180px">
                        <img src='<%=b.getBookCover()%>' alt='book cover'>
                    </div>
                    <div class="book-card-content col col-8">
                        <div class="book-card-title"><%=b.getBookTitle()%>
                        </div>
                        <div class="book-card-c2" style="font-size: 15px !important;">
                            <%
                                List aut = List.of(b.getBookAuthor().split(", "));
                                for (Object a : aut) {
                            %>
                            <span><%=a.toString().split(" ")[0]%></span>
                            <%}%>
                        </div>
                        <div class="book-card-c2" style="font-size: 15px !important;">
                            <%=b.getBookPublisher()%> | <%=b.getBookPubdate()%>
                        </div>
                        <div class="book-card-c2" style="font-size: 15px !important;">

                            리뷰 <span><%=b.getReviewCount()%>개</span> <i class="bi bi-star-fill"
                                                                        style="color:#50A65D; font-size: 15px !important;"> </i><%=Math.ceil(b.getReviewRateAvg() * 100) / 100%>
                        </div>
                    </div>

                </div>
            </div>
            <%if (count == 3 || count == 6 || count == 9) {%></div>
        <%
                }
                count++;
            }
            if ((count - 1) % 3 != 0) {
        %></div>
    <%}%>
    </div>
    <div class="fw-bold d-flex justify-content-between align-items-center" style="padding: 20px 30px 0 20px;">
        <div style="font-size: 20px;color: #50A65D">지금 뜨는 스터디 ✏️</div>
        <div style="font-size: 14px; cursor: pointer;"
             onclick="location.assign('<%=request.getContextPath()%>/study/listpage')">더보기
            <i style="font-size: 14px;padding-left: 5px;" class="bi bi-chevron-right"></i>
        </div>
    </div>
    <div class="scroll-container2">
        <%
            count = 1;
            for (StudyList s : top9study) {
        %>
        <%if (count == 1 || count == 4 || count == 7) {%>
        <div class="book-group"><%}%>
            <div class="p-4 book-card" style="margin:0;"
                 onclick="location.assign('<%=request.getContextPath()%>/study/view?seq=<%=s.getStudySeq()%>')">
                <div class="row book-card-row">
                    <%
                        String img = s.getPhotoRenamedName();
                        if (img == null || img.isBlank()) {
                    %>
                    <div class="study-card-img2 col col-4" style="overflow: hidden; padding: 20px ;height: 180px">
                        <img src="<%=request.getContextPath()%>/resources/images/default.png">
                    </div>
                    <%} else {%>
                    <div class="study-card-img2 col col-4" style="overflow: hidden; padding: 20px ;height: 180px">
                        <img src="<%=request.getContextPath()%>/resources/upload/study/<%=img%>"
                             onerror="this.src='<%=request.getContextPath()%>/resources/images/default.png'">
                    </div>
                    <%}%>

                    <div class="book-card-content col col-8">
                        <div class="book-card-title"><%=s.getStudyTitle()%>
                        </div>
                        <div class="book-card-c2" style="font-size: 15px !important;">
                            <i class="bi bi-calendar-date me-1" style="font-size: 0.9rem; color: #50A65D"></i>
                            <span><%=s.getStudyDate() != null ? s.getStudyDate() : "날짜 미입력"%></span>
                        </div>

                        <div class="book-card-c2" style="font-size: 15px !important;">
                            <i class="bi bi-people-fill me-1" style="font-size: 0.9rem; color: #50A65D"></i>
                            <%=s.getConfirmedCount() + 1%> / <%=s.getStudyMemberLimit()%>
                        </div>
                        <div class="book-card-c2" style="font-size: 15px !important;">
                            <i class="bi bi-geo-alt-fill me-1" style="font-size: 0.9rem; color: #50A65D"></i>
                            <span><%=s.getStudyAddress() != null ? s.getStudyAddress() : "주소미입력"%></span>
                        </div>
                        <div class="book-card-c2" style="font-size: 15px !important;">
                            <i class="bi bi-hand-thumbs-up-fill me-1" style="font-size: 0.9rem; color: #50A65D"></i>
                            <span style="margin-right: 10px"><%=s.getLikeCount()%>개</span>
                            <i class="bi bi-hand-thumbs-down me-1" style="font-size: 0.9rem; color: #50A65D"></i>
                            <span><%=s.getDislikeCount()%>개</span>
                        </div>
                    </div>
                </div>
            </div>
            <%if (count == 3 || count == 6 || count == 9) {%></div>
        <%
                }
                count++;
            }
            if ((count - 1) % 3 != 0) {
        %></div>
    <%}%>
    </div>
    <div class="fw-bold d-flex justify-content-between align-items-center" style="padding: 20px 30px 0 20px;">
        <div style="font-size: 20px;color: #50A65D"> 스터디 여기 어때? 🧐</div>
        <div style="font-size: 14px; cursor: pointer;"
             onclick="location.assign('<%=request.getContextPath()%>/place/listpage')">더보기
            <i style="font-size: 14px;padding-left: 5px;" class="bi bi-chevron-right"></i>
        </div>

    </div>
    <div class="scroll-container book-card-scroll">
        <% for (PlaceViewResponse p : ran5place) { %>
        <div class="card h-100 review-card scroll-item"
             onclick="location.assign('<%=request.getContextPath()%>/place/view?placeSeq=<%=p.getPlaceSeq() %>')">
            <%
                List imglist = p.getPhotoNames();
                if (imglist == null || imglist.size() == 0) {
            %>
            <div class="study-card-img2" style="overflow: hidden; padding: 20px ;height: 180px">
                <img style="width: 100%;" src="<%=request.getContextPath()%>/resources/images/default.png">
            </div>
            <%} else {%>
            <div class="study-card-img2" style="overflow: hidden; padding: 20px ;height: 180px">
                <img style="width: 100%;height: auto"
                     src="<%=request.getContextPath()%>/resources/upload/place/<%=imglist.get(0)%>"
                     onerror="this.src='<%=request.getContextPath()%>/resources/images/default.png'">
            </div>
            <%}%>
            <div class="card-body" style="height: 120px">
                <h6 class="book-card-t2"><%=p.getPlaceTitle() %>
                </h6>
                <p class="book-card-c2"><%=p.getPlaceContents()%>
                </p>
            </div>
            <div class="card-footer bg-white border-top-0">
                <div class="book-card-c2" style="font-size: 15px !important;">
                    <i class="bi bi-hand-thumbs-up-fill me-1" style="font-size: 0.9rem; color: #50A65D"></i>
                    <span style="margin-right: 10px"><%=p.getPlaceRecCount()%>개</span>
                    <i class="bi bi-hand-thumbs-down me-1" style="font-size: 0.9rem; color: #50A65D"></i>
                    <span><%=p.getPlaceNonRecCount()%>개</span>
                </div>

            </div>
        </div>
        <% } %>
    </div>

    <div class="fw-bold d-flex justify-content-between align-items-center" style="padding: 20px 30px 0 20px;">
        <div style="font-size: 20px;color: #50A65D">재미로 보는 고북이 랭킹 🐢</div>
        <div style="font-size: 14px; cursor: pointer;"
             onclick="location.assign('<%=request.getContextPath()%>/ranking/speed')">
            더보기<i style="font-size: 14px;padding-left: 5px;" class="bi bi-chevron-right"></i>
        </div>
    </div>
    <%
        rank = 1;
        rkIcon = "";
        for (User ur : top3user) {
    %>
    <div class="book-card" style="box-shadow: none;border-radius: 0;">
        <div class="row profile-card-row">
            <%
                switch (rank) {
                    case 1:
                        rkIcon = "\uD83E\uDD47";
                        break;
                    case 2:
                        rkIcon = "🥈";
                        break;
                    case 3:
                        rkIcon = "🥉";
                        break;
                }
            %>
            <div style="display: flex; flex-direction: row">
            <div class="rank-label col col-1"><i class="medal-icon-profile"><%=rkIcon%>
            </i></div>
            <div class="profile-img col col-2" style="margin-right: 10px">
                <img src="<%=request.getContextPath()%>/resources/upload/user/<%=ur.getUserProfile()%>"
                     onerror="this.src='<%=request.getContextPath()%>/resources/images/default.png'">
            </div>
            <div style="flex: 1;">
                <div><strong><%=ur.getUserNickName()%>
                </strong> 님 고북이
                </div>
                <div><%=ur.getUserSpeed()%>km/h로 달리는 중!</div>
                <%
                    long speed = ur.getUserSpeed();
                    int progressPercent = 0;
                    double logoLeftPercent = 0;
                    String speedIconPath = "";

                    if (speed >= 0) {
                        if (speed >= 1000) {
                            speedIconPath = request.getContextPath() + "/resources/images/rocket.png";
                        } else if (speed >= 500) {
                            speedIconPath = request.getContextPath() + "/resources/images/airplane.png";
                        } else if (speed >= 300) {
                            speedIconPath = request.getContextPath() + "/resources/images/train.png";
                        } else if (speed >= 50) {
                            speedIconPath = request.getContextPath() + "/resources/images/car.png";
                        } else if (speed >= 10) {
                            speedIconPath = request.getContextPath() + "/resources/images/bike.png";
                        } else {
                            speedIconPath = request.getContextPath() + "/resources/images/walk.png";
                        }

                        double ratio = Math.min(speed, 1000) / 1000.0;
                        progressPercent = (int) (ratio * 100);
                        logoLeftPercent = ratio * 100;
                    } else {
                        speed = 0L;
                        progressPercent = 0;
                        logoLeftPercent = 0;
                        speedIconPath = request.getContextPath() + "/resources/images/sad.png";
                    }

                    double adjustedLeftPercent = logoLeftPercent - 3;
                %>
                <div class="progress" style="height: 25px; width: 400px; position: relative; overflow: visible; border-radius: 50px;">
                    <div class="progress-bar bg-success"
                         role="progressbar"
                         style="width: <%=progressPercent%>% ; border-radius: 30px;"
                         aria-valuenow="<%=speed%>"
                         aria-valuemin="0" aria-valuemax="1000">
                    </div>

                    <!-- 속도 아이콘 -->
                    <span style="
                            position: absolute;
                            top: -20px; /* 바깥으로 띄움 */
                            left: <%=adjustedLeftPercent%>%;
                            transform: translateX(-50%);
                            z-index: 10;">
    <img src="<%=speedIconPath%>"
         style="width: 50px; height: 50px; object-fit: contain;">
  </span>
                </div>

                <!-- 숫자 라벨 -->
                <div class="d-flex justify-content-between" style="width: 400px;">
                    <span>1</span><span>2</span><span>3</span><span>4</span><span>5</span>
                </div>
                </div>
            </div>
        </div>
    </div>
    </div>
    <% rank++;
    } %>
</main>
<script>
    const fac = new FastAverageColor();

    document.querySelectorAll('.book-card-img2 > img').forEach(img => {
        // CORS 허용 안 되는 경우 자동 처리 시도
        img.crossOrigin = 'anonymous';

        if (img.complete) {
            applyAvgColor(img);
        } else {
            img.onload = () => applyAvgColor(img);
        }
    });

    function applyAvgColor(img) {
        fac.getColorAsync(img)
            .then(color => {
                img.parentElement.style.backgroundColor = color.hex;
            })
            .catch(err => {
                console.warn('색상 추출 실패:', err);
            });
    }

    function formatReviewTime(dateString) {
        const reviewDate = new Date(dateString); // e.g., "May 3, 2025, 10:24:22 AM"
        const now = new Date();
        const diffMs = now - reviewDate;

        const diffMinutes = Math.floor(diffMs / 60000);
        const diffHours = Math.floor(diffMs / 3600000);

        if (diffMinutes < 60) {
            return diffMinutes + '분 전';
        } else if (diffHours < 24) {
            return diffHours + '시간 전';
        } else {
            const yyyy = reviewDate.getFullYear();
            const mm = String(reviewDate.getMonth() + 1).padStart(2, '0');
            const dd = String(reviewDate.getDate()).padStart(2, '0');
            const hh = String(reviewDate.getHours()).padStart(2, '0');
            const min = String(reviewDate.getMinutes()).padStart(2, '0');
            const sec = String(reviewDate.getSeconds()).padStart(2, '0');
            return yyyy + '-' + mm + '-' + dd + ' ' + hh + ':' + min + ':' + sec;
        }
    }
</script>
<%@include file="WEB-INF/views/common/footer.jsp" %>