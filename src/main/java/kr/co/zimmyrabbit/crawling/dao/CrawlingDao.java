package kr.co.zimmyrabbit.crawling.dao;

import java.util.HashMap;
import java.util.List;

public interface CrawlingDao {

	public void insertScrapNews(HashMap<String, String> map);

	public List<HashMap<String,Object>> getScrapListRoot(String registid);

	public List<HashMap<String,Object>> getScrapListNode(String registid);

	public void deleteNewsScrap(int seq);

}
