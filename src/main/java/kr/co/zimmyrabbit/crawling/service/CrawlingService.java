package kr.co.zimmyrabbit.crawling.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service
public class CrawlingService {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public static final String NAVER_CLIENT_ID = "bLIhDQMaNcop4eQEk4A2"; 
	public static final String NAVER_CLIENT_SECRET = "6dGRdjAFPt"; 
	public static final String NAVER_NEWS_URL = "https://openapi.naver.com/v1/search/news?query="; 
	
	public static final String DAUM_NEWS_URL = "https://search.daum.net/search?w=news&DA=STC&enc=utf8&cluster=y&cluster_page=1&q=";

	public static final String GOOGLE_NEWS_URL_HEAD = "https://www.google.com/search?q=";
	public static final String GOOGLE_NEWS_URL_FOOT = "&hl=ko&tbm=nws&sxsrf=ALiCzsYdeFtL2xSjyr8NqUo93p6JSu5u_w:1655799156084&source=lnt&tbs=qdr:m&sa=X&ved=2ahUKEwif6JHEjL74AhV8mFYBHZe6CeEQpwV6BAgBEBw&biw=1536&bih=731&dpr=1.25&start=";
	
	/*
	 * NAVER NEWS SEARCH API <<START>>
	 */
	public String searchNaverNews(String searchText) {
		
        String textParam = null;
        int displayParam = 10;
        String sortParam = "date";
        
        try {
        	textParam = URLEncoder.encode(searchText, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("검색어 인코딩 실패",e);
        }

        String apiURL = NAVER_NEWS_URL + textParam + "&display=" + displayParam + "&sort=" + sortParam;

        Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("X-Naver-Client-Id", NAVER_CLIENT_ID);
        requestHeaders.put("X-Naver-Client-Secret", NAVER_CLIENT_SECRET);
        String responseBody = GetNaverApi(apiURL,requestHeaders);
		logger.info(responseBody);
		
		return responseBody;
	}
	
    private String GetNaverApi(String apiUrl, Map<String, String> requestHeaders){
        HttpURLConnection con = NaverApiConnect(apiUrl);
        try {
            con.setRequestMethod("GET");
            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
                con.setRequestProperty(header.getKey(), header.getValue());
            }

            int responseCode = con.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                return NaverApiReadBody(con.getInputStream());
            } else { 
                return NaverApiReadBody(con.getErrorStream());
            }
        } catch (IOException e) {
            throw new RuntimeException("API 요청과 응답 실패", e);
        } finally {
            con.disconnect();
        }
    }
    
    private HttpURLConnection NaverApiConnect(String apiUrl){
        try {
            URL url = new URL(apiUrl);
            return (HttpURLConnection)url.openConnection();
        } catch (MalformedURLException e) {
            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
        } catch (IOException e) {
            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
        }
    }

    private String NaverApiReadBody(InputStream body){
        InputStreamReader streamReader = new InputStreamReader(body);

        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
            StringBuilder responseBody = new StringBuilder();

            String line;
            while ((line = lineReader.readLine()) != null) {
                responseBody.append(line);
            }

            return responseBody.toString();
        } catch (IOException e) {
            throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
        }
    }
	/*
	 * NAVER NEWS SEARCH API <<END>>
	 */
	
    //==========================================
    
    /*
     * DAUM NEWS SEARCH JSOUP CRAWLING <<START>>
     */
    public HashMap<String, Object> searchDaumNews(String searchText, int pagingParam) {
    	
    	String textParam = "";
    	String sortParam = "recency";
    	int pageParam = pagingParam;
    	
    	HashMap<String, Object> map = new HashMap<>();
    	ArrayList<String> daumNewsTitleArr = new ArrayList<>();
    	ArrayList<String> daumNewsHrefArr = new ArrayList<>();
    	ArrayList<String> daumNewsCompArr = new ArrayList<>();
    	ArrayList<String> daumNewsRegTmArr = new ArrayList<>();
    	
        try {
        	textParam = URLEncoder.encode(searchText, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("검색어 인코딩 실패",e);
        }
        
        String URL = DAUM_NEWS_URL + textParam + "&sort=" + sortParam + "&p=" + pageParam;
    	
        Connection conn = Jsoup.connect(URL);
        
        try {
			Document html = conn.get();
			
			Elements ulTag = html.getElementsByClass("list_news");
			
			int liTagCnt = ulTag.toString().split("<li>").length-1;
			
			for(int i=0; i < liTagCnt; i++) {
				daumNewsTitleArr.add(html.getElementsByClass("list_news").get(0).getElementsByTag("li").get(i).getElementsByClass("wrap_cont").get(0).getElementsByTag("a").text());
				daumNewsHrefArr.add(html.getElementsByClass("list_news").get(0).getElementsByTag("li").get(i).getElementsByClass("wrap_cont").get(0).getElementsByTag("a").attr("href"));
				daumNewsCompArr.add(html.getElementsByClass("list_news").get(0).getElementsByTag("li").get(i).getElementsByClass("wrap_cont").get(0).getElementsByClass("cont_info").get(0).getElementsByClass("f_nb").get(0).text());
				daumNewsRegTmArr.add(html.getElementsByClass("list_news").get(0).getElementsByTag("li").get(i).getElementsByClass("wrap_cont").get(0).getElementsByClass("cont_info").get(0).getElementsByClass("f_nb").get(1).text());
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
        
        map.put("daumNewsTitleArr", daumNewsTitleArr);
        map.put("daumNewsHrefArr", daumNewsHrefArr);
        map.put("daumNewsCompArr", daumNewsCompArr);
        map.put("daumNewsRegTmArr", daumNewsRegTmArr);
        
    	return map;
    }
    /*
     * DAUM NEWS SEARCH JSOUP CRAWLING <<END>>
     */


    //==========================================

    
    /*
     * GOOGLE NEWS SEARCH JSOUP CRAWLING <<START>>
     */
    public HashMap<String, Object> searchGoogleNews(String searchText, int pagingParam) {
    	
    	String textParam = "";
    	int pageParam = 0;
    	
    	HashMap<String, Object> map = new HashMap<>();
    	ArrayList<String> googleNewsTitleArr = new ArrayList<>();
    	ArrayList<String> googleNewsHrefArr = new ArrayList<>();
    	ArrayList<String> googleNewsCompArr = new ArrayList<>();
    	ArrayList<String> googleNewsImgArr = new ArrayList<>();
    	ArrayList<String> googleNewsRegTmArr = new ArrayList<>();
    	
        try {
        	textParam = URLEncoder.encode(searchText, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("검색어 인코딩 실패",e);
        }
        
        String URL = GOOGLE_NEWS_URL_HEAD + textParam + GOOGLE_NEWS_URL_FOOT + pageParam;
    	
        Connection conn = Jsoup.connect(URL);
        
        try {
			Document html = conn.get();
			
			Elements divTag = html.getElementsByClass("v7W49e");
			
			int divTagCnt = divTag.toString().split("<div class=\"xuvV6b BGxR7d\"").length-1;
			
			for(int i=0; i < divTagCnt; i++) {
				googleNewsTitleArr.add(html.getElementsByClass("v7W49e").get(0).getElementsByClass("xuvV6b BGxR7d").get(i).getElementsByTag("div").get(0).getElementsByClass("WlydOe").get(0).getElementsByClass("vJOb1e aIfcHf Hw13jc").get(0).getElementsByClass("iRPxbe").get(0).getElementsByClass("mCBkyc y355M ynAwRc MBeuO nDgy9d").text());
				googleNewsHrefArr.add(html.getElementsByClass("v7W49e").get(0).getElementsByClass("xuvV6b BGxR7d").get(i).getElementsByTag("div").get(0).getElementsByClass("WlydOe").get(0).attr("href"));
				googleNewsCompArr.add(html.getElementsByClass("v7W49e").get(0).getElementsByClass("xuvV6b BGxR7d").get(i).getElementsByTag("div").get(0).getElementsByClass("WlydOe").get(0).getElementsByClass("vJOb1e aIfcHf Hw13jc").get(0).getElementsByClass("iRPxbe").get(0).getElementsByClass("CEMjEf NUnG9d").get(0).getElementsByTag("span").text());
				googleNewsRegTmArr.add(html.getElementsByClass("v7W49e").get(0).getElementsByClass("xuvV6b BGxR7d").get(i).getElementsByTag("div").get(0).getElementsByClass("WlydOe").get(0).getElementsByClass("vJOb1e aIfcHf Hw13jc").get(0).getElementsByClass("iRPxbe").get(0).getElementsByClass("OSrXXb ZE0LJd").get(0).getElementsByTag("span").text());
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
        
        map.put("googleNewsTitleArr", googleNewsTitleArr);
        map.put("googleNewsHrefArr", googleNewsHrefArr);
        map.put("googleNewsCompArr", googleNewsCompArr);
        map.put("googleNewsImgArr", googleNewsImgArr);
        map.put("googleNewsRegTmArr", googleNewsRegTmArr);
        
    	return map;
    }
    /*
     * GOOGLE NEWS SEARCH JSOUP CRAWLING <<END>>
     */
}
