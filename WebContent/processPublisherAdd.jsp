<%@page import="org.apache.commons.lang3.StringEscapeUtils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
%>
<%-- Check session --%>
<%@include file="checkSessionAdmin.jsp"%>

<%
	// Create connection
	dbConnection db = new dbConnection(request);
	Connection conn = db.getConnection();

	// Add publisher
	String pub = StringEscapeUtils.escapeHtml4(request.getParameter("publisher"));

	String addPubSQL = "INSERT INTO publisher (Publisher_Name) VALUES (?)";
	PreparedStatement addPub_pstmt = conn.prepareStatement(addPubSQL);
	addPub_pstmt.setString(1, pub);
	addPub_pstmt.executeUpdate();

	conn.close();

	response.sendRedirect("managepublisher.jsp");
%>