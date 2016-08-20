<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
		 pageEncoding="ISO-8859-1"
%>
<%@ page import="model.Cart" %>
<%@page import="model.User" %>
<%@ page import="spgames.*" %>
<%@page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<%
	//Create Connection
	dbConnection db = new dbConnection(request);
	Connection conn = db.getConnection();

	// Check for parameter
	int id = 0;
	try {
		id = Integer.parseInt(request.getParameter("id"));

		// Check if game is in table
		String gameInTable_sql = "SELECT CASE WHEN ? IN (SELECT Game_ID FROM game) THEN 'true' ELSE 'false' END AS 'gameInTable'";
		PreparedStatement gameInTable_pstmt = conn.prepareStatement(gameInTable_sql);
		gameInTable_pstmt.setInt(1, id);
		ResultSet gameInTable_rs = gameInTable_pstmt.executeQuery();
		if (!gameInTable_rs.next() || !gameInTable_rs.getString("gameInTable").equals("true")) {
			response.sendRedirect("index.jsp");
			return;
		}
	} catch (Exception e) {
		response.sendRedirect("index.jsp");
		return;
	}

	// Get game info
	String game_sql = "SELECT Title, Developer_Name, Publisher_Name, DATE_FORMAT(Release_Date, '%d %M %Y') AS Release_Date, Description, Price, CASE WHEN Preowned = 'Y' THEN 'Yes' ELSE 'No' END AS Preowned, Quantity, CASE WHEN Image_Path = '' THEN 'images/game/default.jpg' ELSE Image_Path END AS Image_Path FROM game, developer, publisher WHERE game.Game_ID = ? AND game.Developer_ID = developer.Developer_ID AND game.Publisher_ID = publisher.Publisher_ID";
	PreparedStatement game_pstmt = conn.prepareStatement(game_sql);
	game_pstmt.setInt(1, id);
	ResultSet game_rs = game_pstmt.executeQuery();

	String game_title = "";
	String game_dev = "";
	String game_pub = "";
	String game_date = "";
	String game_desc = "";
	double game_price = 0.0;
	String game_preowned = "";
	int game_quantity = 0;
	String game_image_path = "";

	if (game_rs.next()) {
		game_title = game_rs.getString("Title");
		game_dev = game_rs.getString("Developer_Name");
		game_pub = game_rs.getString("Publisher_Name");
		game_date = game_rs.getString("Release_Date");
		game_desc = game_rs.getString("Description");
		game_price = game_rs.getDouble("Price");
		game_preowned = game_rs.getString("Preowned");
		game_quantity = game_rs.getInt("Quantity");
		game_image_path = game_rs.getString("Image_Path");
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" href="images/favicon.ico">

	<title>SP Games -
		<%=game_title%>
	</title>

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

	<script type="text/javascript">
		function checkMemberLoggedIn() {
			if (window.confirm('Please sign in or register for an account before buying games')) {
				window.location = 'login.jsp';
			}

			return false;
		}
	</script>
</head>

<body>

<!-- Navigation -->
<jsp:include page="header.jsp"></jsp:include>

<!-- Page Content -->
<div class="container">
	<div class="row">

		<!-- Side Bar -->
		<jsp:include page="sidebar.jsp"></jsp:include>

		<div class="col-md-9">
			<p class="game_name"><%=game_title%>
			</p>
			<hr class="gameline">
			<img class="game_image" src="<%=game_image_path%>" alt=""/>
			<div class="gameInfo">

				<%--Add to Cart button--%>
				<%
					User user = (User) session.getAttribute("user");
					String formOnSubmit = "";
					if (user == null || !user.getIsAdmin().equals("N")) {
						formOnSubmit = "onsubmit=\"return checkMemberLoggedIn()\"";
					}

					// Get cart from session
					Cart cart = (Cart) session.getAttribute("cart");
				%>
				<form class="addToCartForm" action="CartManageServlet" method="post" <%=formOnSubmit%>>
					<h3 class="addToCartStock">In Stock: <%=game_quantity%>
					</h3>
					<%
						if (game_quantity > 0 && (user == null || user.getIsAdmin().equals("N"))) {
							// String to display for add to cart button
							// Display "Update cart" if game already in cart
							String addToCartText = "Add to cart";

							// Get input min value
							int min = 1;
					%>
					<input type="hidden" name="gameId" value="<%=id%>">
					<input class="addToCartQuantity" type="number" name="quantity"
						<%
						if (cart != null && cart.hasGame(id)) {
							int gameQuantityToBuy = cart.getGame(id).getQuantityToBuy();
							out.print("value='" + gameQuantityToBuy + "'");
							min = 0;
							addToCartText = "Update cart";
						}
						%>
						   min="<%=min%>" max="<%=game_quantity%>" placeholder="Quantity" required>
					<button class="addToCart" type="submit">
						<div class="addToCartTitle"><%=addToCartText%>
						</div>
						<div class="addToCartPrice">$<%=game_price%>
						</div>
					</button>
					<%
						}
					%>
				</form>

				<p class="desc">
					<span class="subject">Developer: </span><%=game_dev%>
				</p>
				<p class="desc">
					<span class="subject">Publisher: </span><%=game_pub%>
				</p>
				<p class="desc">
					<span class="subject">Genre: </span>
					<%
						String genreSQL = "SELECT Genre_Name FROM genre WHERE Genre_ID IN (SELECT Genre_ID FROM game_genre WHERE Game_ID = ?) ORDER BY Genre_Name";
						PreparedStatement genre_pstmt = conn.prepareStatement(genreSQL);
						genre_pstmt.setInt(1, id);
						ResultSet genre_rs = genre_pstmt.executeQuery();
						ArrayList<String> genres = new ArrayList<String>();
						while (genre_rs.next()) {
							genres.add(genre_rs.getString(1));
						}
						out.print(format.stringJoin(genres));
					%>
				</p>
				<p class="desc">
					<span class="subject">Release Date: </span><%=game_date%>
				</p>
				<p class="desc">
					<span class="subject">Price: </span>$<%=game_price%>
				</p>
				<%
					if (game_preowned.equals("No")) {
				%>
				<p class="desc">
					<span class="subject">Overall Rating: </span>
					<%
						// Get rating
						String reviewSQL = "SELECT CASE WHEN ROUND(AVG(Rating)) IS NULL THEN 'Not yet rated' ELSE CONVERT(ROUND(AVG(Rating)), CHAR) END AS Rating FROM review WHERE Game_ID = ?";
						PreparedStatement rating_pstmt = conn.prepareStatement(reviewSQL);
						rating_pstmt.setInt(1, id);
						ResultSet rating_rs = rating_pstmt.executeQuery();
						rating_rs.next();
						String game_rating = rating_rs.getString("Rating");

						// Print rating stars
						if (!game_rating.equals("Not yet rated")) {
							int game_rating_int = Integer.parseInt(game_rating);
							for (int i = 1; i <= game_rating_int; i++) {
					%>
					<span class="glyphicon glyphicon-star" id="review_submitted_star"></span>
					<%
						}
						for (int i = 1; i <= 5 - game_rating_int; i++) {
					%>
						<span class="glyphicon glyphicon-star-empty"
							  id="review_submitted_star"
						></span>
					<%
							}
						} else {
							out.println("Not yet rated");
						}
					%>
				</p>
				<%
					}
				%>
				<p class="desc">
					<span class="subject">Pre-Owned: </span><%=game_preowned%>
				</p>
				<br>
				<p class="desc">
						<span class="subject">Description:<br>
						</span><%=game_desc%>
				</p>
			</div>
			<%
				// Show review if is new game
				if (game_preowned.equals("No")) {
			%>
			<hr class="gameline">

			<!-- Review Section -->
			<p id="review">Reviews</p>
			<div class="reviewstar">
				<p class="glyphicon" id="review_game">
					<%
						// Get number of reviews
						String review_sql = "SELECT COUNT(Review_ID) FROM review WHERE Game_ID = ?";
						PreparedStatement review_pstmt = conn.prepareStatement(review_sql);
						review_pstmt.setInt(1, id);
						ResultSet review_rs = review_pstmt.executeQuery();
						if (review_rs.next()) {
							out.print(review_rs.getInt(1));
						} else {
							out.print("0");
						}
					%>
					reviews
				</p>
			</div>

			<form id="review_form" action="processReviewAdd.jsp" method="post">
				Name:
				<input class="review_input" type="text" name="name" required/>
				<br/>
				Rating: <select class="review_input" name="rating" required>
				<option value=""></option>
				<option value="0">0</option>
				<option value="1">1</option>
				<option value="2">2</option>
				<option value="3">3</option>
				<option value="4">4</option>
				<option value="5">5</option>
			</select>
				<br/>
				Comment:
				<br/>
					<textarea class="review_input" id="comment_length" name="comment"
							  value="Comment" required
					></textarea>
				<br/>
				<input type="hidden" name="id" value="<%=id%>">
				<input class="review_input" id="review_submit" type="submit"
					   value="Submit"
				>
			</form>
			<%
				// Get review info
				String comment_sql = "SELECT Name, Rating, DATE_FORMAT(Review_Date, '%d %b %y %h:%i %p') AS Comment_Date, Comment FROM review WHERE Game_ID = ? ORDER BY Review_Date DESC";
				PreparedStatement comment_pstmt = conn.prepareStatement(comment_sql);
				comment_pstmt.setInt(1, id);
				ResultSet comment_rs = comment_pstmt.executeQuery();
				while (comment_rs.next()) {
					String comment_name = comment_rs.getString("Name");
					int comment_rating = comment_rs.getInt("Rating");
					String comment_date = comment_rs.getString("Comment_Date");
					String comment_text = comment_rs.getString("Comment");
			%>
			<div class="reviewsubmitted">
				<p>
					Name: <span class="reviewcontent"><%=comment_name%></span>
				</p>
				<p>
					Rating:
					<%
						// Print user rating stars
						int stars_empty = 5 - comment_rating;
						for (int i = 1; i <= comment_rating; i++) {
					%><span class="glyphicon glyphicon-star" id="review_submitted_star"></span>
					<%
						}
						for (int i = 1; i <= stars_empty; i++) {
					%><span class="glyphicon glyphicon-star-empty"
							id="review_submitted_star"
				></span>
					<%
						}
					%>
				</p>
				<p>
					Date &amp; Time: <span class="reviewcontent"><%=comment_date%></span>
				</p>
				<p>Comment:</p>
				<p class="reviewcontent"><%=comment_text%>
				</p>
			</div>
			<%
					}
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
<%
	conn.close();
%>
</html>