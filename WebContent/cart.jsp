<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
		 pageEncoding="ISO-8859-1"
%>
<%@ page import="model.Cart" %>
<%@ page import="model.Game" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ include file="checkSessionMember.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" href="images/favicon.ico">

	<title>SP Games - My Cart</title>

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
	<link href='https://fonts.googleapis.com/css?family=Product+Sans' rel='stylesheet' type='text/css'>
</head>

<body>

<!-- Navigation -->
<jsp:include page="header.jsp"></jsp:include>

<!-- Page Content -->
<div class="container">

	<h1 class="cartTitle">My Cart</h1>
	<%
		String checkoutError = request.getParameter("checkout");
		if (checkoutError != null && (checkoutError.equals("decline") || checkoutError.equals("invalid") || checkoutError.equals("stripeerror") || checkoutError.equals("error"))) {
			String errorMesasge = "";
			if (checkoutError.equals("decline")) {
				errorMesasge = "Your card has been declined. Please try again.";
			} else if (checkoutError.equals("invalid")) {
				errorMesasge = "Invalid interaction with Stripe server. Please try again.";
			} else if (checkoutError.equals("stripeerror")) {
				errorMesasge = "There was an error in the interaction with Stripe servers. Please try again at a later time.";
			} else if (checkoutError.equals("error")) {
				errorMesasge = "There was an error processing your request. Please try again.";
			}
	%>
	<h4 id="cartErrorMessage"><%=errorMesasge%>
	</h4>
	<%
		}
	%>
	<hr class="gameline">
	<table id="cartTable">
		<tr>
			<th>Title</th>
			<th>Quantity</th>
			<th>Unit Price</th>
			<th>Net Price</th>
			<th>Remove</th>
		</tr>
		<%
			Cart cart = (Cart) session.getAttribute("cart");

			if (cart != null) {
				if (cart.getGames().size() <= 0) {
		%>
		<tr>
			<td class="cartEmpty" colspan="5">No Games Added</td>
		</tr>
		<%
		} else {
			for (Game game : cart.getGames()) {
				int gameId = game.getGameId();
				String gameTitle = game.getTitle();
				double gamePrice = game.getPrice();
				int buyQuantity = game.getQuantityToBuy();
		%>
		<tr>
			<td><a href="game.jsp?id=<%=gameId%>"><%=gameTitle%>
			</a>
			</td>
			<form action="CartManageServlet" method="post">
				<input type="hidden" name="gameId" value="<%=gameId%>">
				<td class="cartUpdateColumn">
					<input class="cartUpdateInput" type="number" name="quantity" min="1" max="<%=game.getQuantity()%>"
						   value="<%=buyQuantity%>"
						   placeholder="Quantity" required>
					<input class="cartUpdateIcon" type="image" src="images/update.png" alt="Update">
				</td>
			</form>
			<td class="cartColumn">$<%=gamePrice%>
			</td>
			<td class="cartColumn">
				$<%=new DecimalFormat("0.00").format(gamePrice * buyQuantity)%>
			</td>
			<td class="cartColumn">
				<form action="CartManageServlet" method="post">
					<input type="hidden" name="gameId" value="<%=gameId%>">
					<input type="hidden" name="quantity" value="0">
					<input class="shake" type="image" src="images/delete.png" alt="Remove">
				</form>
			</td>
		</tr>
		<%
				}
			}
		} else {
		%>
		<tr>
			<td class="cartEmpty" colspan="5">No Games Added</td>
		</tr>
		<%
			}
		%>
	</table>

	<%
		if (cart != null && cart.getGames().size() > 0) {
			double completePrice = cart.getTotalPriceInCents() / 100.0;
	%>
	<hr class="gameline">

	<h1 class="cartTitle">Personal Particulars</h1>
	<table id="cartProfile">
		<%
			User user = (User) session.getAttribute("user");
		%>
		<tr>
			<td class="profileTitle">Name</td>
			<td><%=user.getName()%>
			</td>
		</tr>
		<tr>
			<td class="profileTitle">Email Address</td>
			<td><%=user.getEmail()%>
			</td>
		</tr>
		<tr>
			<td class="profileTitle">Contact Number</td>
			<td><%=user.getPhoneNumber()%>
			</td>
		</tr>
		<tr>
			<td class="profileTitle" id="addressTitle">Residential
				address
			</td>
			<td><%=user.getAddress1()%>
				<%
					String address2 = user.getAddress2();
					if (address2 != null && !address2.equals("")) {
						out.print("<br>" + user.getAddress2());
					}
				%>
			</td>
		</tr>
		<tr>
			<td class="profileTitle">Postal Code</td>
			<td><%=user.getPostalCode()%>
			</td>
		</tr>
	</table>

	<hr class="gameline">

	<div id="cartTotalPrice">
		<h3>Total Price: $<%=new DecimalFormat("0.00").format(completePrice)%>
		</h3>
		<form action="CheckoutServlet" method="POST">
			<script
					src="https://checkout.stripe.com/checkout.js" class="stripe-button"
					data-key="pk_test_rYNU3vdMxmDSWT9bI6ETSUYp"
					data-amount="<%=cart.getTotalPriceInCents()%>"
					data-name="Checkout Games"
					data-description="Enter your credit card details"
					data-image="images/sp_stripe.jpg"
					data-locale="auto">
			</script>
		</form>
	</div>
	<%
		}
	%>

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