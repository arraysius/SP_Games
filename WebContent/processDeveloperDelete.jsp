<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
%>
<%@ page import="java.sql.*"%>
<%@ page import="spgames.*"%>

<!-- Check cookie -->
<%@include file="checkSessionAdmin.jsp"%>

<%
	// Create connection
	dbConnection db = new dbConnection(request);
	Connection conn = db.getConnection();

	// Delete developer
	int dev_id = Integer.parseInt(request.getParameter("id"));

	String deleteDevSQL = "DELETE FROM developer WHERE Developer_ID = ?";
	PreparedStatement deleteDev_pstmt = conn.prepareStatement(deleteDevSQL);
	deleteDev_pstmt.setInt(1, dev_id);
	deleteDev_pstmt.executeUpdate();

	conn.close();

	response.sendRedirect("managedeveloper.jsp");
%>