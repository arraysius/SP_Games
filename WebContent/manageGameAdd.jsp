<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
%>
<%@ page import="java.sql.*"%>
<%@ page import="spgames.*"%>

<%-- Check session --%>
<%@ include file="checkSessionAdmin.jsp"%>
<%
	dbConnection db = new dbConnection(request);
	Connection conn = db.getConnection();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="images/favicon.ico">

<title>SP Games - Add New Games</title>

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

<!--javascript for image update-->

<script>
	// Display image
	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();

			reader.onload = function(e) {
				$('.game_image').attr('src', e.target.result).width(848)
						.height(480);
			};

			reader.readAsDataURL(input.files[0]);
		}
	}

	//javascript for dropdown
	var expanded = false;

	function showCheckboxes() {
		var checkboxes = document.getElementById("checkboxes");
		if (!expanded) {
			checkboxes.style.display = "block";
			checkboxes.style.padding = "5px";
			expanded = true;
		} else {
			checkboxes.style.display = "none";
			expanded = false;
		}
	}
</script>

</head>

<body>

	<!-- Navigation -->
	<jsp:include page="header.jsp"></jsp:include>

	<!-- Page Content -->
	<div class="container">
		<div class="row">

			<!-- Admin Sidebar -->
			<jsp:include page="adminSidebar.html"></jsp:include>

			<div class="col-md-9">
				<div class="adminwelcbox">
					<p class="adminmsg">Add New Game</p>
				</div>
				<hr class="gameline">
				<form action="GameProcessor" method="post"
					enctype="multipart/form-data"
				>
					<div class="adminwelcbox">
						<input class="adminmsg" name="gametitle" placeholder="Game Title"
							required
						/>
					</div>
					<span class="subject">Upload Image:</span>
					<img class="game_image" src="" alt="Image Preview" />
					<input type='file' onchange="readURL(this);" name="gameimage"
						accept="image/jpeg"
					/>
					(1920 x 1080, jpeg format)
					<br>
					<br>
					<div>
						<p class="desc">
							<span class="subject">Developer: </span> <select name="developer"
								required
							>
								<option value=""></option>
								<%
									String getDevsSQL = "SELECT Developer_ID, Developer_Name FROM developer ORDER BY Developer_Name";
									Statement getDevs_stmt = conn.createStatement();
									ResultSet getDevs_rs = getDevs_stmt.executeQuery(getDevsSQL);

									while (getDevs_rs.next()) {
										int devID = getDevs_rs.getInt(1);
										String devName = getDevs_rs.getString(2);
								%>
								<option value="<%=devID%>"><%=devName%></option>
								<%
									}
								%>
							</select>
						</p>
						<p class="desc">
							<span class="subject">Publisher: </span> <select name="publisher"
								required
							>
								<option value=""></option>
								<%
									String getPubsSQL = "SELECT Publisher_ID, Publisher_Name FROM publisher ORDER BY Publisher_Name";
									Statement getPubs_stmt = conn.createStatement();
									ResultSet getPubs_rs = getPubs_stmt.executeQuery(getPubsSQL);

									while (getPubs_rs.next()) {
										int pubID = getPubs_rs.getInt(1);
										String pubName = getPubs_rs.getString(2);
								%>
								<option value="<%=pubID%>"><%=pubName%></option>
								<%
									}
								%>
							</select>
						</p>
						<p class="desc">
							<span class="subject">Price: $</span>
							<input type="number" name="price" step="0.01" required />
						</p>
						<p class="desc">
							<span class="subject">Release Date: </span>
							<input type="date" name="releaseDate" required />
						</p>
						<p class="desc">
							<span class="subject">Pre-Owned: </span>
							<input type="radio" name="preowned" value="Y" required>
							Yes
							<input type="radio" name="preowned" value="N">
							No
						</p>
						<p class="subject">Genre:</p>
						<div class="dropdown">
							<input type="button" class="selectBox" onclick="showCheckboxes()"
								value="Click here to show Genres"
							/>
							<div id="checkboxes">
								<%
									String getGenreSQL = "SELECT Genre_ID, Genre_Name FROM genre ORDER BY Genre_Name";
									Statement getGenre_stmt = conn.createStatement();
									ResultSet getGenre_rs = getGenre_stmt.executeQuery(getGenreSQL);

									while (getGenre_rs.next()) {
										int genre_id = getGenre_rs.getInt("Genre_ID");
										String genre_name = getGenre_rs.getString("Genre_Name");
								%>
								<label>
									<input type="checkbox" name="genreCheckbox"
										value="<%=genre_id%>"
									>
									<%=genre_name%>
								</label>
								<%
									}
								%>
							</div>
						</div>
						<br>
						<p class="desc">
							<span class="subject">Description:<br>
							</span>
							<textarea cols="103" rows="10" name="description" required></textarea>
						</p>
						<br />
						<input type="hidden" name="action" value="insert">
						<input type="submit" value="Submit">
					</div>
				</form>
				<hr class="gameline">
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

</body>
<%
	conn.close();
%>
</html>