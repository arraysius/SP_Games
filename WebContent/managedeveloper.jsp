<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
%>
<%@page import="java.sql.*"%>
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

<title>SP Games - Manage Developers</title>

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
					<p class="adminmsg">Manage Developer</p>
				</div>
				<hr class="gameline">
				<div class="row">
					<div class="col-md-9">
						<div class="adminwelcbox">
							<p class="subject">Add New Developer</p>
						</div>
						<div>
							<form action="processDeveloperAdd.jsp">
								<p class="desc">
									Developer name:
									<input type="text" name="developer" required />
									<input type="submit" value="Add Developer">
								</p>
							</form>
							<br />
						</div>
					</div>
					<div class="admindatabase">
						<table id="admdbtbstyle">
							<tr>
								<td class="admno">No</td>
								<td class="admname">Developer</td>
								<td id="admgact">Action</td>
							</tr>
							<%
								String manageDevSQL = "SELECT Developer_ID, Developer_Name FROM developer ORDER BY Developer_Name";
								Statement manageDev_stmt = conn.createStatement();
								ResultSet manageDev_rs = manageDev_stmt.executeQuery(manageDevSQL);

								int num = 0;
								while (manageDev_rs.next()) {
									num++;
									int dev_id = manageDev_rs.getInt(1);
									String dev_name = manageDev_rs.getString(2);
							%>
							<tr>
								<td><%=num%></td>
								<td><%=dev_name%></td>
								<td>
									<form class="admgupdate" action="processDeveloperUpdate.jsp">
										<input type="hidden" name="id" value="<%=dev_id%>">
										<input type="text" name="developername"
											placeholder="Update Developer" required
										/>
										<input type="submit" value="Update" />
									</form>
									<%
										String devHasGameSQL = "SELECT CASE WHEN ? IN (SELECT DISTINCT Developer_ID FROM game) THEN 'true' ELSE 'false' END AS devHasGame";
										PreparedStatement devHasGame_pstmt = conn.prepareStatement(devHasGameSQL);
										devHasGame_pstmt.setInt(1, dev_id);
										ResultSet devHasGame_rs = devHasGame_pstmt.executeQuery();
										if (devHasGame_rs.next() && devHasGame_rs.getString(1).equals("false")) {
									%>
									<form class="admgdelete" action="processDeveloperDelete.jsp">
										<input type="hidden" name="id" value="<%=dev_id%>">
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