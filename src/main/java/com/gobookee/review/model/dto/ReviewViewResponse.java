package com.gobookee.review.model.dto;

import java.sql.Timestamp;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@AllArgsConstructor
@NoArgsConstructor
@Builder
@Getter
@Setter
public class ReviewViewResponse {
	
	private Long reviewSeq;
	private String reviewTitle;
	private String reviewContents;
	private Timestamp reviewCreateTime;
	private Integer reviewRate;
	private Timestamp reviewEditTime;
	private List<CommentsViewResponse> comments;

	private String bookTitle;
	private String bookAuthor;
	private String bookPublisher;
	private String bookCover;

	private Integer recommendCount;
	private Integer bookReviewCount;
	private Double bookAvgRate;
	private Integer nonRecommendCount;

}
