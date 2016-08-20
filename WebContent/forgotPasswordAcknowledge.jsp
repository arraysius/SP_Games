<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="images/favicon.ico">

<title>SP Games - Acknowledged</title>

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
		<div id="noteforgetbox">
			<%
				String sentStatus = request.getParameter("sentStatus");
				if (sentStatus != null && sentStatus.equals("success")) {
			%>
			<p class="adminmsg" id="noteforgettitle">Request received!</p>
			<p class="subject" id="noteforgetdesc">We have received your
				request and have sent you a password recovery link. Please login to
				your email and click on the link enclosed to change your password.
				If you do not see the email from us, please check the spam box of
				your email.</p>
			<%
				} else {
			%>
			<p class="adminmsg" id="noteforgettitle">Error when sending email</p>
			<p class="subject" id="noteforgetdesc">
				We wern't able to send you an email to reset your password. <a
					href="forgotPassword.jsp"
				>Click here to try again</a> and ensure you have entered your email
				address correctly. Please contact an Administrator if this issue
				persists.
			</p>
			<%
				}
			%>
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

</html>