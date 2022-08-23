package kr.co.zimmyrabbit.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.co.zimmyrabbit.service.KomoranService;

@Controller
public class KomoranController {

	@Autowired KomoranService komoranService;
	
	private static final Logger logger = LoggerFactory.getLogger(KomoranController.class);
	
	@RequestMapping(value="/komoran/komoran", method=RequestMethod.GET)
	public void komoranMain() {}
	
	@RequestMapping(value="/komoran/sendfile", method=RequestMethod.POST)
	public @ResponseBody String komoranSendFile(MultipartFile file) throws Exception {
		
		System.out.println(file.getOriginalFilename());
		try {
			InputStreamReader isr = new InputStreamReader(file.getInputStream(), "UTF-8");
			
			BufferedReader br = new BufferedReader(isr);
			
	        String str;
	        String text = "";
	        int flag = 0;
	        
	        while ((str = br.readLine()) != null) {     
	        	if(flag == 0) {
	        		text += str;
	        	} else {
	        		text += " " + str;
	        	}
	        	flag++;
	        }
	        
	        HashMap<String,Integer> komoran = komoranService.doWordAnalysis(text);
	        
	        Set<String> keySet = komoran.keySet();
	        for (String key : keySet) {	
	        	System.out.println(key + " : " + komoran.get(key));	
	        }
	        
	        
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return "success";
	}
}
