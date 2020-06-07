package com.ru.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ru.entity.User;
import com.ru.service.ServiceClass;

@Controller
public class MainController {
	
	@Autowired
	private ServiceClass sclass;
	
	@RequestMapping(value="/signup.htm",method=RequestMethod.GET)
	public ModelAndView renderSignUp(){
		ModelAndView modelAndView = new ModelAndView("signup.jsp");
		return modelAndView;
	}
	
	@RequestMapping(value="/savedata.htm", method=RequestMethod.POST)
	public ModelAndView getData(HttpServletRequest request,HttpServletResponse response){
		User user = new User();
		user.setFname(request.getParameter("fn"));
		user.setLname(request.getParameter("ln"));
		user.setCountry(request.getParameter("cnt"));
		user.setEmailId(request.getParameter("email"));
		user.setUname(request.getParameter("un"));
		user.setPswd(request.getParameter("pwd"));
	
		String message = sclass.submitDataToDB(user);
		
		ModelAndView modelAndView = new ModelAndView("index.jsp","responseMessage",message);
		return modelAndView;
	}
	
	@RequestMapping(value="/validate.htm",method=RequestMethod.POST)
	public ModelAndView recognizeUser(HttpServletRequest request,HttpServletResponse response){
		Object responseObject = sclass.validateUser(request.getParameter("un"), request.getParameter("pwd"));
		ModelAndView modelAndView;
		if(responseObject.getClass()==User.class){
			User user = (User) responseObject;
			modelAndView = new ModelAndView("landingPage.jsp","userinfo",user);
		}else{
			modelAndView = new ModelAndView("index.jsp","loginstatus",responseObject);
		}
		return modelAndView;
	}
		
	@RequestMapping(value="/questionset.htm", method=RequestMethod.GET)
	public ModelAndView renderQuestionPage(HttpServletRequest request, HttpServletResponse response){
		HttpSession session = request.getSession();
		User loggedInUser = (User) session.getAttribute("sessionUser");
		return new ModelAndView("questionForm.jsp","loggedInUser",loggedInUser);
	}
	
	@RequestMapping(value="/getplayer.htm", method=RequestMethod.GET)
	public ModelAndView renderMusicPlayer(HttpServletRequest request, HttpServletResponse response){
		ArrayList<String> ls = new ArrayList<String>();
		String baseURL = "http://0.0.0.0:5000/";
		String endPoint = "getmp3url?";
		
		String artist = request.getParameter("artist").replace(" ","%20");
		String userInput = request.getParameter("songName").replace(" ","%20");
		String songId = request.getParameter("songid");
		
	    try{
	    	URL url = new URL(baseURL + endPoint + "input=" + userInput + "&songid=" + songId + "&artist=" + artist);
	    	HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	    	conn.setRequestMethod("GET");
            
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP Error code : "
                        + conn.getResponseCode());
            }
            
            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String inputLine;
            StringBuffer sb = new StringBuffer();
            while ((inputLine = in.readLine()) != null) {
            	sb.append(inputLine);
            }
            in.close();
            
            JSONObject myResponse = new JSONObject(sb.toString());
            JSONObject tempjs = myResponse.getJSONObject("data");
            
            ls.add(myResponse.getString("url"));
            ls.add(tempjs.getString("song"));
            ls.add(tempjs.getString("date"));
            ls.add(tempjs.getString("artist"));
            ls.add(tempjs.getString("albumart"));
            ls.add(tempjs.getString("album"));
            ls.add(tempjs.getString("artist_image"));
            ls.add(tempjs.getString("id"));
            
            conn.disconnect();
            
	    }catch(Exception e){
	    	System.out.println(e.getMessage());
	    }
	    return new ModelAndView("songPlayer.jsp","fetchedData",ls);
	}
}