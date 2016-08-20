<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
%>
<%@page import="java.sql.*"%>
<%@page import="spgames.*"%>
<%@page import="org.apache.commons.lang3.StringEscapeUtils"%>

<!-- Check cookie -->
<%@include file="checkSessionAdmin.jsp"%>

<%
	// Create connection
	dbConnection db = new dbConnection(request);
	Connection conn = db.getConnection();

	// Add admin
	String adminName = StringEscapeUtils.escapeHtml4(request.getParameter("adminname"));
	String adminEmail = request.getParameter("adminemail");
	String adminPassword = hasher.hash256(adminEmail + hasher.hash256(request.getParameter("adminpassword")));
	String adminSecretKey = hasher.hash256(adminEmail + adminName);

	String addAdminSQL = "INSERT INTO account VALUES (?, ?, ?, ?, ?)";
	PreparedStatement addAdminPstmt = conn.prepareStatement(addAdminSQL);
	addAdminPstmt.setString(1, adminEmail);
	addAdminPstmt.setString(2, adminName);
	addAdminPstmt.setString(3, adminPassword);
	addAdminPstmt.setString(4, adminSecretKey);
	addAdminPstmt.setString(5, "Y");
	addAdminPstmt.executeUpdate();
	conn.close();

	response.sendRedirect("manageadmin.jsp");
%>