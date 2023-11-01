<%@page import="java.util.*"%>
<%@page import="org.ecommerece.dao.ProductDao"%>
<%@page import="org.ecommerece.connection.DbCon"%>
<%@page import="org.ecommerece.model.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>


	<%
	User auth = (User)request.getSession().getAttribute("auth");
	if(auth !=null){
	//		request.setAttribute("auth", auth);
		response.sendRedirect("index.jsp");
	}
	
	ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
	if(cart_list != null){
		ProductDao pDao = new ProductDao(DbCon.getConnection());
		request.setAttribute("cart_list",cart_list);
	}
	%>
<!DOCTYPE html>
<html>
<head>
<title>login page</title>
<%@include file="includes/header.jsp"%>
</head>
<body>
<%@include file="includes/navbar.jsp"%>

	<div class="container">
		<div class="card w-50 mx-auto my-5">
			<div class="card-header text-center">User Login</div>
			<div class="card-body">
				<form action="user-login" method="post">
					<div class="form-group">
						<label for="email">Email</label> <input type="email"
							class="form-control" id="email" name="email"
							placeholder="Enter your email">
					</div>

					<div class="form-group">
						<label for="password">Password</label> <input type="password"
							class="form-control" id="password" name="password"
							placeholder="Enter your password">
					</div>

					<button type="submit" class="btn btn-primary">Login</button>
				</form>
			</div>

		</div>
	</div>



	<%@include file="includes/footer.jsp"%>
</body>
</html>