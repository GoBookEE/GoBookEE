package com.gobookee.review.model.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Getter
public class CommentsViewResponse {
	private Integer commentLevel;
	private Long commentsSeq;
	private String commentsContents;
	private Timestamp commentsCreateTime;
	private Timestamp commentsEditTime;	
	private String userNickName;
	private Long commentsParentSeq;
}
