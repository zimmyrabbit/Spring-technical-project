package kr.co.zimmyrabbit.crawling.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.zimmyrabbit.crawling.service.CrawlingService;

@Controller
public class CrawlingController {
	
	@Autowired CrawlingService crawlingService;
	
	public static final String WEB_DRIVER_ID = "webdriver.chrome.driver"; 
	public static final String WEB_DRIVER_PATH = "D:/chromedriver/chromedriver.exe"; 
	public static final String URL = "https://www.google.co.kr/alerts";
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value="/seleniumhq/seleniumhq", method=RequestMethod.GET)
	public void SeleniumhqMain() {}
	
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
	
	
	/*
	 *  ======== <<개선사항>> ========
	 *  
	 *  1. 뉴스 기사 작성한 회사(?)명 가져오기
	 *  	-> 네이버 API에서는 제공해주는게 없다...
	 *  	-> 구글, 다음은 크롤링으로 가져왔음
	 *  	-> 네이버도 크롤링으로 바꿔야하나 -> 네이버 크롤링도 일단 만들어둠
	 *  
	 *  2. 뉴스 기사 작성한 시간 가져오기
	 *  	-> NAVER :
	 *  	-> DAUM :
	 *  		하루 이내 기사 : xx분 전 , xx 시간 전 
	 *  		하루 이후 기사 : 2022.xx.xx
	 *  	-> GOOGLE : 
	 *  		하루 이내 기사 : xx분 전 , xx 시간 전
	 *  		하루 이후 기사 : x일 전
	 *  
	 *  3. UI 디자인 
	 *  	-> INPUT , BUTTON 태그 디자인 찾아보기
	 *  	-> 네이버, 다음, 구글 기사별로 모으기
	 *  	-> 10개씩 보이도록 페이징 처리를 할까
	 *  
	 *  4. 자바스크립트 타이머
	 *  	-> 예를들어 5분정도마다 기사 갱신되도록
	 *  	-> 타이머초기화 버튼 or 검색버튼 누르면 즉시 갱신
	 *  
	 *  5. 웹 WAS 서버에 올리는 방안
	 *  
	 *  6. .EXE 실행파일로 만드는방법
	 *  	-> JAVA : SWING , AWT 등 사용 ??
	 *  	-> C# 으로 생성??
	 *  
	 *  7. 기사 스크랩 및 저장기능 DB연결 필요
	 *  
	 */
	
}