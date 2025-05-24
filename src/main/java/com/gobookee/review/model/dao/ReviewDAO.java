package com.gobookee.review.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.gobookee.common.JDBCTemplate;
import com.gobookee.review.model.dto.Comments;
import com.gobookee.review.model.dto.CommentsViewResponse;
import com.gobookee.review.model.dto.Review;
import com.gobookee.review.model.dto.ReviewListResponse;
import com.gobookee.review.model.dto.ReviewViewResponse;

public class ReviewDAO {
	private PreparedStatement pstmt;
	private ResultSet rs;
	private Properties sqlProp = new Properties();

	private static ReviewDAO dao;

	private ReviewDAO() {
		String path = ReviewDAO.class.getResource("/config/review-sql.properties").getPath();
		try (FileReader fr = new FileReader(path)) {
			sqlProp.load(fr);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static ReviewDAO reviewDao() {
		if (dao == null) {
			dao = new ReviewDAO();
		}
		return dao;
	}

	public List<ReviewListResponse> getAllReviewsByDate(Connection conn, int cPage, int numPerPage) {
		List<ReviewListResponse> reviews = new ArrayList<>();
		try {
			pstmt = conn.prepareStatement(sqlProp.getProperty("getAllReviews"));
			pstmt.setInt(1, (cPage - 1) * numPerPage + 1);
			pstmt.setInt(2, cPage * numPerPage);
			rs = pstmt.executeQuery();
			while (rs.next())
				reviews.add(getReviewListResponse(rs));

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return reviews;
	}

	public List<ReviewListResponse> getAllReviewsByRec(Connection conn, int cPage, int numPerPage) {
		List<ReviewListResponse> reviews = new ArrayList<>();
		try {
			pstmt = conn.prepareStatement(sqlProp.getProperty("getAllReviewsByRec"));
			pstmt.setInt(1, (cPage - 1) * numPerPage + 1);
			pstmt.setInt(2, cPage * numPerPage);
			rs = pstmt.executeQuery();
			while (rs.next())
				reviews.add(getReviewListResponse(rs));

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return reviews;
	}

	public int reviewCount(Connection conn) {
		Statement stmt = null;
		ResultSet rs = null;
		int result = 0;
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sqlProp.getProperty("reviewCount"));
			if (rs.next())
				result = rs.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(stmt);

		}
		return result;
	}

	public List<ReviewListResponse> getBestReviews(Connection conn) {
		List<ReviewListResponse> reviews = new ArrayList<>();
		try {
			pstmt = conn.prepareStatement(sqlProp.getProperty("getBestReviews"));
			rs = pstmt.executeQuery();
			while (rs.next())
				reviews.add(getReviewListResponse(rs));

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return reviews;
	}

	public ReviewViewResponse getReviewBySeq(Connection conn, Long reviewSeq) {
		ReviewViewResponse dto = new ReviewViewResponse();
		try {
			pstmt = conn.prepareStatement(sqlProp.getProperty("getReviewBySeq"));
			pstmt.setLong(1, reviewSeq);
			rs = pstmt.executeQuery();
			if (rs.next())
				dto = getReviewViewResponse(rs);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return dto;
	}

	public List<CommentsViewResponse> getReviewComments(Connection conn, Long seq) {
		List<CommentsViewResponse> comments = new ArrayList<>();
		try {
			pstmt = conn.prepareStatement(sqlProp.getProperty("getReviewComments"));
			pstmt.setLong(1, seq);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				comments.add(getCommentsViewResponse(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return comments;
	}

	public int getRecommendCount(Connection conn, Integer reviewSeq) {
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sqlProp.getProperty("getRecommendCount"));
			pstmt.setInt(1, reviewSeq);
			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	private Comments getCommentDTO(ResultSet rs) throws SQLException {
		Comments dto = Comments.builder().commentsSeq(rs.getLong("COMMENTS_SEQ"))
				.commentsContents(rs.getString("COMMENTS_CONTENTS"))
				.commentsCreateTime(rs.getTimestamp("COMMENTS_CREATE_TIME"))
				.commentsDeleteTime(rs.getTimestamp("COMMENTS_DELETE_TIME"))
				.commentsEditTime(rs.getTimestamp("COMMENTS_EDIT_TIME"))
				.commentsParentSeq(rs.getLong("COMMENTS_PARENT_SEQ"))
				.commentsIsPublic(rs.getString("COMMENTS_IS_PUBLIC").charAt(0)).userSeq(rs.getLong("USER_SEQ"))
				.reviewSeq(rs.getLong("REVIEW_SEQ")).build();
		return dto;
	}

	private CommentsViewResponse getCommentsViewResponse(ResultSet rs) throws SQLException {
		CommentsViewResponse dto = CommentsViewResponse.builder().commentsContents(rs.getString("COMMENTS_CONTENTS"))
				.commentLevel(rs.getInt("COMMENT_LEVEL")).commentsParentSeq(rs.getLong("COMMENTS_PARENT_SEQ"))
				.commentsSeq(rs.getLong("COMMENTS_SEQ")).commentsCreateTime(rs.getTimestamp("COMMENTS_CREATE_TIME"))
				.commentsEditTime(rs.getTimestamp("COMMENTS_EDIT_TIME")).userNickName(rs.getString("USER_NICKNAME"))
				.build();
		return dto;
	}

	private Review getReviewDTO(ResultSet rs) throws SQLException {
		Review dto = Review.builder().reviewSeq(rs.getLong("REVIEW_SEQ")).reviewTitle(rs.getString("REVIEW_TITLE"))
				.reviewContents(rs.getString("REVIEW_CONTENTS")).reviewCreateTime(rs.getTimestamp("REVIEW_CREATE_TIME"))
				.reviewRate(rs.getInt("REVIEW_RATE")).reviewDeleteTime(rs.getTimestamp("REVIEW_DELETE_TIME"))
				.reviewEditTime(rs.getTimestamp("REVIEW_EDIT_TIME")).userSeq(rs.getLong("USER_SEQ"))
				.reviewIsPublic(rs.getString("REVIEW_IS_PUBLIC").charAt(0)).build();
		return dto;
	}

	public ReviewListResponse getReviewListResponse(ResultSet rs) throws SQLException {
		return ReviewListResponse.builder().reviewSeq(rs.getLong("REVIEW_SEQ"))
				.reviewTitle(rs.getString("REVIEW_TITLE")).reviewContents(rs.getString("REVIEW_CONTENTS"))
				.reviewCreateTime(rs.getTimestamp("REVIEW_CREATE_TIME")).reviewRate(rs.getInt("REVIEW_RATE"))
				.reviewEditTime(rs.getTimestamp("REVIEW_EDIT_TIME")).bookTitle(rs.getString("BOOK_TITLE"))
				.bookAuthor(rs.getString("BOOK_AUTHOR")).bookPublisher(rs.getString("BOOK_PUBLISHER"))
				.bookCover(rs.getString("BOOK_COVER")).bookReviewCount(rs.getInt("BOOK_REVIEW_COUNT"))
				.bookAvgRate(rs.getDouble("BOOK_AVG_RATE")).recommendCount(rs.getInt("RECOMMEND_COUNT"))
				.commentsCount(rs.getInt("COMMENTS_COUNT")).build();
	}

	public ReviewViewResponse getReviewViewResponse(ResultSet rs) throws SQLException {
		return ReviewViewResponse.builder().reviewSeq(rs.getLong("REVIEW_SEQ"))
				.reviewTitle(rs.getString("REVIEW_TITLE")).reviewContents(rs.getString("REVIEW_CONTENTS"))
				.reviewCreateTime(rs.getTimestamp("REVIEW_CREATE_TIME")).reviewRate(rs.getInt("REVIEW_RATE"))
				.reviewEditTime(rs.getTimestamp("REVIEW_EDIT_TIME")).comments(new ArrayList<>())
				.bookTitle(rs.getString("BOOK_TITLE")).bookAuthor(rs.getString("BOOK_AUTHOR"))
				.bookPublisher(rs.getString("BOOK_PUBLISHER")).bookCover(rs.getString("BOOK_COVER"))
				.bookReviewCount(rs.getInt("BOOK_REVIEW_COUNT")).bookAvgRate(rs.getDouble("BOOK_AVG_RATE"))
				.recommendCount(rs.getInt("RECOMMEND_COUNT")).nonRecommendCount(rs.getInt("NON_RECOMMEND_COUNT"))
				.build();
	}

}
