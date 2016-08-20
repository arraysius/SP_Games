<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
		 pageEncoding="ISO-8859-1" %>
<%@ page import="model.User" %>
<%
	// Get session secret
	User user = (User) session.getAttribute("user");

	// Check for User object
	if (user != null) {
		response.sendRedirect("profile.jsp");
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

	<title>SP Games - Register</title>

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
		  rel='stylesheet' type='text/css'>

	<script type="text/javascript">
		function validateForm() {
			var form = document.forms["registerForm"];

			// Validate email
			var email = form["email"].value;
			if (!(/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/.test(email.trim()))) {
				form["email"].focus();
				alert('Invalid email address. Email must contain only one "@" symbol and at least one "." symbol');
				return false;
			}

			// Validate password
			var password = form["password"].value;
			if (password.indexOf(" ") > -1 || password.length < 8 || password.length > 16 || !(/[a-zA-Z]+/.test(password) && /[0-9]+/.test(password))) {
				form["password"].focus();
				alert('Password must contain both alphabets and numbers, contain no spaces and be of length 8 to 16');
				return false;
			}

			// Confirm password
			if (password !== form["password2"].value) {
				form["password"].focus();
				alert("Passwords do not match");
				return false;
			}

			// Validate name
			var name = form["name"].value;
			if (!(/^[a-zA-Z ]+$/.test(name.trim()))) {
				form["name"].focus();
				alert("Name must be alphabetical and may contain spaces");
				return false;
			}

			// Validate phone number
			var phoneNumber = form["phone"].value;
			if (!(/^[689][0-9]{7}$/.test(phoneNumber))) {
				form["phone"].focus();
				alert("Phone number must be of 8 digits, starting with 6, 8 or 9");
				return false;
			}

			// Validate address
			var address1 = form["address1"].value;
			if (!(/[a-zA-Z ]+/.test(address1.trim()) && /[0-9]*/.test(address1.trim())) || /[<>\\]/.test(address1.trim())) {
				form["address1"].focus();
				alert('Address must be alphanumeric and contain spaces, "#" or "-"');
				return false;
			}

			var address2 = form["address2"].value;
			if (address2.length > 1 && !(/[a-zA-Z ]+/.test(address2.trim()) && /[0-9]*/.test(address2.trim())) || /[<>\\]/.test(address2.trim())) {
				form["address2"].focus();
				alert('Address must be alphanumeric and contain spaces, "#" or "-"');
				return false;
			}

			// Validate postal code
			var postalCode = form["postalcode"].value;
			if (!(/^[0-9]{6}$/.test(postalCode))) {
				form["postalcode"].focus();
				alert("Postal code must be of 6 digits");
				return false;
			}
		}
	</script>
</head>

<body>

<!-- Navigation -->
<jsp:include page="header.jsp"></jsp:include>

<!-- Page Content -->
<div class="container">

	<form id="registerForm" name="registerForm" action="MemberAddServlet" method="post"
		  onsubmit="return validateForm()">
		<h1>Register for an account</h1>
		<%
			String registerStatus = request.getParameter("status");
			if (registerStatus != null && registerStatus.equals("fail")) {
		%>
		<h4 id="registerStatus">There was an error. Please try again.</h4>
		<%
			}
		%>
		<hr>

		<legend>Account Information</legend>
		<input class="registerInput" type="email" name="email" placeholder="Email address" required>
		<input class="registerInput" type="password" name="password" placeholder="Enter your password" required>
		<input class="registerInput" type="password" name="password2" placeholder="Confirm your password" required>

		<legend>Profile Information</legend>
		<input class="registerInput" type="text" name="name" placeholder="Name" required>
		<input class="registerInput" type="number" name="phone" placeholder="Phone number" required>
		<input class="registerInput" type="text" name="address1" placeholder="Address Line 1" required>
		<input class="registerInput" type="text" name="address2" placeholder="Address Line 2">
		<input class="registerInput" type="number" name="postalcode" placeholder="Postal code" required>
		<br>
		<input id="registerSubmit" class="registerInput" type="submit" value="Sign Up!">
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