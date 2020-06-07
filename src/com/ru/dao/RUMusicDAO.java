package com.ru.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.springframework.stereotype.Repository;

import com.ru.entity.User;

@Repository
public class RUMusicDAO {
	private static final String URL = "jdbc:mysql://localhost:3306/rumusicdb";
	private static final String USER = "root";
	private static final String PASSWORD = "root";

	public int submitDataToDB(User user) throws Exception{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection(URL, USER, PASSWORD); 
		PreparedStatement ps = conn.prepareStatement("insert into userdata (fname,lname,uname,pswd,emailId,country) values(?,?,?,?,?,?)");
		
		ps.setString(1, user.getFname());
		ps.setString(2, user.getLname());
		ps.setString(3, user.getUname());
		ps.setString(4, user.getPswd());
		ps.setString(5, user.getEmailId());
		ps.setString(6, user.getCountry());
		
		int result = ps.executeUpdate();
		return result;
	}
	
	public Object validateUser(String uname, String pwd) throws Exception{
		String dbPwd = "";
		
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection(URL, USER, PASSWORD); 
		PreparedStatement ps = conn.prepareStatement("select * from userdata where uname= ?");
		
		ps.setString(1, uname);
		
		ResultSet rs = ps.executeQuery();
		
		if(rs.next()){
			dbPwd = rs.getString("pswd");
			if(dbPwd.equals(pwd)){
				User user = new User();
				user.setFname(rs.getString("fname"));
				user.setLname(rs.getString("lname"));
				user.setId(rs.getInt("id"));
				user.setCountry(rs.getString("country"));
				user.setEmailId(rs.getString("emailId"));
				
				return user;
			}else{
				return "Password you have entered is incorrect!";
			}
		}else{
			return "Username is incorrect!";
		}
	}
	
}
