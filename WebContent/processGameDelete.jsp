<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
%>
<%@page import="java.sql.*"%>
<%@page import="spgames.*"%>

<!-- Check cookie -->
<%@include file="checkSessionAdmin.jsp"%>

<%
	// Create connection
	dbConnection db = new dbConnection(request);
	Connection conn = db.getConnection();

	// Delete game
	int game_id = Integer.parseInt(request.getParameter("id"));

	String deleteGameSQL = "DELETE FROM game WHERE Game_ID = ?";
	PreparedStatement deleteGame_pstmt = conn.prepareStatement(deleteGameSQL);
	deleteGame_pstmt.setInt(1, game_id);
	deleteGame_pstmt.executeUpdate();

	conn.close();

	response.sendRedirect("managegame.jsp");
%>