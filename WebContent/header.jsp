<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
		 pageEncoding="ISO-8859-1"
%>
<%@ page import="model.User" %>
<%@ page import="spgames.dbConnection" %>
<%@ page import="java.sql.Connection" %>
<%
	// Create connection
	dbConnection db = new dbConnection(request);
	Connection conn = db.getConnection();

	// Initialise navbar items
	String menuItem = "";

	//Get session
	User user = (User) session.getAttribute("user");
	if (user == null) {
		menuItem = "<li><a href='login.jsp'>Login</a></li>";
		menuItem += "<li><a href='register.jsp'>Register</a></li>";
	} else {
		if (user.getIsAdmin().equals("Y")) {
			menuItem = "<li><a href='controlpanel.jsp'>Admin Control Panel</a></li>";
		} else {
			menuItem = "<li><a href='ProfileServlet'>My Profile</a></li><li><a href='cart.jsp'>Cart</a></i>";
		}
		menuItem += "<li><a href='SignoutServlet'>Sign Out</a></li>";
	}
%>
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
	<div class="container">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#bs-example-navbar-collapse-1"
			>
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"
			></span> <span class="icon-bar"></span> <span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="index.jsp"><img class="site_logo"
														  src="images/sp_games_logo.png" alt="SP Games"
			></a>
		</div>
		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse"
			 id="bs-example-navbar-collapse-1"
		>
			<ul class="nav navbar-nav">
				<%=menuItem%>
			</ul>
		</div>
		<!-- /.navbar-collapse -->
	</div>
	<!-- /.container -->
</nav>