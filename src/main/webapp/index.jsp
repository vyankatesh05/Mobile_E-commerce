<%@page import="java.util.*"%>
<%@page import="org.ecommerece.dao.ProductDao"%>
<%@page import="org.ecommerece.connection.DbCon"%>
<%@page import="org.ecommerece.model.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
	request.setAttribute("auth", auth);
}

ProductDao pd = new ProductDao(DbCon.getConnection());
List<Product> products = pd.getAllproducts();

ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
if(cart_list != null){
	ProductDao pDao = new ProductDao(DbCon.getConnection());
	request.setAttribute("cart_list",cart_list);
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Index page</title>
<%@include file="includes/header.jsp"%>
</head>
<body>
	<%@include file="includes/navbar.jsp"%>

	<%-- out.print(DbCon.getConnection()); --%>
	<div class="container">
		<div class="card-header my-5 ">All Products</div>
		<div class="row">

			<%
			if (!products.isEmpty()) {
				for (Product p : products) {
			%>

			<div class="col-md-3 my-3">
				<div class="card w-100" style="width: 18rem;">
				
				  <img class="card-img-top" src="product-images/<%=p.getImage() %>"
						alt="cardimage">  
				 
					<div class="card-body">
						<h5 class="card-title"><%=p.getName() %></h5>
						<h6 class="price">Price: <%=p.getPrice() %></h6>
						<h6 class="category">Category: <%=p.getCategory() %></h6>
						<div class="mt-3d-flexjustify-content-between">
							<a href="add-to-cart?id=<%=p.getId() %>" class="btn btn-dark">Add to cart</a> 
							<a href="order-now?quantity=1&id=<%=p.getId() %>" class="btn btn-primary">Buy now</a>
						</div>
					</div>
				</div>
			</div>
			<%
			}
			}
			%>
                                                                                                                                                     
		</div>

		<!-- container close -->
	</div>



	<%@include file="includes/footer.jsp"%>
</body>
</html>