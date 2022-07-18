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
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.zimmyrabbit.service.CrawlingService;

@Controller
public class CrawlingController {
	
	@Autowired CrawlingService crawlingService;
	
	public static final String WEB_DRIVER_ID = "webdriver.chrome.driver"; 
	public static final String WEB_DRIVER_PATH = "D:/chromedriver/chromedriver.exe"; 
	public static final String URL = "https://www.google.co.kr/alerts";
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value="/seleniumhq/seleniumhq", method=RequestMethod.GET)
	public void SeleniumhqMain(){}
	
	@RequestMapping(value="/seleniumhq/seleniumhq", method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> searchCrawling(HttpServletRequest request, Model model) {
		
		//REQUEST VARIABLE
		String searchText = request.getParameter("query");
		String siteParam = request.getParameter("siteflag");
		int pagingParam = Integer.parseInt(request.getParameter("pageflag"));
		logger.info("=========searchText=========> " + searchText);
		logger.info("=========pagingParam========> " + pagingParam);
		
		//RESPONSE OBJECT
		HashMap<String, Object> map = new HashMap<>();
		
		//NAVER NEWS API
		if("0".equals(siteParam) || "1".equals(siteParam)) {
			//String naverNewsJson = crawlingService.searchNaverNewsAPI(searchText);
			//map.put("naver", naverNewsJson);
			
			HashMap<String, Object> naverNews = crawlingService.searchNaverNews(searchText, pagingParam);
			map.put("naver", naverNews);
		}
		
		//DAUM JSOUP CRAWLING
		if("0".equals(siteParam) || "2".equals(siteParam)) {
			HashMap<String, Object> daumNews = crawlingService.searchDaumNews(searchText, pagingParam);
			map.put("daum", daumNews);
		}
		
		//GOOGLE JSOUP CRAWLING
		if("0".equals(siteParam) || "3".equals(siteParam)) {
			HashMap<String, Object> googleNews = crawlingService.searchGoogleNews(searchText, pagingParam);
			map.put("google", googleNews);
		}
		
		return map;
	}
	
	@RequestMapping(value="/seleniumhq/setScrapNews", method=RequestMethod.GET)
	@ResponseBody
	public void setScraoNews(HttpServletRequest request) {
		String data = request.getParameter("data");
		
		crawlingService.setScarpNews(data);
	}
	
	@RequestMapping(value="/seleniumhq/getScrapList", method=RequestMethod.POST)
	public @ResponseBody HashMap<String,Object> getScrapList() {
		
		//추후 로그인 기능 만들면 세션값 넣어주면 됨
		String registid = "unname";
		
		HashMap<String,Object> map = crawlingService.getScrapList(registid);
		
		return map;
	}
	
	@RequestMapping(value="/seleniumhq/delNewsScrap", method=RequestMethod.GET)
	public @ResponseBody void delNewsScrap(HttpServletRequest request) {
		
		int seq = Integer.parseInt(request.getParameter("seq"));
		
		crawlingService.delNewsScrap(seq);
	}
	
}