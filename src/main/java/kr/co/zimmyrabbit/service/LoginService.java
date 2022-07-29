package kr.co.zimmyrabbit.service;

import java.util.HashMap;

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
	
	
}
