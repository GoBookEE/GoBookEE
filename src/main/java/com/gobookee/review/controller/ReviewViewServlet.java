package com.gobookee.review.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gobookee.review.service.ReviewService;

@WebServlet("/review/reviewseq")
public class ReviewViewServlet extends HttpServlet {
	private ReviewService service = ReviewService.reviewService();
	private static final long serialVersionUID = 1L;

	public ReviewViewServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Long seq = Long.valueOf(request.getParameter("seq"));
		System.out.println(service.getReviewBySeq(seq));
		request.setAttribute("review", service.getReviewBySeq(seq));

		request.getRequestDispatcher("/WEB-INF/views/review/reviewView.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
