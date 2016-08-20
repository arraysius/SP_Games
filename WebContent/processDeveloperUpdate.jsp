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

	// Update developer
	int dev_id = Integer.parseInt(request.getParameter("id"));
	String dev_name = StringEscapeUtils.escapeHtml4(request.getParameter("developername"));

	String updateDevSQL = "UPDATE developer SET Developer_Name = ? WHERE Developer_ID = ?";
	PreparedStatement updateDev_pstmt = conn.prepareStatement(updateDevSQL);
	updateDev_pstmt.setString(1, dev_name);
	updateDev_pstmt.setInt(2, dev_id);
	updateDev_pstmt.executeUpdate();

	conn.close();

	response.sendRedirect("managedeveloper.jsp");
%>