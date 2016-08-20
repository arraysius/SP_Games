<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
%>
<%@ page import="java.sql.*"%>
<%@ page import="spgames.*"%>
<%@page import="org.apache.commons.lang3.StringEscapeUtils"%>

<%-- Check session --%>
<%@include file="checkSessionAdmin.jsp"%>

<%
	// Create connection
	dbConnection db = new dbConnection(request);
	Connection conn = db.getConnection();

	// Update developer
	int pub_id = Integer.parseInt(request.getParameter("id"));
	String pub_name = StringEscapeUtils.escapeHtml4(request.getParameter("publishername"));

	String updatePubSQL = "UPDATE publisher SET Publisher_Name = ? WHERE Publisher_ID = ?";
	PreparedStatement updatePub_pstmt = conn.prepareStatement(updatePubSQL);
	updatePub_pstmt.setString(1, pub_name);
	updatePub_pstmt.setInt(2, pub_id);
	updatePub_pstmt.executeUpdate();

	conn.close();

	response.sendRedirect("managepublisher.jsp");
%>