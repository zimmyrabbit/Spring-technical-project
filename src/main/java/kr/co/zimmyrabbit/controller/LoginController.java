package kr.co.zimmyrabbit.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class LoginController {
	
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

	@RequestMapping(value="/login/loginform", method=RequestMethod.GET)
	public void LoginForm() {}
	
	@RequestMapping(value="/login/login", method=RequestMethod.POST)
	public void login(HttpServletRequest req, HttpServletResponse response, HttpSession session) throws IOException {
		
		System.out.println(req.getParameter("id"));
		System.out.println(req.getParameter("pw"));
		
		session.setAttribute("id", req.getParameter("id"));
		
		response.sendRedirect("/seleniumhq/seleniumhq");
		
	}
	
	
}
