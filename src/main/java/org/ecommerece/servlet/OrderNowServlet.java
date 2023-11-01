package org.ecommerece.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.ecommerece.connection.DbCon;
import org.ecommerece.dao.OrderDao;
import org.ecommerece.model.Cart;
import org.ecommerece.model.Order;
import org.ecommerece.model.User;

@WebServlet("/order-now")
public class OrderNowServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try(PrintWriter out = response.getWriter()){
		//out.print("this is order now servlet");
		
		
		//to get date
		SimpleDateFormat formatter = new SimpleDateFormat();
		Date date = new Date();
		
		
		
		//identify user by importing User Model
		User auth = (User) request.getSession().getAttribute("auth");
		
		//check user is exists or logged in
		if(auth != null) {
			//collect data from user/form
			String productId = request.getParameter("id");
			int productQuantity = Integer.parseInt(request.getParameter("quantity"));
			
			//we can't order product quantity less than 1 so if it is 0 make it 1
			if(productQuantity<=0) {
				productQuantity=1;
			}
			
			Order orderModel = new Order();
			orderModel.setId(Integer.parseInt(productId));
			orderModel.setUid(auth.getId());
			orderModel.setQuantity(productQuantity);
			orderModel.setDate(formatter.format(date));
			
			OrderDao orderDao = new OrderDao(DbCon.getConnection());
			boolean result = orderDao.insertOrder(orderModel);
			
			if(result) {
				ArrayList<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");
				if(cart_list!=null) {
					for(Cart c:cart_list) {
						if(c.getId()==Integer.parseInt(productId)) {
							cart_list.remove(cart_list.indexOf(c));
							break;
						}
					}
					response.sendRedirect("cart.jsp");
				}
				
				response.sendRedirect("orders.jsp");
			}
			else {
				response.sendRedirect("Order Failed");
			}
			
		}else {
			response.sendRedirect("login.jsp");
		}
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
