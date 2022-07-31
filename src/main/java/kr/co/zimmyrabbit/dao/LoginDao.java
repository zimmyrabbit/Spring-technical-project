package kr.co.zimmyrabbit.dao;

import java.util.HashMap;

public interface LoginDao {

	public int checkID(String parameter);

	public HashMap<String, String> getUserInfo(String parameter);

	public void setTimer(HashMap<String, String> map);

}
