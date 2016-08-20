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

<title>SP Games - Manage Publishers</title>

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

			<!-- Admin Sidebar -->
			<jsp:include page="adminSidebar.html"></jsp:include>

			<div class="col-md-9">
				<div class="adminwelcbox">
					<p class="adminmsg">Manage Publisher</p>
				</div>
				<hr class="gameline">
				<div class="row">
					<div class="col-md-9">
						<div class="adminwelcbox">
							<p class="subject">Add New Publisher</p>
						</div>
						<div>
							<form action="processPublisherAdd.jsp">
								<p class="desc">
									Publisher name:
									<input type="text" name="publisher" required />
									<input type="submit" value="Add Publisher">
								</p>
							</form>
							<br />
						</div>
					</div>
					<div class="admindatabase">
						<table id="admdbtbstyle">
							<tr>
								<td class="admno">No</td>
								<td class="admname">Publisher</td>
								<td id="admgact">Action</td>
							</tr>
							<%
								String managePubSQL = "SELECT Publisher_ID, Publisher_Name FROM publisher ORDER BY Publisher_Name";
								Statement managePub_stmt = conn.createStatement();
								ResultSet managePub_rs = managePub_stmt.executeQuery(managePubSQL);

								int num = 0;
								while (managePub_rs.next()) {
									num++;
									int pub_id = managePub_rs.getInt(1);
									String pub_name = managePub_rs.getString(2);
							%>
							<tr>
								<td><%=num%></td>
								<td><%=pub_name%></td>
								<td>
									<form class="admgupdate" action="processPublisherUpdate.jsp">
										<input type="hidden" name="id" value="<%=pub_id%>">
										<input type="text" name="publishername"
											placeholder="Update Publisher" required
										/>
										<input type="submit" value="Update" />
									</form>
									<%
										String pubHasGameSQL = "SELECT CASE WHEN ? IN (SELECT DISTINCT Publisher_ID FROM game) THEN 'true' ELSE 'false' END AS pubHasGame";
										PreparedStatement pubHasGame_pstmt = conn.prepareStatement(pubHasGameSQL);
										pubHasGame_pstmt.setInt(1, pub_id);
										ResultSet pubHasGame_rs = pubHasGame_pstmt.executeQuery();
										if (pubHasGame_rs.next() && pubHasGame_rs.getString(1).equals("false")) {
									%>
									<form class="admgdelete" action="processPublisherDelete.jsp">
										<input type="hidden" name="id" value="<%=pub_id%>">
										<input type="submit" value="Delete" />
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