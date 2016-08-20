<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
%>
<%@page import="java.sql.*"%>
<%@page import="spgames.*"%>

<%-- Check session --%>
<%@include file="checkSessionAdmin.jsp"%>

<%
	// Create connection
	dbConnection db = new dbConnection(request);
	Connection conn = db.getConnection();

	// Delete review
	int review_id = Integer.parseInt(request.getParameter("id"));

	String deleteReviewSQL = "DELETE FROM review WHERE Review_ID = ?";
	PreparedStatement deleteReview_pstmt = conn.prepareStatement(deleteReviewSQL);
	deleteReview_pstmt.setInt(1, review_id);
	deleteReview_pstmt.executeUpdate();
	
	conn.close();
	
	response.sendRedirect("managereview.jsp");
%>