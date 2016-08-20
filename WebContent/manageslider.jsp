<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
%>
<%@page import="java.sql.*"%>
<%@page import="spgames.*"%>

<!-- Create connection and check cookie -->
<%@include file="checkSessionAdmin.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="images/favicon.ico">

<title>SP Games - Manage Slider Images</title>

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
	function readURL(input, id) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			var image = '#slide_image' + id;

			reader.onload = function(e) {
				$(image).attr('src', e.target.result).width(800).height(300);
			};

			reader.readAsDataURL(input.files[0]);
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
					<p class="adminmsg">Manage Slider</p>
				</div>
				<hr class="gameline">
				<p class="subject">Preview</p>
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
									<img class="slide-image" src="images/slider/slider2.jpg"
										alt=""
									>
								</div>
								<div class="item">
									<img class="slide-image" src="images/slider/slider3.jpg"
										alt=""
									>
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
						<hr class="gameline">
						<p class="subject">Images Used</p>
						<form class=admslider action="SliderUpload"
							method="post" enctype="multipart/form-data"
						>
							<input type="hidden" value="slider1">
							<img class="slide-image" id="slide_image1"
								src="images/slider/slider1.jpg" alt=""
							>
							<input type='file' onchange="readURL(this, 1);"
								name="sliderimage" accept="image/jpeg"
							/>
							(800 x 300, jpg format)
							<br>
							<input type="hidden" name="sliderid" value="1">
							<input type="submit" class="slidereditbtn" value="Update">
						</form>
						<br>
						<form class=admslider action="SliderUpload"
							method="post" enctype="multipart/form-data"
						>
							<img class="slide-image" id="slide_image2"
								src="images/slider/slider2.jpg" alt=""
							>
							<input type='file' onchange="readURL(this, 2);"
								name="sliderimage" accept="image/jpeg"
							/>
							(800 x 300, jpg format)
							<br>
							<input type="hidden" name="sliderid" value="2">
							<input type="submit" class="slidereditbtn" value="Update">
						</form>
						<br>
						<form class=admslider action="SliderUpload"
							method="post" enctype="multipart/form-data"
						>
							<img class="slide-image" id="slide_image3"
								src="images/slider/slider3.jpg" alt=""
							>
							<input type='file' onchange="readURL(this, 3);"
								name="sliderimage" accept="image/jpeg"
							/>
							(800 x 300, jpg format)
							<br>
							<input type="hidden" name="sliderid" value="3">
							<input type="submit" class="slidereditbtn" value="Update">
						</form>
					</div>
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