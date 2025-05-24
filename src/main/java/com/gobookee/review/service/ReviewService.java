package com.gobookee.review.service;

import com.gobookee.review.model.dao.ReviewDAO;
import com.gobookee.review.model.dto.CommentsViewResponse;
import com.gobookee.review.model.dto.ReviewListResponse;
import com.gobookee.review.model.dto.ReviewViewResponse;
import com.gobookee.review.model.dto.Review;

import java.sql.Connection;
import java.util.List;

import static com.gobookee.common.JDBCTemplate.close;
import static com.gobookee.common.JDBCTemplate.getConnection;
import static com.gobookee.review.model.dao.ReviewDAO.reviewDao;

public class ReviewService {

	private static final ReviewService SERVICE = new ReviewService();

	private ReviewDAO dao = reviewDao();

	private ReviewService() {
	}

	public static ReviewService reviewService() {
		return SERVICE;
	}

	public List<ReviewListResponse> getAllReviews(int cPage, int numPerPage) {
		Connection conn = getConnection();
		List<ReviewListResponse> reviews = dao.getAllReviewsByDate(conn, cPage, numPerPage);
		close(conn);
		return reviews;
	}

	public List<ReviewListResponse> getAllReviewsByRec(int cPage, int numPerPage) {
		Connection conn = getConnection();
		List<ReviewListResponse> reviews = dao.getAllReviewsByRec(conn, cPage, numPerPage);
		close(conn);
		return reviews;
	}

	public int reviewCount() {
		Connection conn = getConnection();
		int totalData = dao.reviewCount(conn);
		close(conn);
		return totalData;
	}

	public List<ReviewListResponse> getBestReviews() {
		Connection conn = getConnection();
		List<ReviewListResponse> reviews = dao.getBestReviews(conn);
		close(conn);
		return reviews;
	}

	public ReviewViewResponse getReviewBySeq(Long reviewSeq) {
		Connection conn = getConnection();
		ReviewViewResponse review = dao.getReviewBySeq(conn, reviewSeq);

		List<CommentsViewResponse> comments = dao.getReviewComments(conn, reviewSeq);
		if (comments != null) {
			review.setComments(comments);
		}
		close(conn);
		return review;
	}

	public int getRecommendCount(Integer reviewSeq) {
		Connection conn = getConnection();
		int count = dao.getRecommendCount(conn, reviewSeq);
		close(conn);
		return count;
	}

}
