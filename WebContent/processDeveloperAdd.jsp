<%@page import="org.apache.commons.lang3.StringEscapeUtils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
%>
<!-- Check cookie -->
<%@include file="checkSessionAdmin.jsp"%>

<%
	// Create connection
	dbConnection db = new dbConnection(request);
	Connection conn = db.getConnection();

	// Add developer
	String dev = StringEscapeUtils.escapeHtml4(request.getParameter("developer"));

	String addDevSQL = "INSERT INTO developer (Developer_Name) VALUES (?)";
	PreparedStatement addDev_pstmt = conn.prepareStatement(addDevSQL);
	addDev_pstmt.setString(1, dev);
	addDev_pstmt.executeUpdate();

	conn.close();

	response.sendRedirect("managedeveloper.jsp");
%>