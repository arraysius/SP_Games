<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
%>
<%
	String secret = request.getParameter("secret");
	if (secret == null || secret.length() != 64) {
		response.sendRedirect("forgotPassword.jsp");
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

<title>SP Games - Reset your password</title>

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

		<form id="login" action="processPasswordReset.jsp" method="post">
			<legend id="login_legend">Reset password</legend>
			<input class="login_input" type="password" name="newpassword"
				pattern="^\S{6,}$"
				onchange="this.setCustomValidity(this.validity.patternMismatch ? 'Must have at least 6 characters' : ''); if(this.checkValidity()) form.newpassword2.pattern = this.value;"
				placeholder="New Password" required
			>
			<input class="login_input" name="newpassword2" type="password"
				pattern="^\S{6,}$"
				onchange="this.setCustomValidity(this.validity.patternMismatch ? 'Please enter the same password you entered previously' : '');"
				placeholder="Confirm Password" required
			>
			<input type="hidden" name="secret" value="<%=secret%>">
			<input id="login_submit" class="login_input" type="submit"
				value="Reset My Password"
			>
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


</html>