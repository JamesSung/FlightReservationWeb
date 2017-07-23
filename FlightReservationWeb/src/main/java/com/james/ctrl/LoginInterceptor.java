package com.james.ctrl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

@Component
public class LoginInterceptor extends HandlerInterceptorAdapter  {


	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		//|| !(Boolean)request.getSession().getAttribute("admin")
		if(request.getSession().getAttribute("admin") == null || !(Boolean)request.getSession().getAttribute("admin")){
	    	request.getSession().setAttribute("msg", "Hey! You are not allowed to access the page.");
	    	
	    	response.sendRedirect(request.getContextPath()+ "/error.jsp");
			//System.out.println(request.getAttribute("msg"));
	    	
	    	return false;
		}
    	
		return true;
	}	


} 