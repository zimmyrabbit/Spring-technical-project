package kr.co.zimmyrabbit.service;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.zimmyrabbit.dao.LoginDao;

@Service
public class LoginService {

	@Autowired
	LoginDao loginDao;

	public boolean checkID(String parameter) {
		
		int flag = loginDao.checkID(parameter);
		
		if(flag > 0) {
			return true;
		} else {
			return false;
		}
	}

	public HashMap<String, String> getUserinfo(String parameter) {
		
		return loginDao.getUserInfo(parameter);
	}

	public void saveTimer(HttpServletRequest req) {
		
		HashMap<String,String> map = new HashMap<>();
		
		map.put("seq", req.getParameter("loginSeq"));
		map.put("timer", req.getParameter("setTime"));
		map.put("keyword", req.getParameter("keyword"));
		
		loginDao.setTimer(map);
		
	}
	
	
}
