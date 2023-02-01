package kr.co.zimmyrabbit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MedicalPlanningCrawController {

	@RequestMapping(value="/medicalplanning/main", method=RequestMethod.GET)
	public void SeleniumhqMain(){}
}
