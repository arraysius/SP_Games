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

<title>SP Games - Manage Reviews</title>

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
					<p class="adminmsg">Manage Game Reviews</p>
				</div>
				<div class="row">
					<div class="admindatabase">
						<table id="admdbtbstyle">
							<tr>
								<td class="admno">No</td>
								<td class="admname">Title</td>
								<td id="admrname">Name</td>
								<td id="admreview">Review</td>
								<td id="admrdate">Date &amp; Time</td>
								<td id="admdel">Delete</td>
							</tr>
							<%
								String manageReviewsSQL = "SELECT review_id, Title, Name, Comment, DATE_FORMAT(Review_Date, '%d/%m/%y %h:%i %p') AS Review_Date FROM review, game WHERE game.Game_ID = review.Game_ID ORDER BY Title ASC, review.Review_Date DESC";
								Statement manageReviews_stmt = conn.createStatement();
								ResultSet manageReviews_rs = manageReviews_stmt.executeQuery(manageReviewsSQL);

								int num = 0;
								while (manageReviews_rs.next()) {
									num++;
									int reviewID = manageReviews_rs.getInt("Review_ID");
									String gameName = manageReviews_rs.getString("Title");
									String reviewName = manageReviews_rs.getString("Name");
									String reviewComment = manageReviews_rs.getString("Comment");
									String reviewDate = manageReviews_rs.getString("Review_Date");
							%>
							<tr>
								<td><%=num%></td>
								<td><%=gameName%></td>
								<td><%=reviewName%></td>
								<td><%=reviewComment%></td>
								<td><%=reviewDate%></td>
								<td>
									<form id="admmanageact" action="processReviewDelete.jsp">
										<input type="hidden" name="id" value="<%=reviewID%>">
										<input type="submit" value="Delete">
										</input>
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
	conn.close();
%>
</html>