<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
%>
<%@ page import="java.sql.*"%>
<%@ page import="spgames.*"%>
<%@ page import="org.apache.commons.lang3.StringEscapeUtils"%>

<%-- Check session --%>
<%@include file="checkSessionAdmin.jsp"%>

<%
	// Create connection
	dbConnection db = new dbConnection(request);
	Connection conn = db.getConnection();

	// Update genre
	int genre_id = Integer.parseInt(request.getParameter("id"));
	String genre_name = StringEscapeUtils.escapeHtml4(request.getParameter("genrename"));

	String updateGenreSQL = "UPDATE genre SET Genre_Name = ? WHERE Genre_ID = ?";
	PreparedStatement updateGenre_pstmt = conn.prepareStatement(updateGenreSQL);
	updateGenre_pstmt.setString(1, genre_name);
	updateGenre_pstmt.setInt(2, genre_id);
	updateGenre_pstmt.executeUpdate();
	
	conn.close();
	
	response.sendRedirect("managegenre.jsp");
%>