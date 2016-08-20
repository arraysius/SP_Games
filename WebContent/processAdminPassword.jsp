<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
%>
<%@page import="java.sql.*"%>
<%@page import="spgames.*"%>

<!-- Check session -->
<%@include file="checkSessionAdmin.jsp"%>

<%
	// Create connection
	dbConnection db = new dbConnection(request);
	Connection conn = db.getConnection();
	
	// Update password
	String currentEmail = request.getParameter("currentemail");
	String hashedPassword = hasher.hash256(currentEmail + hasher.hash256(request.getParameter("newpassword")));

	String updatePasswordSQL = "UPDATE account SET Password = ? WHERE Email = ?";
	PreparedStatement updatePassword_pstmt = conn.prepareStatement(updatePasswordSQL);
	updatePassword_pstmt.setString(1, hashedPassword);
	updatePassword_pstmt.setString(2, currentEmail);
	updatePassword_pstmt.executeUpdate();

	conn.close();

	response.sendRedirect("adminSettings.jsp");
%>