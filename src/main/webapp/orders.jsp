<%@page import="java.util.*"%>
<%@page import="org.ecommerece.dao.*"%>
<%@page import="org.ecommerece.connection.DbCon"%>
<%@page import="org.ecommerece.model.*"%>


<%@page import="org.ecommerece.connection.DbCon" %>
<%@page import="org.ecommerece.model.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	
	<%
	User auth = (User)request.getSession().getAttribute("auth");
	List<Order> orders = null;
	if(auth !=null){
		request.setAttribute("auth", auth);
		 orders = new OrderDao(DbCon.getConnection()).userOrders(auth.getId());
	}else{
		response.sendRedirect("login.jsp");
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
<title>orders page</title>
<%@include file="includes/header.jsp" %>
</head>
<body>
	<%@include file="includes/navbar.jsp"%>

	<div class="container">
		<div class="card-header my-5 ">All Orders</div>
		<table class="table table-loght">
			<thead>
				<tr>
					<th scope="col">Date</th>
					<th scope="col">Name</th>
					<th scope="col">Category</th>
					<th scope="col">Quantity</th>
					<th scope="col">Price</th>
					<th scope="col">Cancel</th>
				</tr>
			</thead>

			<tbody>
			
			<%
			if(orders != null){
				for(Order o:orders){%>
					<tr>
					<td><%= o.getDate() %></td>
					<td><%= o.getName() %></td>
					<td><%= o.getCategory() %></td>
					<td><%= o.getQuantity() %></td>
					<td><%= o.getPrice() %></td>
					<td> <a class="btn btn-sm btn-danger" href="cancel-order?id=<%= o.getOrderId()%> ">Cancel</a></td>
					
					
					
					</tr>
					
				<% }
			}
			%>
			
			
			</tbody>
	</table>
	</div>

<%@include file="includes/footer.jsp" %>
</body>
</html>