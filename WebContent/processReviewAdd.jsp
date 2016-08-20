<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
%>
<%@page import="java.sql.*"%>
<%@page import="spgames.*"%>
<%@page import="org.apache.commons.lang3.StringEscapeUtils"%>
<%
	//Create Connection
	dbConnection db = new dbConnection(request);
	Connection conn = db.getConnection();

	int id = 0;
	String name = "";
	int rating = 0;
	String comment = "";

	try {
		// Check if game is in table
		id = Integer.parseInt(request.getParameter("id"));
		String gameInTable_sql = "SELECT CASE WHEN ? IN (SELECT Game_ID FROM game) THEN 'true' ELSE 'false' END AS 'gameInTable'";
		PreparedStatement gameInTable_pstmt = conn.prepareStatement(gameInTable_sql);
		gameInTable_pstmt.setInt(1, id);
		ResultSet gameInTable_rs = gameInTable_pstmt.executeQuery();
		if (!gameInTable_rs.next() || !gameInTable_rs.getString("gameInTable").equals("true")) {
			response.sendRedirect("index.jsp");
		} else {
			// Get review info
			name = request.getParameter("name");
			rating = Integer.parseInt(request.getParameter("rating"));
			comment = request.getParameter("comment");
			if (name.equals("") || comment.equals("") || (rating < 0 || rating > 5)) {
				response.sendRedirect("index.jsp");
			}
		}

		// Insert review to dbConnection
		name = StringEscapeUtils.escapeHtml4(name);
		comment = StringEscapeUtils.escapeHtml4(comment);
		comment = format.nl2br(comment);

		String postSQL = "INSERT INTO review (Game_ID, Name, Comment, Rating, Review_Date) VALUES (?, ?, ?, ?, NOW());";
		PreparedStatement post_pstmt = conn.prepareStatement(postSQL);
		post_pstmt.setInt(1, id);
		post_pstmt.setString(2, name);
		post_pstmt.setString(3, comment);
		post_pstmt.setInt(4, rating);
		post_pstmt.executeUpdate();
		response.sendRedirect("game.jsp?id=" + id + "#review");
	} catch (Exception e) {
		response.sendRedirect("index.jsp");
	}

	conn.close();
%>