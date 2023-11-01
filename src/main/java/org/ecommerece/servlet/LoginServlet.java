package org.ecommerece.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.ecommerece.connection.DbCon;
import org.ecommerece.dao.UserDao;
import org.ecommerece.model.User;


@WebServlet("/user-login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("login.jsp");
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		//out.print("Login Servlet");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		try {
			UserDao udao = new UserDao(DbCon.getConnection());
			User user = udao.userLogin(email, password);
			
			if(user != null) {
				//out.print("User Logged-in Successfully");
				//Session
				request.getSession().setAttribute("auth", user);
				response.sendRedirect("index.jsp");
			}else {
				out.print("User is notLogged-in Successfully");
			}
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			out.print("Exception"+e);
			e.printStackTrace();
		}
	}

}
