<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
%>
<%@ page import="java.sql.*"%>
<%@ page import="spgames.*"%>
<%@ page import="org.apache.commons.lang3.StringEscapeUtils"%>

<!-- Check cookie -->
<%@include file="checkSessionAdmin.jsp"%>

<%
	// Create connection
	dbConnection db = new dbConnection(request);
	Connection conn = db.getConnection();

	// Add genre
	String genre_name = StringEscapeUtils.escapeHtml4(request.getParameter("newGenre"));

	String addGenreSQL = "INSERT INTO genre (Genre_Name) VALUES (?)";
	PreparedStatement addGenre_pstmt = conn.prepareStatement(addGenreSQL);
	addGenre_pstmt.setString(1, genre_name);
	addGenre_pstmt.executeUpdate();

	conn.close();

	response.sendRedirect("managegenre.jsp");
%>