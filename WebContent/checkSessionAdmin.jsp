<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
%>
<%@page import="java.sql.*"%>
<%@page import="spgames.*"%>
<%@ page import="model.User" %>
<%
	// Create sessionConnection to dbConnection
	dbConnection sessionDB = new dbConnection(request);
	Connection sessionConn = sessionDB.getConnection();

	// Get User object from session
	User user = (User) session.getAttribute("user");

	// Check session secret
	if (user == null) {
		response.sendRedirect("login.jsp?login=expired");
		return;
	} else {
		String adminSessionSQL = "SELECT Email, Password, Secret_Key FROM account WHERE Email = ? AND Password = ? AND Secret_Key = ? AND isAdmin = 'Y'";
		PreparedStatement adminSessionPstmt = sessionConn.prepareStatement(adminSessionSQL);
		adminSessionPstmt.setString(1, user.getEmail());
		adminSessionPstmt.setString(2, user.getHashedPassword());
		adminSessionPstmt.setString(3, user.getSecretKey());
		ResultSet adminSessionRs = adminSessionPstmt.executeQuery();
		if (!adminSessionRs.next() || !user.getEmail().equals(adminSessionRs.getString("Email")) || !(user.getHashedPassword().equals(adminSessionRs.getString("Password"))) || !user.getSecretKey().equals(adminSessionRs.getString("Secret_Key"))) {
			response.sendRedirect("login.jsp?login=expired");
			return;
		}
	}

	sessionConn.close();
%>
