<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
%>
<%@ page import="java.sql.*"%>
<%@ page import="spgames.*"%>

<%-- Check session --%>
<%@include file="checkSessionAdmin.jsp"%>

<%
	// Create connection
	dbConnection db = new dbConnection(request);
	Connection conn = db.getConnection();

	// Delete genre
	int genre_id = Integer.parseInt(request.getParameter("id"));

	String deleteGenreSQL = "DELETE FROM genre WHERE Genre_ID = ?";
	PreparedStatement deleteGenre_pstmt = conn.prepareStatement(deleteGenreSQL);
	deleteGenre_pstmt.setInt(1, genre_id);
	deleteGenre_pstmt.executeUpdate();

	conn.close();

	response.sendRedirect("managegenre.jsp");
%>