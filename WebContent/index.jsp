<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
		 pageEncoding="ISO-8859-1"
%>
<%@ page import="spgames.dbConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" href="images/favicon.ico">

	<title>SP Games</title>

	<!-- Bootstrap Core CSS -->
	<link href="css/bootstrap.min.css" rel="stylesheet">

	<!-- Custom CSS -->
	<link href="css/shop-homepage.css" rel="stylesheet">
	
	<link href='https://fonts.googleapis.com/css?family=Product+Sans' rel='stylesheet' type='text/css'>

	<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
	<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
	<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
	<![endif]-->
</head>

<body>
<%
	// Create Connection
	dbConnection db = new dbConnection(request);
	Connection conn = db.getConnection();
%>

<!-- Navigation -->
<jsp:include page="header.jsp"></jsp:include>

<!-- Page Content -->
<div class="container">
	<div class="row">

		<!-- Side Bar -->
		<jsp:include page="sidebar.jsp"></jsp:include>

		<div class="col-md-9">
			<div class="row carousel-holder">
				<div class="col-md-12">
					<div id="carousel-example-generic" class="carousel slide"
						 data-ride="carousel"
					>
						<ol class="carousel-indicators">
							<li data-target="#carousel-example-generic" data-slide-to="0"
								class="active"
							></li>
							<li data-target="#carousel-example-generic" data-slide-to="1"></li>
							<li data-target="#carousel-example-generic" data-slide-to="2"></li>
						</ol>
						<div class="carousel-inner">
							<div class="item active">
								<img class="slide-image" src="images/slider/slider1.jpg" alt="">
							</div>
							<div class="item">
								<img class="slide-image" src="images/slider/slider2.jpg" alt="">
							</div>
							<div class="item">
								<img class="slide-image" src="images/slider/slider3.jpg" alt="">
							</div>
						</div>
						<a class="left carousel-control" href="#carousel-example-generic"
						   data-slide="prev"
						> <span class="glyphicon glyphicon-chevron-left"></span>
						</a> <a class="right carousel-control"
								href="#carousel-example-generic" data-slide="next"
					> <span class="glyphicon glyphicon-chevron-right"></span>
					</a>
					</div>
				</div>
			</div>

			<div class="row">

				<%
					String searchString = request.getParameter("searchString");
					String genre = request.getParameter("genre");
					String preowned = request.getParameter("preowned");
					String sort = request.getParameter("sort");

					// Check genre is in DB
					String genreInDBSQL = "SELECT CASE WHEN ? IN (SELECT Genre_Name FROM genre) THEN 'true' ELSE 'false' END AS genreInDB";
					PreparedStatement genreInDB_pstmt = conn.prepareStatement(genreInDBSQL);
					genreInDB_pstmt.setString(1, genre);
					ResultSet genreInDB_rs = genreInDB_pstmt.executeQuery();
					genreInDB_rs.next();

					String game_sql = "SELECT Game_ID, Title, SUBSTRING(Description, 1, 50) AS Description, CASE WHEN Preowned = 'Y' THEN 'Yes' ELSE 'No' END AS Preowned, Price, CASE WHEN Image_Path = '' THEN 'images/game/default.jpg' ELSE Image_Path END AS Image_Path FROM game";

					// Check if user is searching by title
					if (searchString == null) {
						searchString = "";
					}
					game_sql += " WHERE Title LIKE ?";

					// Value for setting index pos in prepared statement
					int setPos = 2;

					// Check if user is searching by genre
					boolean specificGenre = genre != null && !genre.toLowerCase().equals("all")
							&& genreInDB_rs.getString("genreInDB").equals("true");

					if (specificGenre) {
						game_sql += " AND Game_ID IN (Select Game_ID FROM game_genre WHERE Genre_ID IN (SELECT Genre_ID FROM genre WHERE Genre_Name = ?))";
					}

					// Check if user is searching by preowned
					if (preowned != null && (preowned.toLowerCase().equals("y") || preowned.toLowerCase().equals("n"))) {
						game_sql += " AND Preowned = ?";
					}

					// Check for sort
					if (sort != null && !sort.equals("release")) {
						if (sort.toLowerCase().equals("alphabetical")) {
							game_sql += " ORDER BY Title ASC";
						} else if (sort.toLowerCase().equals("lowprice")) {
							game_sql += " ORDER BY Price ASC";
						} else if (sort.toLowerCase().equals("highprice")) {
							game_sql += " ORDER BY Price DESC";
						}
						game_sql += ", Release_Date DESC";
					} else {
						game_sql += " ORDER BY Release_Date DESC";
					}

					PreparedStatement game_pstmt = conn.prepareStatement(game_sql);
					game_pstmt.setString(1, "%" + searchString + "%");
					if (specificGenre) {
						game_pstmt.setString(setPos, genre);
						setPos++;
					}
					if (preowned != null && (preowned.toLowerCase().equals("y") || preowned.toLowerCase().equals("n"))) {
						game_pstmt.setString(setPos, preowned);
					}
					ResultSet game_rs = game_pstmt.executeQuery();

					// Show games
					if (game_rs.next()) {
						do {
							int game_id = game_rs.getInt("Game_ID");
							String game_title = game_rs.getString("Title");
							String game_desc_short = game_rs.getString("Description").replaceAll("(?i)<br */?>", "");
							String game_preowned = game_rs.getString("Preowned");
							double game_price = game_rs.getDouble("Price");
							String game_image_path = game_rs.getString("Image_Path");
							String game_href = "game.jsp?id=" + game_id;

							// Get rating and review of game
							String reviewSQL = "SELECT CASE WHEN ROUND(AVG(Rating)) IS NULL THEN 'Not yet rated' ELSE CONVERT(ROUND(AVG(Rating)), CHAR) END AS Rating, COUNT(Review_ID) AS Review_Count FROM review WHERE game_id = ?";
							PreparedStatement review_pstmt = conn.prepareStatement(reviewSQL);
							review_pstmt.setInt(1, game_id);
							ResultSet review_rs = review_pstmt.executeQuery();
							review_rs.next();
							String game_rating = review_rs.getString("Rating");
							int game_review_count = review_rs.getInt("Review_Count");
				%>
				<div class="col-sm-4 col-lg-4 col-md-4">
					<div class="thumbnail">
						<a href="<%=game_href%>"><img src="<%=game_image_path%>"
													  alt=""
						></a>
						<div class="caption">
							<h4 class="pull-right">
								$<%=game_price%>
							</h4>
							<h4>
								<a href="<%=game_href%>"><%=game_title%>
								</a>
							</h4>
							<span>Pre-Owned: <%=game_preowned%></span>
							<p><%=game_desc_short%>...
							</p>
						</div>
						<div class="ratings">
							<p class="pull-right">
								<%
									if (game_preowned.equals("Yes")) {
										out.print("&nbsp;");
									} else {
										out.print(game_review_count + " reviews");
									}
								%>
							</p>
							<p>
								<%
									if (game_preowned.equals("No")) {
										// Print rating stars
										if (!game_rating.equals("Not yet rated")) {
											int game_rating_int = Integer.parseInt(game_rating);
											for (int i = 1; i <= game_rating_int; i++) {
								%>
								<span class="glyphicon glyphicon-star"></span>
								<%
									}
									for (int i = 1; i <= 5 - game_rating_int; i++) {
								%>
								<span class="glyphicon glyphicon-star-empty"></span>
								<%
											}
										} else {
											out.println(game_rating);
										}
									} else {
										out.print("&nbsp;");
									}
								%>
							</p>
						</div>
					</div>
				</div>
				<%
					} while (game_rs.next());
				} else {
				%>
				<p id="nogamesfound">No games found</p>
				<%
					}
				%>
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
<%
	conn.close();
%>
</body>
</html>