<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
		 pageEncoding="ISO-8859-1"
%>
<%@ page import="model.User" %>
<%@ page import="spgames.dbConnection" %>
<%@ page import="java.sql.Connection" %>
<%
	//Create connection to dbConnection
	dbConnection db = new dbConnection(request);
	Connection conn = db.getConnection();

	// Get User object from session
	User user = (User) session.getAttribute("user");

	// Check if user object exists in session
	if (user != null) {
		if (user.getIsAdmin().equals("Y")) {
			response.sendRedirect("controlpanel.jsp");
		} else {
			response.sendRedirect("ProfileServlet");
		}
		return;
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" href="images/favicon.ico">

	<title>SP Games - Login</title>

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

	<form id="login" action="VerifyAccountServlet" method="post">
		<legend id="login_legend">Login</legend>
		<%
			String login = request.getParameter("login");
			if (login != null && login.equals("fail")) {
		%>
		<p id="login_error">Your email address or password is incorrect</p>
		<%
		} else if (login != null && login.equals("expired")) {
		%>
		<p id="login_error">Please enter your login credentials again</p>
		<%
			}
		%>
		<input class="login_input" type="email" name="email"
			   placeholder="Email Address" required
		>
		<input class="login_input" type="password" name="password"
			   placeholder="Password" required
		>
		<input id="login_submit" class="login_input" type="submit"
			   value="Let Me In!"
		>
		<a href="forgotPassword.jsp">Forget your password?</a>
		<br>
		<a href="register.jsp">Register for an account</a>
	</form>

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

	String registerStatus = request.getParameter("register");
	if (registerStatus != null && registerStatus.equals("success")) {
%>
<script type="text/javascript">alert("Account successfully created.");</script>
<%
	}
%>
</html>