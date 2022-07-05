package kr.co.zimmyrabbit.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

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
	public @ResponseBody String komoranSendFile(MultipartFile file) {
		
		System.out.println(file.getOriginalFilename());
		try {
			InputStreamReader isr = new InputStreamReader(file.getInputStream(), "UTF-8");
			
			BufferedReader br = new BufferedReader(isr);
			
	        String str;
	        
	        while ((str = br.readLine()) != null) {
	        	System.out.println(str);        
	        }
	        
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return "success";
	}
}
