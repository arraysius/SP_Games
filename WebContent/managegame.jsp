<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
%>
<%@page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="spgames.*"%>

<!-- Check session -->
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

<title>SP Games - Manage Games</title>

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
			<!-- Sidebar -->
			<jsp:include page="adminSidebar.html"></jsp:include>

			<div class="col-md-9">
				<div class="adminwelcbox">
					<p class="adminmsg">Manage Existing Games</p>
				</div>
				<div class="row">
					<form id="manageadd" action="manageGameAdd.jsp">
						<input type="submit" value="Add New Game">
					</form>
					<div class="admindatabase">
						<table id="admdbtbstyle">
							<tr>
								<td class="admno">No</td>
								<td class="admmgname">Title</td>
								<td id="admdate">Release Date</td>
								<td id="admgenre">Genre</td>
								<td id="admmgact">Action</td>
							</tr>
							<%
								String manageGameSQL = "SELECT Game_ID, Title, DATE_FORMAT(Release_Date, '%d/%m/%Y') AS Release_Date FROM game ORDER BY Title";
								Statement manageGame_stmt = conn.createStatement();
								ResultSet manageGame_rs = manageGame_stmt.executeQuery(manageGameSQL);
								int num = 0;
								while (manageGame_rs.next()) {
									num++;

									int game_id = manageGame_rs.getInt("Game_ID");
									String game_title = manageGame_rs.getString("Title");
									String game_date = manageGame_rs.getString("Release_Date");
							%>
							<tr>
								<td><%=num%></td>
								<td><%=game_title%></td>
								<td><%=game_date%></td>
								<td>
									<%
										String genreSQL = "SELECT Genre_Name FROM genre WHERE Genre_ID IN (SELECT Genre_ID FROM game_genre WHERE Game_ID = ?) ORDER BY Genre_Name";
											PreparedStatement genre_pstmt = conn.prepareStatement(genreSQL);
											genre_pstmt.setInt(1, game_id);
											ResultSet genre_rs = genre_pstmt.executeQuery();
											ArrayList<String> genres = new ArrayList<String>();
											while (genre_rs.next()) {
												genres.add(genre_rs.getString(1));
											}
											out.print(format.stringJoin(genres));
									%>
								</td>
								<td>
									<form class="admgupdate" action="manageGameEdit.jsp">
										<input type="hidden" name="id" value="<%=game_id%>">
										<input type="submit" value="Edit">
									</form>
									<form class="admgdelete" action="processGameDelete.jsp"
										method="post"
									>
										<input type="hidden" name="id" value="<%=game_id%>">
										<input type="submit" value="Delete">
									</form>
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
	String uploadStatus = request.getParameter("uploadStatus");
	if (uploadStatus != null) {
		if (uploadStatus.equals("success")) {
			out.print("<script>alert('Success');</script>");
		} else if (uploadStatus.equals("fail")) {
			out.print("<script>alert('Failed: Please ensure at least one genre is selected');</script>");
		}
	}

	conn.close();
%>
</html>