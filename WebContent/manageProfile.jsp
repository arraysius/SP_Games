<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
		 pageEncoding="ISO-8859-1" %>

<%-- Check session --%>
<%@ include file="checkSessionMember.jsp" %>
<%
	// Create dbConnection
	dbConnection db = new dbConnection(request);
	Connection conn = db.getConnection();

	// Get user object from session
	User user = (User) session.getAttribute("user");
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
			var form = document.forms["profileUpdate"];

			// Validate name
			var name = form["name"].value;
			if (!(/^[a-zA-Z ]+$/.test(name.trim()))) {
				form["name"].focus();
				alert("Name must be alphabetical and may contain spaces");
				return false;
			}

			// Validate phone number
			var phoneNumber = form["phone"].value;
			if (!(/^[689]\d{7}$/.test(phoneNumber))) {
				form["phone"].focus();
				alert("Phone number must be of 8 digits and/or starts with 6, 8, or 9");
				return false;
			}

			// Validate address
			var address1 = form["address1"].value;
			if (!(/[a-zA-Z ]+/.test(address1.trim()) && /[0-9]*/.test(address1.trim())) || /[<>\\]+/.test(address1.trim())) {
				form["address1"].focus();
				alert('Address must be alphanumeric and contain spaces, "#" or "-"');
				return false;
			}

			var address2 = form["address2"].value;
			if (!(/[a-zA-Z ]*/.test(address2.trim()) && /[0-9]*/.test(address2.trim())) || /[<>\\]+/.test(address2.trim())) {
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

			return true;
		}
	</script>
</head>

<body>

<!-- Navigation -->
<jsp:include page="header.jsp"></jsp:include>

<!-- Page Content -->
<div class="container">

	<form id="updateProfileForm" name="profileUpdate" action="ProfileUpdateServlet"
		  method="post" onsubmit="return validateForm()">
		<h1>Update Profile</h1>
		<%
			String updateStatus = request.getParameter("status");
			if (updateStatus != null && updateStatus.equals("fail")) {
		%>
		<h4 id="updateStatus">There was an error. Please try again.</h4>
		<%
			}
		%>
		<hr>
		<input class="updateInput" type="hidden" name="email"
			   value="<%=user.getEmail() %>" required>
		<legend>Profile Information</legend>
		Name:<input class="updateInput" type="text" name="name" value="<%=user.getName() %>" required>
		Phone Number:<input class="updateInput" type="number" name="phone" value="<%=user.getPhoneNumber() %>" required>
		Address Line 1:<input class="updateInput" type="text" name="address1" value="<%=user.getAddress1() %>" required>
		Address Line 2:<input class="updateInput" type="text" name="address2" value="<%=user.getAddress2() %>">
		Postal Code:<input class="updateInput" type="number" name="postalcode" value="<%=user.getPostalCode() %>" required>
		<hr>
		<legend>Please enter password to continue</legend>
		<input class="updateInput" type="password" name="password" placeholder="Password" required>
		<br> <input id="updateSubmit" class="updateInput"
					type="submit" value="Update">
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