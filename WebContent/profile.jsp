<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
		 pageEncoding="ISO-8859-1" %>
<%@ page import="model.Game" %>
<%@ page import="model.Transaction" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.ArrayList" %>

<%-- Check session --%>
<%@ include file="checkSessionMember.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">

<head>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="">
	<meta name="author" content="">

	<title>SP Games</title>

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

</head>

<body>

<!-- Navigation -->
<jsp:include page="header.jsp"></jsp:include>

<!-- Page Content -->
<div class="container">

	<div class="row">

		<!-- Side Bar -->
		<jsp:include page="memberSidebar.html"></jsp:include>

		<div class="col-md-9">
			<%
				// Get User object from session
				User user = (User) session.getAttribute("user");

				// Get member user info
				String username = user.getName();
				String email = user.getEmail();
				int contactNum = user.getPhoneNumber();
				String address1 = user.getAddress1();
				String address2 = user.getAddress2();
				int postalCode = user.getPostalCode();
			%>
			<div class="welcbox">
				<p class="msg">
					Hi
					<%=username%>, welcome back!
				</p>
			</div>
			<div class="row">
				<p class="sectionTitle">My Information</p>
				<table id="profile">
					<tr>
						<td class="profileTitle">Name</td>
						<td><%=username%>
						</td>
					</tr>
					<tr>
						<td class="profileTitle">Email Address</td>
						<td><%=email%>
						</td>
					</tr>
					<tr>
						<td class="profileTitle">Contact Number</td>
						<td><%=contactNum%>
						</td>
					</tr>
					<tr>
						<td class="profileTitle" id="addressTitle">Residential
							address
						</td>
						<td><%=address1%>
							<% if (address2 != null && !address2.equals("")) {
								out.print("<br>" + address2);
							}
							%>
						</td>
					</tr>
					<tr>
						<td class="profileTitle">Postal Code</td>
						<td><%=postalCode%>
						</td>
					</tr>
				</table>
				<hr class="gameline">
				<p class="sectionTitle">My Transaction History</p>
				<%
					ArrayList<Transaction> transactions = (ArrayList<Transaction>) request.getAttribute("transactions");
					if (transactions == null) {
						response.sendRedirect("ProfileServlet");
						return;
					}
					for (Transaction t : transactions) {
						int transactionID = t.getTransactionID();
						String transactionDate = t.getTransactionDate();
						ArrayList<Game> games = t.getGames();
				%>
				<table class="gameHistory">
					<tr class="gameHistoryHeader">
						<td class="transactionHeader" colspan="3">Transaction ID: <%=transactionID %><span
								class="pull-right">Date and Time of purchase: <%=transactionDate %></span>
						</td>
					</tr>
					<tr class="gameHistoryHeader">
						<td class="gameTitle">Game Title</td>
						<td class="transactionQuantity">Quantity</td>
						<td class="price">Net Price</td>
					</tr>
					<%
						double totalPrice = 0.00;
						for (Game g : games) {
							String gameTitle = g.getTitle();
							int transactionQuantity = g.getQuantityToBuy();
							double price = g.getPrice() * g.getQuantityToBuy();
							totalPrice += price;
					%>
					<tr>
						<td class="gameTitle"><%=gameTitle %>
						</td>
						<td class="transactionQuantity"><%= transactionQuantity %>
						</td>
						<td class="price">$<%=new DecimalFormat("0.00").format(price)%>
						</td>
					</tr>
					<%
						}
					%>
					<tr class="gameHistoryHeader">
						<td class="transactionHeader" colspan="3"><span
								class="pull-right">Total Price: $<%=new DecimalFormat("0.00").format(totalPrice)%></span>
						</td>
					</tr>
				</table>
				<%
					}
				%>
			</div>
		</div>
	</div>
</div>
<!-- /.container -->

<div class="container">

	<hr>

	<!-- Footer -->
	<footer>
		<div class="row">
			<div class="col-lg-12">
				<p>Copyright &copy; SP Games 2016</p>
			</div>
		</div>
	</footer>

</div>
<!-- /.container -->

<!-- jQuery -->
<script src="js/jquery.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="js/bootstrap.min.js"></script>

</body>

</html>