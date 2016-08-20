<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<%@page import="model.Game" %>
<%@page import="spgames.dbConnection" %>
<%@page import="java.util.ArrayList" %>

<!-- Check session -->
<%@include file="checkSessionAdmin.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="images/favicon.ico">

    <title>SP Games - Stock Quantity</title>

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
        <!-- Sidebar -->
        <jsp:include page="adminSidebar.html"></jsp:include>

        <div class="col-md-9">
            <div class="adminwelcbox">
                <p class="adminmsg">Stock Quantity Report</p>
            </div>
            <div class="row">
                <form action="StockServlet">
                    <legend>Quantity filter</legend>
                    <input type="number" name="quantitySelected" placeholder="Filter stock under:" min="0" required>
                    <input type="submit" name="btnSubmit" value="Show">
                </form>
                <div class="admindatabase">
                    <p>
                        <%
                            String updateStatus = request.getParameter("status");
                            if (updateStatus != null && updateStatus.equals("success")) {
                        %>
                        Update successful!
                        <%
                        } else if (updateStatus != null && updateStatus.equals("fail")) {
                        %>
                        Update failed. Please try again.
                        <%
                            }
                        %>
                    </p>
                    <table id="admdbtbstyle">
                        <tr>
                            <td class="admno">No</td>
                            <td class="admqtygname">Title</td>
                            <td class="admno">Price</td>
                            <td class="admqty">Quantity</td>
                        </tr>
                        <%
                            ArrayList<Game> gameStock = (ArrayList<Game>) request.getAttribute("games");
                            if (gameStock == null) {
                                response.sendRedirect("StockServlet");
                                return;
                            }
                            int num = 0;
                            for (Game g : gameStock) {
                                num++;
                        %>
                        <tr>
                            <td><%=num%>
                            </td>
                            <td><%=g.getTitle()%>
                            </td>
                            <td><%=g.getPrice()%>
                            </td>
                            <td>
                                <form action="StockUpdateServlet" method="post">
                                    <input type="number" class="stockQty" name="qty" value="<%=g.getQuantity()%>"
                                           min="0">
                                    <input type="hidden" name="gameID" value="<%=g.getGameId()%>">
                                    <input class="cartUpdateIcon" type="image" src="images/update.png" alt="Update">
                                </form>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </table>
                </div>
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

</body>

</html>