<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
%>
<%@page import="java.sql.*"%>
<%@page import="spgames.*"%>

<%-- Check session --%>
<%@ include file="checkSessionAdmin.jsp" %>
<%
	// Create db connection
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

<title>SP Games - Admin Control Panel</title>

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
	<%
		String adminNameSQL = "SELECT Name FROM account WHERE Email = ?";
		PreparedStatement adminName_pstmt = conn.prepareStatement(adminNameSQL);
		adminName_pstmt.setString(1, user.getEmail());
		ResultSet adminName_rs = adminName_pstmt.executeQuery();
		adminName_rs.next();
		String adminName = adminName_rs.getString("Name");
	%>

	<!-- Navigation -->
	<jsp:include page="header.jsp"></jsp:include>

	<!-- Page Content -->
	<div class="container">

		<div class="row">

			<!-- Admin Sidebar -->
			<jsp:include page="adminSidebar.html"></jsp:include>

			<div class="col-md-9">
				<div class="adminwelcbox">
					<p class="adminmsg">
						Hello
						<%=adminName%>, welcome back!
					</p>
				</div>
				<div class="row">
					<div class="col-sm-4 col-lg-4 col-md-4">
						<div class="admincpanelbtn">
							<form action="managegame.jsp">
								<input type="submit" class="cpanelbtn" value="Manage Games">
							</form>
						</div>
					</div>
					<div class="col-sm-4 col-lg-4 col-md-4">
						<div class="admincpanelbtn">
							<form action="managegenre.jsp">
								<input type="submit" class="cpanelbtn" value="Manage Genres">
							</form>
						</div>
					</div>
					<div class="col-sm-4 col-lg-4 col-md-4">
						<div class="admincpanelbtn">
							<form action="managereview.jsp">
								<input type="submit" class="cpanelbtn" value="Manage Reviews">
							</form>
						</div>
					</div>
				</div>
				<div class="row" id="row2">
					<div class="col-sm-4 col-lg-4 col-md-4">
						<div class="admincpanelbtn">
							<form action="managedeveloper.jsp">
								<input type="submit" class="cpanelbtn" value="Manage Developers">
							</form>
						</div>
					</div>
					<div class="col-sm-4 col-lg-4 col-md-4">
						<div class="admincpanelbtn">
							<form action="managepublisher.jsp">
								<input type="submit" class="cpanelbtn" value="Manage Publishers">
							</form>
						</div>
					</div>
					<div class="col-sm-4 col-lg-4 col-md-4">
						<div class="admincpanelbtn">
							<form action="manageslider.jsp">
								<input type="submit" class="cpanelbtn" value="Manage Sliders">
							</form>
						</div>
					</div>
					<div class="col-sm-4 col-lg-4 col-md-4">
						<div class="admincpanelbtn">
							<form action="StockServlet">
								<input type="submit" class="cpanelbtn" value="Stock Quantity Report">
							</form>
						</div>
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