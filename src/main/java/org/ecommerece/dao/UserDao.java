package org.ecommerece.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.ecommerece.model.User;

public class UserDao {
	private Connection con;
	private String query;
	private PreparedStatement pst;
	private ResultSet rs;
	
	public UserDao(Connection con) {
		
		this.con = con;
		
	}
	
	//method to login user--- mport User.java
	public User userLogin(String email, String password) {
		//initially user is null
		User user = null;
		
		//check user email, password from database
		try {
		query = "select * from users where email=? and password = ?";
		pst= this.con.prepareStatement(query);
		pst.setString(1, email);
		pst.setString(2, password);
		rs = pst.executeQuery();
		
		if(rs.next()) {
			user = new User();
			//initially user was null then we checked if user is present create object of that user And set value in USER(check User.java for values) object 
			// here we use getter and setter function in User.java
			user.setId(rs.getInt("id"));
			user.setName(rs.getString("name"));
			user.setEmail(rs.getString("email"));
			
			//here we are not going return user password becoz not good practice and security reason
			
		}
		}
		catch(Exception e){
			e.printStackTrace();
			System.out.println("Exception occured: "+e);
		}
		return user;
		
		
	}
	
}
