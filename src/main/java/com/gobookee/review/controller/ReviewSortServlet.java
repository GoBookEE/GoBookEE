package com.gobookee.review.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gobookee.common.AjaxPageBarTemplate;
import com.gobookee.review.model.dto.ReviewListResponse;
import com.gobookee.review.service.ReviewService;
import com.google.gson.Gson;

@WebServlet("/review/sortlist")
public class ReviewSortServlet extends HttpServlet {
	private ReviewService service = ReviewService.reviewService();
	private static final long serialVersionUID = 1L;

	public ReviewSortServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String sort = request.getParameter("sort");

		int cPage;
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		} catch (NumberFormatException e) {
			cPage = 1;
		}
		int numPerPage = 5;
		AjaxPageBarTemplate pb = new AjaxPageBarTemplate(cPage, numPerPage, service.reviewCount());

		List<ReviewListResponse> list;
		if ("recommend".equals(sort)) {
			list = service.getAllReviewsByRec(cPage, numPerPage);
			System.out.println(list.get(0).getReviewTitle());
		} else {
			list = service.getAllReviews(cPage, numPerPage);
			System.out.println(list.get(0).getReviewTitle());
		}

		Gson gson = new Gson();
		response.setContentType("application/json;charset=UTF-8");

		Map<String, Object> result = new HashMap<>();
		result.put("reviews", list);
		result.put("pageBar", pb.makePageBar(request));

		gson.toJson(result, response.getWriter());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

}
