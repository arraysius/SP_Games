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

<title>SP Games - Manage Administrators</title>

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
					<p class="adminmsg">Manage Administrators</p>
				</div>
				<hr class="gameline">
				<div class="row">
					<div class="col-md-9">
						<div class="adminwelcbox">
							<p class="subject">Add New Administrator</p>
						</div>
						<div>
							<form class="desc" action="processAdminAdd.jsp" method="post">
								<table>
									<tr>
										<td>Admin Name:</td>
										<td><input class="addadmin" type="text" name="adminname" />
										</td>
									</tr>
									<tr>
										<td>Admin Email:</td>
										<td><input class="addadmin" type="email"
												name="adminemail"
											/></td>
									</tr>
									<tr>
										<td>Password:</td>
										<td><input class="addadmin" type="password"
												name="adminpassword"
											/></td>
									</tr>
								</table>
								<input type="submit" value="Add New Admin">
							</form>
							<br />
						</div>
					</div>
					<div class="admindatabase">
						<table id="admdbtbstyle">
							<tr>
								<td class="admno">No</td>
								<td class="admname">Admin Name</td>
								<td id="admemail">Email</td>
								<td id="admact">Action</td>
							</tr>
							<%
								String manageAdminSQL = "SELECT Email, Name FROM account WHERE isAdmin = 'Y'";
								Statement manageAdmin_stmt = conn.createStatement();
								ResultSet manageAdmin_rs = manageAdmin_stmt.executeQuery(manageAdminSQL);

								int num = 0;
								while (manageAdmin_rs.next()) {
									num++;
									String email = manageAdmin_rs.getString("Email");
									String name = manageAdmin_rs.getString("Name");
							%>
							<tr>
								<td><%=num%></td>
								<td><%=name%></td>
								<td><%=email%></td>
								<td>
									<form id="admmanagedel" action="processAdminDelete.jsp"
										method="post"
									>
										<input type="hidden" name="adminemail" value="<%=email%>">
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
	conn.close();
%>
</html>