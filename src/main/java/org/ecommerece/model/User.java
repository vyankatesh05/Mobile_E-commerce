package org.ecommerece.model;

public class User {
	private int id;
	private String name;
	private String email;
	private String password;
	
	public User() {
		
	}
	
	public User(int id, String name, String email, String password) {
		
		
		//this.(private global variable) = (variable in constructors parameter)
		this.id = id;
		this.name = name;
		this.email = email;
		this.password = password;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		//this.(private global variable) = (variable in SetID() parameter)
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", name=" + name + ", email=" + email + ", password=" + password + "]";
	}
	
	

}
