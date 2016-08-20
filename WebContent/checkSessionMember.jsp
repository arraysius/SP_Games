<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
		 pageEncoding="ISO-8859-1"
%>
<%@ page import="model.User" %>
<%@ page import="spgames.dbConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%
	// Create sessionConnection to dbConnection
	dbConnection sessionDB = new dbConnection(request);
	Connection sessionConn = sessionDB.getConnection();

	// Get User object from session
	User memberUser = (User) session.getAttribute("user");

	if (memberUser == null) {
		response.sendRedirect("login.jsp?login=expired");
		return;
	} else {
		String memberSessionSQL = "SELECT Email, Password, Secret_Key FROM account WHERE Email = ? AND Password = ? AND Secret_Key = ? AND isAdmin = 'N'";
		PreparedStatement memberSessionPstmt = sessionConn.prepareStatement(memberSessionSQL);
		memberSessionPstmt.setString(1, memberUser.getEmail());
		memberSessionPstmt.setString(2, memberUser.getHashedPassword());
		memberSessionPstmt.setString(3, memberUser.getSecretKey());
		ResultSet memberSessionRs = memberSessionPstmt.executeQuery();
		if (!memberSessionRs.next() || !memberSessionRs.getString("Email").equals(memberUser.getEmail()) || !memberSessionRs.getString("Password").equals(memberUser.getHashedPassword()) || !memberSessionRs.getString("Secret_Key").equals(memberUser.getSecretKey())) {
			response.sendRedirect("login.jsp?login=expired");
			return;
		}
	}

	sessionConn.close();
%>