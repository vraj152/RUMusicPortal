package com.ru.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ru.dao.RUMusicDAO;
import com.ru.entity.User;

@Service
public class ServiceClass {

	@Autowired
	private RUMusicDAO rudao;
	
	public String submitDataToDB(User user){
		String message = "";
		try{
			int result = rudao.submitDataToDB(user);
			if(result>=1){
				message = "Record inserted successfully!";
			}else{
				message = "Record could not be inserted!";
			}
		}catch(Exception e){
			message = e.getMessage();
		}
		return message;
	}
	
	public Object validateUser(String uname, String pwd){
		Object response;
		try{
			response = rudao.validateUser(uname, pwd);
		}catch(Exception e){
			response = e.getMessage();
		}
		return response;
	}
	
}