<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
%>
<%@ page import="java.sql.*"%>
<%@ page import="spgames.*"%>

<%-- Check session --%>
<%@include file="checkSessionAdmin.jsp"%>

<%
	// Create connection
	dbConnection db = new dbConnection(request);
	Connection conn = db.getConnection();

	// Delete publisher
	int pub_id = Integer.parseInt(request.getParameter("id"));

	String deletePubSQL = "DELETE FROM publisher WHERE Publisher_ID = ?";
	PreparedStatement deletePub_pstmt = conn.prepareStatement(deletePubSQL);
	deletePub_pstmt.setInt(1, pub_id);
	deletePub_pstmt.executeUpdate();

	conn.close();

	response.sendRedirect("managepublisher.jsp");
%>