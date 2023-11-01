<%@page import="org.ecommerece.connection.DbCon"%>
<%@page import="org.ecommerece.dao.ProductDao"%>
<%@page import="java.util.*"%>
<%@page import="org.ecommerece.model.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
	request.setAttribute("auth", auth);
}

ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
List<Cart> cartProduct = null;
if (cart_list != null) {
	ProductDao pDao = new ProductDao(DbCon.getConnection());
	cartProduct = pDao.getCartProducts(cart_list);
	request.setAttribute("cart_list", cart_list);
	double total = pDao.getTotalCartPrice(cart_list);
	request.setAttribute("total", total);
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Cart page</title>
<%@include file="includes/header.jsp"%>
</head>
<body>
	<%@include file="includes/navbar.jsp"%>

	<div class="container">
		<div class="d-flex py-3">
			<h3>Total price : $ ${ (total>0)?total:0 }</h3>
			<a class="btn btn-primary mx-3" href="cart-check-out">check out</a>
		</div>

		<table class="table table-loght">
			<thead>
				<tr>
					<th scope="col">Name</th>
					<th scope="col">Category</th>
					<th scope="col">Price</th>
					<th scope="col">Buy now</th>
					<th scope="col">Cancel</th>
				</tr>
			</thead>

			<tbody>
				<%
				if (cart_list != null) {
					for (Cart c : cartProduct) {
				%>

				<tr>
					<td><%=c.getName()%></td>
					<td><%=c.getCategory()%></td>
					<td><%=c.getPrice()%></td>
					<td>
						<form action="order-now" method="post" class="form-inline">
							<input type="hidden" name="id" value="<%=c.getId()%>"
								class="form-input">
							<div class="form-group d-flex justify-content-between w-50">
								<a class="btn btn-incre" href="quantity-inc-dec?action=inc&id=<%= c.getId()%>"> <i
									class="fas fa-plus-square"></i>
								</a> <input type="text" name="quantity" class="form-control w-50"
									value="<%=c.getQuantity()%>"> <a class="btn btn-decre"
									href="quantity-inc-dec?action=dec&id=<%= c.getId()%>"> <i class="fas fa-minus-square"></i>
								</a>
							</div>
							<button type="submit" class="btn btn-primary btn-sm">Buy</button>
						</form>
					</td>
					<!-- query prameter passes after ? mark -->
					<td><a class="btn btn-sm btn-danger" href="remove-from-cart?id=<%= c.getId() %>">Remove</a></td>
				</tr>
				<%
				}
				}
				%>

			</tbody>

		</table>
	</div>


	<%@include file="includes/footer.jsp"%>
</body>
</html>