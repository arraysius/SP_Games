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
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="images/favicon.ico">

<title>SP Games - Manage Genres</title>

<!-- Bootstrap Core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="css/shop-homepage.css" rel="stylesheet">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

<!-- Product Sans Font -->
<link href='https://fonts.googleapis.com/css?family=Product+Sans'
	rel='stylesheet' type='text/css'
>
</head>

<body>

	<!-- Navigation -->
	<jsp:include page="header.jsp"></jsp:include>

	<!-- Page Content -->
	<div class="container">

		<div class="row">

			<!-- AdminSidebar -->
			<jsp:include page="adminSidebar.html"></jsp:include>

			<div class="col-md-9">
				<div class="adminwelcbox">
					<p class="adminmsg">Manage Genre</p>
				</div>
				<hr class="gameline">
				<div class="row">
					<div class="col-md-9">
						<div class="adminwelcbox">
							<p class="subject">Add New Genre</p>
						</div>
						<div>
							<form action="processGenreAdd.jsp">
								<p class="desc">
									Genre name:
									<input type="text" name="newGenre" required>
									<input type="submit" value="Add New Genre">
								</p>
							</form>
							<br />
						</div>
					</div>
					<div class="admindatabase">
						<table id="admdbtbstyle">
							<tr>
								<td class="admno">No</td>
								<td id="admgenre">Genre</td>
								<td id="admgact">Action</td>
							</tr>
							<%
								String manageGenreSQL = "SELECT Genre_ID, Genre_Name FROM genre ORDER BY Genre_Name";
								Statement manageGenre_stmt = conn.createStatement();
								ResultSet manageGenre_rs = manageGenre_stmt.executeQuery(manageGenreSQL);

								int num = 0;
								while (manageGenre_rs.next()) {
									num++;
									int genre_id = manageGenre_rs.getInt(1);
									String genre_name = manageGenre_rs.getString(2);
							%>
							<tr>
								<td><%=num%></td>
								<td><%=genre_name%></td>
								<td>
									<form class="admgupdate" action="processGenreUpdate.jsp"
										method="post"
									>
										<input type="hidden" name="id" value="<%=genre_id%>">
										<input type="text" name="genrename" placeholder="Update Genre"
											required
										>
										<input type="submit" value="Update">
									</form>
									<%
										String genreHasGameSQL = "SELECT CASE WHEN ? IN (SELECT DISTINCT Genre_ID FROM game_genre) THEN 'true' ELSE 'false' END AS genreHasGame";
										PreparedStatement genreHasGame_pstmt = conn.prepareStatement(genreHasGameSQL);
										genreHasGame_pstmt.setInt(1, genre_id);
										ResultSet genreHasGame_rs = genreHasGame_pstmt.executeQuery();
										if (genreHasGame_rs.next() && genreHasGame_rs.getString(1).equals("false")) {
									%>
									<form class="admgdelete" action="processGenreDelete.jsp"
										method="post"
									>
										<input type="hidden" name="id" value="<%=genre_id%>">
										<input type="submit" value="Delete">
									</form>
									<%
										}
									%>
								</td>
							</tr>
							<%
								}
							%>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- /.container -->

	<!-- Footer -->
	<jsp:include page="footer.html"></jsp:include>

	<!-- jQuery -->
	<script src="js/jquery.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script src="js/bootstrap.min.js"></script>

</body>

<%
	conn.close();
%>
</html>