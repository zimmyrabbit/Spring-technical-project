package kr.co.zimmyrabbit.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.co.shineware.nlp.komoran.constant.DEFAULT_MODEL;
import kr.co.shineware.nlp.komoran.core.Komoran;
import kr.co.shineware.nlp.komoran.model.KomoranResult;

@Service
public class KomoranService {
	
	private Logger log = LoggerFactory.getLogger(this.getClass());

	Komoran nlp = new Komoran(DEFAULT_MODEL.LIGHT);
	
	//자연어 처리 - 형태소 분석 (명사만 추출)
	public List<String> doWordNouns(String text) throws Exception {

		log.info(this.getClass().getName() + ".doWordAnalysis Start !");
		
		log.info("분석할 문장 : " + text);
		
		//분석할 문장에 대해 정제(쓸데없는 특수문자 제거)
		String replace_text = text.replace("[^가-힣a-zA-Z0-9", " ");
		
		log.info("한국어, 영어, 숫자 제외 단어 모두 한 칸으로 변환시킨 문장 : " + replace_text);
		
		//분석할 문장의 앞, 뒤에 존재할 수 있는 필요없는 공백 제거
		String trim_text = replace_text.trim();
		
		log.info("분석할 문장 앞, 뒤에 존재할 수 있는 필요 없는 공백 제거 : " + trim_text);
		
		//형태소 분석 시작
		KomoranResult analyzeResultList = this.nlp.analyze(trim_text);
		
		//형태소 분석 결과 중 명사만 가져오기
		List<String> rList = analyzeResultList.getNouns();
		
		if (rList == null) {
			rList = new ArrayList<String>();
		}
		
		//분석 결과 확인을 위한 로그 찍기
		Iterator<String> it = rList.iterator();
		
		while (it.hasNext()) {
			//추출된 명사
			String word = it.next();
			
			log.info("word : " + word);
		}
		
		
		log.info(this.getClass().getName() + ".doWordAnalysis End !");
		
		return rList;
	}

	//빈도수 분석(단어별 출현 빈도수)
	public HashMap<String, Integer> doWordCount(List<String> pList) throws Exception {

		log.info(this.getClass().getName() + ".doWordCount Start !");
		
		if (pList ==null) {
			pList = new ArrayList<String>();
		}
		
		HashMap<String, Integer> rMap = new HashMap<>();
		
		//List에 존재하는 중복되는 단어들의 중복제거를 위해 set에 데이터 저장.
		//rSet 변수는 중복된 데이터가 저장되지 않기 떄문에 중복되지 않은 단어만 저장하고 나머지는 자동 삭제.
		Set<String> rSet = new HashSet<String>(pList);
		
		//빈도수 구하기
		Iterator<String> it = rSet.iterator();
		
		while(it.hasNext()) {
			//중복 제거된 단어
			String word = it.next();
			
			//단어가 중복 저장되어 있는 pList로부터 단어의 빈도수 가져오기
			int frequency = Collections.frequency(pList, word);
			
			log.info("word :" + word);
			log.info("frequency : " + frequency);
			
			rMap.put(word, frequency);
		}
		
		log.info(this.getClass().getName() + ".doWordCount End !");
		
		return rMap;
	}

	//분석할 문장의 자연어 처리 및 빈도수 분석 수행
	public HashMap<String, Integer> doWordAnalysis(String text) throws Exception {

		//문장의 명사를 추출하기 위한 형태소 분석 실행
		List<String> rList = this.doWordNouns(text);
		
		if(rList == null) {
			rList = new ArrayList<String>();
		}
		
		//추출된 명사 모음(리스트)의 명사 단어별 빈도수 계산
		HashMap<String, Integer> rMap = this.doWordCount(rList);
		
		if(rMap == null) {
			rMap = new HashMap<String, Integer>();
		}
		
		return rMap;
	}

}
