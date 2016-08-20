<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="model.User"%>

<%-- Check session --%>
<%@ include file="checkSessionMember.jsp"%>
<%
	//Create connection to dbConnection
	dbConnection db = new dbConnection(request);
	Connection conn = db.getConnection();
	
	// Get User object from session
	User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="images/favicon.ico">

<title>SP Games - Change password</title>

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
			var form = document.forms["memberChangePassword"];

			// Validate email
			var email = form["email"].value;
			if (!(/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/.test(email.trim()))) {
				form["email"].focus();
				alert('Invalid email address. Email must contain only one "@" symbol and at least one "." symbol');
				return false;
			}

			// Validate new password
			var password = form["newPassword"].value;
			if (password.indexOf(" ") > -1 || password.length < 8 || password.length > 16 || !(/[a-zA-Z]+/.test(password) && /[0-9]+/.test(password))) {
				form["newPassword"].focus();
				alert('Password must contain both alphabets and numbers, contain no spaces and be of length 8 to 16');
				return false;
			}

			// Confirm password
			if (password !== form["newPassword2"].value) {
				form["newPassword2"].focus();
				alert("Passwords do not match");
				return false;
			}

			return true;
		}
	</script>
</head>

<body>

	<!-- Navigation -->
	<jsp:include page="header.jsp"></jsp:include>

	<!-- Page Content -->
	<div class="container">

		<%
			// Get member user info
			String username = user.getName();
			String email = user.getEmail();
		%>

		<form id="login" name="memberChangePassword"
			action="MemberChangePasswordServlet" method="post"
			onsubmit="return validateForm()">
			<legend id="login_legend">
				Change password for
				<%=username%></legend>
			<%
				String pwChangeStatus = request.getParameter("status");
				if (pwChangeStatus != null && pwChangeStatus.equals("fail")) {
			%>
			<h4 id="registerStatus">There was an error. Please try again.</h4>
			<%
				}
			%>
			<input class="login_input" type="hidden" name="email"
				placeholder="Email address" value="<%=email %>" required> <input
				class="login_input" type="password" name="currentPassword"
				placeholder="Enter your password" required> <input
				class="login_input" type="password" name="newPassword"
				placeholder="Enter your new password" required> <input
				class="login_input" type="password" name="newPassword2"
				placeholder="Re-enter your new password" required> <br> <input
				id="login_submit" class="login_input" type="submit"
				value="Change My Password">
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
%>

</html>