<%@page import="com.sun.xml.internal.bind.v2.schemagen.xmlschema.Import"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
%>
<%@ page import="spgames.*"%>
<%@ page import="java.sql.*"%>
<%
	// Get admin email
	String email = request.getParameter("email");
	if (email == null) {
		response.sendRedirect("forgotPassword.jsp");
		return;
	} else {
		email = email.trim().toLowerCase();
	}

	// Create connection
	dbConnection db = new dbConnection(request);
	Connection conn = db.getConnection();

	// Get admin secret key
	String secretSQL = "SELECT Secret_Key FROM account WHERE Email = ?";
	PreparedStatement secret_pstmt = conn.prepareStatement(secretSQL);
	secret_pstmt.setString(1, email);
	try {
		ResultSet secret_rs = secret_pstmt.executeQuery();
		secret_rs.next();
		String secretkey = secret_rs.getString("Secret_Key");
		String sentStatus = Mailer.sendMail(email, secretkey);
		response.sendRedirect("forgotPasswordAcknowledge.jsp?sentStatus=" + sentStatus);
	} catch (Exception e) {
		e.printStackTrace();
		response.sendRedirect("forgotPasswordAcknowledge.jsp");
	}

	// Close connection
	conn.close();
%>