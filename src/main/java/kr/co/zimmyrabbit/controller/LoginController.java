package kr.co.zimmyrabbit.controller;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.zimmyrabbit.service.LoginService;

@Controller
public class LoginController {
	
	@Autowired
	LoginService loginService;
	
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

	@RequestMapping(value="/login/loginform", method=RequestMethod.GET)
	public void LoginForm() {}
	
	@RequestMapping(value="/login/login", method=RequestMethod.POST)
	public String login(HttpServletRequest req, HttpServletResponse response, HttpSession session, Model model) throws IOException {
		
		boolean flag = loginService.checkID(req.getParameter("id"));
		
		if(flag) {
			
			HashMap<String, String> map = loginService.getUserinfo(req.getParameter("id"));
			
			session.setAttribute("loginSession", map);
			
			//response.sendRedirect("/seleniumhq/seleniumhq");
			
			return "redirect:/seleniumhq/seleniumhq";
		} else {
			model.addAttribute("msg", "계정정보가 없습니다. 계정생성은 디지털혁신실로 문의 주세요."); 
			model.addAttribute("url", "/login/loginform"); 
			return "login/alert";
		}
		
		
		
	}
	
	
}
