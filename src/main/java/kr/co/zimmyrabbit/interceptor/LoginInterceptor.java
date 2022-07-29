package kr.co.zimmyrabbit.interceptor;

import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

public class LoginInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		HashMap<String,Object> sessionInfo = (HashMap<String,Object>) request.getSession().getAttribute("loginSession");
		
		if(sessionInfo != null) {
			return true;
		} else {
			
			response.setContentType("text/html; charset=UTF-8");

            PrintWriter out = response.getWriter();

			out.print("<script>location.replace('/login/loginform'); </script>");
			
			out.flush();
			out.close();

			return false;
		}
	}

}
