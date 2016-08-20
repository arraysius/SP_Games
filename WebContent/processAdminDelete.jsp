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

	// Delete admin
	String adminEmail = request.getParameter("adminemail");

	String deleteAdminSQL = "DELETE FROM account WHERE Email = ?";
	PreparedStatement deleteAdmin_pstmt = conn.prepareStatement(deleteAdminSQL);
	deleteAdmin_pstmt.setString(1, adminEmail);
	deleteAdmin_pstmt.executeUpdate();

	conn.close();

	response.sendRedirect("manageadmin.jsp");
%>