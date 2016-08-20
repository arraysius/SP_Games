<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
%>
<%@ page import="java.sql.*"%>
<%@ page import="spgames.*"%>
<%
	String secret = request.getParameter("secret");
	if (secret == null || secret.length() != 64 || request.getParameter("newpassword") == null) {
		response.sendRedirect("forgotPassword.jsp");
		return;
	}

	// Create connection
	dbConnection db = new dbConnection(request);
	Connection conn = db.getConnection();

	// Get email
	String getEmailSQL = "SELECT Email FROM account WHERE Secret_Key = ?";
	PreparedStatement getEmail_pstmt = conn.prepareStatement(getEmailSQL);
	getEmail_pstmt.setString(1, secret);
	ResultSet getEmail_rs = getEmail_pstmt.executeQuery();

	if (getEmail_rs.next()) {
		String email = getEmail_rs.getString(1);

		String hashedPassword = hasher.hash256(email + hasher.hash256(request.getParameter("newpassword")));

		// Update password
		String updatePasswordSQL = "UPDATE account SET Password = ? WHERE Secret_Key = ?";
		PreparedStatement updatePassword_pstmt = conn.prepareStatement(updatePasswordSQL);
		updatePassword_pstmt.setString(1, hashedPassword);
		updatePassword_pstmt.setString(2, secret);
		if (updatePassword_pstmt.executeUpdate() > 0) {
			response.sendRedirect("login.jsp");
		} else {
			response.sendRedirect("errorpage.jsp");
		}
	} else {
		response.sendRedirect("errorpage.jsp");
	}

	conn.close();
%>