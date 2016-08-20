<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
%>
<%@ page import="java.sql.*"%>
<%@page import="spgames.dbConnection"%>
<%
	// Create Connection
	dbConnection db = new dbConnection(request);
	Connection conn = db.getConnection();
%>
<div class="col-md-3">
	<h1 class="lead">Browse</h1>
	<hr>
	<form class="list-group" action="index.jsp">
		<input id="search_field" class="list-group-item" type="text"
			name="searchString" placeholder="Search Title"
			<%String searchString = request.getParameter("searchString");
			if (searchString != null) {
				out.print("value='" + searchString + "'");
			}%>
		>
		<div id="search_field" class="list-group-item">
			Genre:
			<select id="search_field" class="list-group-item" name="genre">
				<option>All</option>
				<%
					String genre_sql = "SELECT Genre_Name FROM genre ORDER BY Genre_Name ASC";
					Statement genre_stmt = conn.createStatement();
					ResultSet genre_rs = genre_stmt.executeQuery(genre_sql);

					while (genre_rs.next()) {
						String genre_name = genre_rs.getString("Genre_Name");
				%>
				<option
					<%String genre = request.getParameter("genre");
				if (genre != null && genre.toLowerCase().equals(genre_name.toLowerCase())) {
					out.print("selected");
				}%>
				><%=genre_name%></option>
				<%
					}
				%>
			</select>
		</div>
		<div id="search_field" class="list-group-item">
			Pre-owned?
			<br>
			<input type="radio" name="preowned" value="y"
				<%if (request.getParameter("preowned") != null && request.getParameter("preowned").toLowerCase().equals("y")) {
				out.print("checked");
			}%>
			>
			Yes
			<br>
			<input type="radio" name="preowned" value="n"
				<%if (request.getParameter("preowned") != null && request.getParameter("preowned").toLowerCase().equals("n")) {
				out.print("checked");
			}%>
			>
			No
			<br>
			<input type="radio" name="preowned" value="both"
				<%if (request.getParameter("preowned") != null
					&& request.getParameter("preowned").toLowerCase().equals("both")) {
				out.print("checked");
			}%>
			>
			Both
			<br>
		</div>
		<div id="search_field" class="list-group-item">
			Sort By:
			<select id="search_field" class="list-group-item" name="sort">
				<option value="release"
					<%if (request.getParameter("sort") != null && request.getParameter("sort").toLowerCase().equals("release")) {
				out.print("selected");
			}%>
				>Release Date</option>
				<option value="alphabetical"
					<%if (request.getParameter("sort") != null
					&& request.getParameter("sort").toLowerCase().equals("alphabetical")) {
				out.print("selected");
			}%>
				>Alphabetical</option>
				<option value="lowprice"
					<%if (request.getParameter("sort") != null && request.getParameter("sort").toLowerCase().equals("lowprice")) {
				out.print("selected");
			}%>
				>Price - Low to High</option>
				<option value="highprice"
					<%if (request.getParameter("sort") != null
					&& request.getParameter("sort").toLowerCase().equals("highprice")) {
				out.print("selected");
			}%>
				>Price - High to Low</option>
			</select>
		</div>
		<input type="submit" value="Search" id="search_field"
			class="list-group-item"
		>
	</form>
</div>
<%
	conn.close();
%>