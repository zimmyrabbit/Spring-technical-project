<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<!-- Bootstrap 3.3.2 -->
<script type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<style type="text/css">
@import url(https://fonts.googleapis.com/css?family=Open+Sans);

body {
	background: #f2f2f2;
	font-family: 'Open Sans', sans-serif;
}

.top_DIV {
	text-align: center;
	vertical-align: middle;
	margin: 0 auto;
}

.search_box_DIV {
	display: inline-block;
	width: 500px;
	margin-top: 50px;
}

.parentNewsDiv {
	width: 95%;
	margin: 10px auto;
	display: flex;
}

.naverNewsDiv {
	flex: 1;
	width: 32%;
	box-sizing: border-box;
}

.daumNewsDiv {
	border: 1px solid green;
	flex: 1;
	margin: 0px 1%;
	width: 32%;
	box-sizing: border-box;
}

.googleNewsDiv {
	border: 1px solid blue;
	flex: 1;
	width: 32%;
	box-sizing: border-box;
}

.newsHead {
	text-align: center
}

.font {
	font-size: 10px;
}

.RegTmArr {
	width: 10%;
}

.search_box_DIV {
	text-align: center;
}

.search_box {
	width: 400px;
	height: 60px;
	display: inline;
	border: none;
	border-bottom: 2px solid black;
	background: #f2f2f2;
	margin-top: 50px;
	font-size: x-large;
}

.tree {
	margin-top: 5px;
}

.tree, .tree ul {
	list-style: none; /* 기본 리스트 스타일 제거 */
	padding-left: 10px;
}

.tree *:before {
	width: 15px;
	height: 15px;
	display: inline-block;
}

.tree label {
	cursor: pointer;
	font-family: NotoSansKrMedium, sans-serif !important;
	font-size: 14px;
	color: #0055CC;
}

.tree label:hover {
	color: #00AACC;
}

.tree label:before {
	content: '+'
}

.tree label.lastTree:before {
	content: 'o';
}

.tree label:hover:before {
	content: '+'
}

.tree label.lastTree:hover:before {
	content: 'o';
}

.tree input[type="checkbox"] {
	display: none;
}

.tree input[type="checkbox"]:checked ~ul {
	display: none;
}

.tree input[type="checkbox"]:checked+label:before {
	content: '-'
}

.tree input[type="checkbox"]:checked+label:hover:before {
	content: '-'
}

.tree input[type="checkbox"]:checked+label.lastTree:before {
	content: 'o';
}

.tree input[type="checkbox"]:checked+label.lastTree:hover:before {
	content: 'o';
}

button {
	background-color: #101B41;
	padding: 5px 10px;
	border-radius: 4px;
	cursor: pointer;
	color: white;
}

.modal {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	display: flex;
	justify-content: center;
	align-items: center;
}

.modal .bg {
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.6);
}

.modalBox {
	position: absolute;
	background-color: #fff;
	width: 800px;
	height: 400px;
	padding: 15px;
	overflow-y: auto;
}

.modalBox button {
	display: block;
	width: 80px;
	margin: 0 auto;
}

.hidden {
	display: none;
}

.newslink:link {
	color: black;
	text-decoration: none;
}

.newslink:hover {
	color: blue;
	font-size: 15px;
}

.scrapNewslink:link {
	color: black;
	text-decoration: none;
}

.scrapNewslink:hover {
	color: blue;
	text-decoration: none;
}

#toast {
	position: absolute;
	left: 50%;
	top: 35%;
	width: 200px;
	height: 40px;
	padding: 15px 20px;
	transform: translate(-50%, 10px);
	border-radius: 30px;
	overflow: hidden;
	font-size: .8rem;
	opacity: 0;
	visibility: hidden;
	transition: opacity .5s, visibility .5s, transform .5s;
	background: rgba(0, 0, 0, .35);
	color: #fff;
	z-index: 10000;
	text-align: center;
	vertical-align: middle;
}

#toast.reveal {
	opacity: 1;
	visibility: visible;
	transform: translate(-50%, 0);
	text-align: center;
	vertical-align: middle;
}

/* section calendar */
.sec_cal {
	width: 450px;
	margin: 0 auto;
	font-family: "NotoSansR";
}

.sec_cal .cal_nav {
	display: flex;
	justify-content: center;
	align-items: center;
	font-weight: 700;
	font-size: 48px;
	line-height: 78px;
}

.sec_cal .cal_nav .year-month {
	width: 300px;
	text-align: center;
	line-height: 1;
}

.sec_cal .cal_nav .nav {
	display: flex;
	border: 1px solid #333333;
	border-radius: 5px;
}

.sec_cal .cal_nav .go-prev, .sec_cal .cal_nav .go-next {
	display: block;
	width: 50px;
	height: 78px;
	font-size: 0;
	display: flex;
	justify-content: center;
	align-items: center;
}

.sec_cal .cal_nav .go-prev::before, .sec_cal .cal_nav .go-next::before {
	content: "";
	display: block;
	width: 20px;
	height: 20px;
	border: 3px solid #000;
	border-width: 3px 3px 0 0;
	transition: border 0.1s;
}

.sec_cal .cal_nav .go-prev:hover::before, .sec_cal .cal_nav .go-next:hover::before
	{
	border-color: #ed2a61;
}

.sec_cal .cal_nav .go-prev::before {
	transform: rotate(-135deg);
}

.sec_cal .cal_nav .go-next::before {
	transform: rotate(45deg);
}

.sec_cal .cal_wrap {
	padding-top: 40px;
	position: relative;
	margin: 0 auto;
}

.sec_cal .cal_wrap .days {
	display: flex;
	margin-bottom: 20px;
	padding-bottom: 20px;
	border-bottom: 1px solid #ddd;
}

.sec_cal .cal_wrap::after {
	top: 368px;
}

.sec_cal .cal_wrap .day {
	display: flex;
	align-items: center;
	justify-content: center;
	width: calc(100%/ 7);
	text-align: left;
	color: #999;
	font-size: 12px;
	text-align: center;
	border-radius: 5px
}

.current.today {
	background: rgb(211, 211, 211);
}

.sec_cal .cal_wrap .dates {
	display: flex;
	flex-flow: wrap;
	height: 290px;
}

.sec_cal .cal_wrap .day:nth-child(7n -1) {
	color: #3c6ffa;
}

.sec_cal .cal_wrap .day:nth-child(7n) {
	color: #ed2a61;
}

.sec_cal .cal_wrap .day.disable {
	color: #ddd;
}

.submessage {
	display: block;
}

.remaintime {
	border: 0 solid black;
	background: #f2f2f2;
	font-size: xx-large;
	width: 100px;
	margin: 30px 30px;
}

.form-field {
	height: 46px;
	padding: 0 16px;
	border: 2px solid #ddd;
	border-radius: 4px;
	font-family: 'Rubik', sans-serif;
	outline: 0;
	transition: .2s;
	margin-top: 20px;
}

.a3 {
	animation-delay: 2.2s;
}

.animation {
	animation-name: move;
	animation-duration: .4s;
	animation-fill-mode: both;
	animation-delay: 2s;
}

.form-field:focus {
	border-color: #0f7ef1;
}

header {
	justify-content: center;
	margin: auto;
}

.timerinputbox {
	width : 40px;
	text-align: center;
}

ul.tabs{
	margin: 0px;
	padding: 0px;
	list-style: none;
}
ul.tabs li{
	background: none;
	color: #222;
	display: inline-block;
	padding: 10px 15px;
	cursor: pointer;
}

ul.tabs li.current{
	background: #ededed;
	color: #222;
}

.tab-content{
	display: none;
	background: #ededed;
	padding: 15px;
}

.tab-content.current{
	display: inherit;
}
</style>

<meta charset="UTF-8">
<title>News Search Engine</title>
</head>
<body>
	<div class="top_DIV row justify-content-center shadow mx-4 px-4 mt-0 pt-0">
		<div class="search_box_DIV col-5 my-3">
			<label for="Timer">남은 시간:</label> <input id="Timer" type="text"
				value="" readonly class="remaintime" />
			<button id="timerSetting" onclick="startTimer()"
				class="btn btn-primary">시작</button>
			<button id="timerSetting" onclick="stopTimer()"
				class="btn btn-primary">중지</button>
			<hr>
			<div>
				<input id="setTime" type="text" style="width"
					value="${sessionScope.loginSession.TIMER}" placeholder="타이머 주기"
					class="rounded animation a3 timerinputbox" /><p style="display: inline-block;">&nbsp;분</p> <span
					class="submessage">타이머 주기는 분 단위로 입력해 주세요.</span>
			</div>
			<div>
				<input id="keyword" type="text"
					value="${sessionScope.loginSession.KEYWORD}" placeholder="키워드"
					class="rounded animation a3 w-50" /><p style="display: inline-block;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p><span class="submessage">키워드는
					쉼표(,)로 구분하여 입력해 주세요.</span>
			</div>
			<button id="timerSetting" onclick="saveTimer()"
				class="btn btn-primary">저장</button>
			<hr>
			<div class="align-middle">
				<input type="text" id="searchText" name="searchText"
					class="search_box" onkeydown="pressEnterKey(event)"
					placeholder="검색어 입력" />
				<button id="searchBtn" onclick="reqSearchText(1,1);"
					class="btn btn-primary">검색</button>
				<div id="inputstat"></div>
			</div>
			

		</div>

		<div class="search_box_DIV col-5 my-3">
			<div class="sec_cal" style="height: 500px;">
				<div class="cal_nav">
					<a href="javascript:;" class="nav-btn go-prev">prev</a>
					<div class="year-month"></div>
					<a href="javascript:;" class="nav-btn go-next">next</a>
				</div>
				<div class="cal_wrap">
					<div class="days">
						<div class="day">월</div>
						<div class="day">화</div>
						<div class="day">수</div>
						<div class="day">목</div>
						<div class="day">금</div>
						<div class="day">토</div>
						<div class="day">일</div>
					</div>
					<div class="dates"></div>
				</div>
			</div>
		</div>
		<div>
		</div>
	</div>
	
	<div>
		<ul class="tabs m-4">
			<li class="tab-link current" data-tab="tab-1">tab-1</li>
			<li class="tab-link" data-tab="tab-2">tab-2</li>
			<li class="tab-link" data-tab="tab-3">tab-3</li>
		</ul>
		
		<div id ="tab-1" class="tab-content m-4 shadow-lg current">
			<div id="newsHead" class="parentNewsDiv newsHead pt-4 h1 fw-bold">
				<div id="naverNewsHead" class="naverNewsDiv newsHead">News</div>
			</div>
	
			<div style="margin-left: 50px;">
				<button id="initBtn" onclick="initSearch(0)" class="btn btn-primary">초기화</button>
				<button id="scrapBtn" onclick="scrapNews()" class="btn btn-primary">스크랩</button>
				<button class="openBtn btn btn-primary" onclick="reqScrapList()">북마크</button>
			</div>
	
			<div id="newsBody" class="parentNewsDiv">
				<div class="naverNewsDiv">
					<div id="NewsBodyContent"></div>
					<div id="NewsBodyPaging" class="newsHead"></div>
				</div>
			</div>
	
			<div class="modal hidden">
				<div class="bg"></div>
				<div class="modalBox">
					<ul class="tree" id="scrapbox">
						<li><input type="checkbox" id="scrap"> <label
							for="root">ROOT</label>
							<ul id="rootbox">
							</ul></li>
					</ul>
					<div class="closeBtn">닫기</div>
				</div>
			</div>
	
			<div id="toast" class='text-center'></div>
		</div>
		<div id="tab-2" class="tab-content m-4 shadow-lg">
			<div id="viewBody" class="parentNewsDiv">
				<div class="naverNewsDiv">
					<div id="ViewBodyContent"></div>
					<div id="ViewBodyPaging" class="newsHead"></div>
				</div>
			</div>
		</div>
		<div id="tab-3" class="tab-content m-4 shadow-lg">
		tab3
		</div>
	</div>
	
	
</body>
<script type="text/javascript">

$(document).ready(function() {
	//scrap modal open attr
  	const open = () => {
  	  document.querySelector(".modal").classList.remove("hidden");
  	} 

  	//scrap modal close attr
 	const close = () => {
 	   document.querySelector(".modal").classList.add("hidden");
 	}
	
 	//scrap modal btn 
  	document.querySelector(".openBtn").addEventListener("click", open);
 	document.querySelector(".closeBtn").addEventListener("click", close);
 	document.querySelector(".bg").addEventListener("click", close);
 	
 	//calendar
 	calendarInit();
 	
 	//timer start
 	//startTimer();
 	if($("#setTime").value != "") {
 		startTimer(0);
 	}
 	
	$('ul.tabs li').click(function(){
		var tab_id = $(this).attr('data-tab');

		$('ul.tabs li').removeClass('current');
		$('.tab-content').removeClass('current');

		$(this).addClass('current');
		$("#"+tab_id).addClass('current');
	})
})

/*
 * [SEARCH ENGINE FUNCTION]
 * flag 	0 : -
 *		 	1 : stopTimer()
 */
function reqSearchText(timerflag, pageflag, saveSearch) {
	
	var query = "" 
	 
	if(nullCheck(saveSearch)) {
		query = saveSearch;	
	} else {
		query = $("#searchText").val();
	}

	if(!nullCheck(query)) {
		toast("검색어를 입력해 주세요.");
		return;
	} 
	
	if(timerflag == 1) {
		stopTimer();
	}

	openLoading();
	
	var newsFormData = '';
	var newsFromPaging = '';
	var cnt = 0;
	var newsData = "";
	
	$("#NewsBodyContent").html("");
	
	var arr = query.split(",");
	
	for(var i=0; i<arr.length; i++) {
		$.ajax({
			type : 'post'
			, url : '/seleniumhq/seleniumhq'
			, data : {"query" : arr[i]
					  ,"pageflag" : pageflag}
			, success : function(data) {
				
				if(cnt == 0) {
					newsData += "<table class='table table-striped table-hover text-center' id='table'>";
					newsData += "	<th width='30' class='text-center'></th> <th width='100' class='text-center'>플랫폼</th> <th width='100' class='text-center'>키워드</th> <th width='200' class='text-center'>뉴스사</th> <th width='800' class='text-center'>제목</th> <th width='100' class='text-center'>작성일</th>";
				}
				
				
				// NAVER NEWS SETTING
				//naverAPINewsSetting(data);
				newsData += naverNewsSetting(data,arr[cnt]);
				
				// DAUM NEWS SETTING	
				newsData += daumNewsSetting(data,arr[cnt]);
				
				// GOOGLE NEWS SETTING
				newsData += googleNewsSetting(data,arr[cnt]);
				
				cnt++;
				
				if((arr.length) == cnt) {
					
					newsData += "</table>";
					
					$("#NewsBodyContent").html(newsData);
					
					closeLoading();
				}
			},
			error : function(error) {
				closeLoading();
	
				alert("ERROR!");
			}
		})
	 }
	
	newsFromPaging += "<ul class='pagination'>"
	for(var j=1; j<11; j++) {
		newsFromPaging += "<li> <a class='newslink' onclick=reqSearchText(0," + j +",'" + query + "') href='#'>" + j + " </a> </li>";
	}
	newsFromPaging += "</ul>"

	$("#NewsBodyPaging").html(newsFromPaging);
	
}
 
/*
 * NAVER NEWS API SETTING FUNCTION
 */
 function naverAPINewsSetting(data) {
	 
	initSearch(1);
	
	var vNaverNews = "";
	 
	var vNaverNewsItem = JSON.parse(data.naver);
	 
	vNaverNews += "<table>"
	vNaverNews += "	<th></th> <th>뉴스사</th> <th>제목</th> <th class='RegTmArr'>작성일</th>"
	
	for(var i=0; i<vNaverNewsItem.display; i++) {
			
		var rawDate = new Date(vNaverNewsItem.items[i].pubDate);
		var date = rawDate.getFullYear() + "." + rawDate.getMonth() + "." + rawDate.getDate();
		
		vNaverNews += "	 <tr>"
		vNaverNews += "	  <td> <input type='checkbox' name='news_checkbox'> </td>"
		vNaverNews += "	  <td> </td>"
		vNaverNews += "   <td> <a class='newslink' id='" + vNaverNewsItem.items[i].link + "' onclick=newsPopup(this.id)>" + vNaverNewsItem.items[i].title + "</a> </td>"
		vNaverNews += "	  <td>" + date + "</td>"
	}
	
	vNaverNews += "</table>"
	
	$("#naverNewsBody").html(vNaverNews);
 }
 
 /*
  * NAVER NEWS SETTING FUNCTION
  */
 function naverNewsSetting(data,query) {
 	
 	initSearch(1);
 	
 	var vNaverNews = "";
 	var vNaverPaging = "";
 	
 	//NaverNews += "<table>"
 	//vNaverNews += "	<th></th> <th>뉴스사</th> <th>제목</th> <th>작성일</th>"
 	
 	for(var i=0; i<data.naver.NaverNewsTitleArr.length; i++) {
 		vNaverNews += "	 <tr>"
 		vNaverNews += "	  <td> <input type='checkbox' name='news_checkbox'> </td>"
 		vNaverNews += "	  <td> NAVER </td>"
 		vNaverNews += "	  <td>" + query + "</td>"
 		vNaverNews += "	  <td>" + data.naver.NaverNewsCompArr[i] + "</td>"
 		vNaverNews += "   <td> <a class='newslink' id='" + data.naver.NaverNewsHrefArr[i] + "' onclick=newsPopup(this.id)>" + data.naver.NaverNewsTitleArr[i] + "</a> </td>"
 		vNaverNews += "   <td class='font'>" + data.naver.NaverNewsRegTmArr[i] + "</td>"
 		vNaverNews += "  </tr>"
 	}
 	
 	//vNaverNews += "</table>"
 		
 	//$("#naverNewsBody").html(vNaverNews);
 	return vNaverNews;
 	
 	//for(var j=1; j<11; j++) {
 		//vNaverPaging += "<a class='newslink' onclick=reqSearchText(1," + j +",'" + query + "') href='#'>" + j + " </a>";
 	//}
 	
 	//$("#naverNewsPaging").html(vNaverPaging);
 }

/*
 * DAUM NEWS SETTING FUNCTION
 */
function daumNewsSetting(data,query) {
	
	initSearch(2);
	
	var vDaumNews = "";
	var vDaumPaging = "";
	
	//vDaumNews += "<table>"
	//vDaumNews += "	<th></th> <th>뉴스사</th> <th>제목</th> <th>작성일</th>"
	
	for(var i=0; i<data.daum.daumNewsTitleArr.length; i++) {
		vDaumNews += "	 <tr>"
		vDaumNews += "	  <td> <input type='checkbox' name='news_checkbox'> </td>"
		vDaumNews += "	  <td> DAUM </td>"
		vDaumNews += "	  <td>" + query + "</td>"
		vDaumNews += "	  <td>" + data.daum.daumNewsCompArr[i] + "</td>"
		vDaumNews += "    <td> <a class='newslink' id='" + data.daum.daumNewsHrefArr[i] + "' onclick=newsPopup(this.id)>" + data.daum.daumNewsTitleArr[i] + "</a> </td>"
		vDaumNews += "    <td class='font'>" + data.daum.daumNewsRegTmArr[i] + "</td>"
		vDaumNews += "   </tr>"
	}
	
	//vDaumNews += "</table>"
		
	//$("#daumNewsBody").html(vDaumNews);
	return vDaumNews;
	
	//for(var j=1; j<11; j++) {
		//vDaumPaging += "<a class='newslink' onclick=reqSearchText(2," + j +",'" + query + "') href='#'>" + j + " </a>";
	//}
	
	//$("#daumNewsPaging").html(vDaumPaging);
}
 
/*
 * GOOGLE NEWS SETTING FUNCTION
 */
function googleNewsSetting(data,query) {

	initSearch(3);
	
	var vGoogleNews = "";
	var vGooglePaging = "";
	
	//vGoogleNews += "<table>"
	//vGoogleNews += " <th></th> <th>뉴스사</th> <th>제목</th> <th>작성일</th>"	
	
	for(var i=0; i<data.google.googleNewsTitleArr.length; i++) {
		vGoogleNews += "  <tr>"
		vGoogleNews += "	<td> <input type='checkbox' name='news_checkbox'> </td>"
		vGoogleNews += "	<td> GOOGLE </td>"
		vGoogleNews += "	<td>" + query + "</td>"
		vGoogleNews += "	<td>" + data.google.googleNewsCompArr[i] + "</td>"
		vGoogleNews += "    <td> <a class='newslink' id='" + data.google.googleNewsHrefArr[i] + "' onclick=newsPopup(this.id)>" + data.google.googleNewsTitleArr[i] + "</a> </td>"
		vGoogleNews += "    <td class='font'>" + data.google.googleNewsRegTmArr[i] + "</td>"
		vGoogleNews += "  </tr>"
	}
	
	//vGoogleNews += "</table>"
	
	//$("#googleNewsBody").html(vGoogleNews);
	return vGoogleNews;
	
	//for(var j=1; j<11; j++) {
		//vGooglePaging += "<a class='newslink' onclick=reqSearchText(3," + j +",'" + query + "') href='#'>" + j + " </a>";
	//}
	
	//$("#googleNewsPaging").html(vGooglePaging);
}

/*
 * [INITIALIZATION FUNCTION]
 * flag		0 : SEARCH BAR / ALL NEWS BODY DIV - INIT
 *			1 : NAVER NEWS DIV - INIT
 *			2 : DAUM NEWS DIV - INIT
 *			3 : GOOGLE NEWS DIV - INIT
 */
function initSearch(flag) {
	if(flag == 0) {
		$("#searchText").val("");
		$("#NewsBodyContent").html("");
		$("#NewsBodyPaging").html("");
	} else if (flag == 1) {
		$("#naverNewsBody").html("");
		$("#naverNewsPaging").html("");
	} else if (flag == 2) {
		$("#daumNewsBody").html("");
		$("#daumNewsPaging").html("");
	} else if (flag == 3) {
		$("#googleNewsBody").html("");
		$("#googleNewsPaging").html("");
	}
}

/*
 * KEY DOWN FUNCTION
 */
 function pressEnterKey(e) {
	
	var code = e.code;
	var keyCode = event.keyCode;
	
	if(keyCode == 229) {
		$("#inputstat").html("한글 입력상태 입니다.");
	} else if(keyCode >= 65 && keyCode <= 90) {
		$("#inputstat").html("영문 입력상태 입니다.");
	}
	
    if(code == 'Enter'){
    	reqSearchText(1,1);
    }
}

/*
 * NULL CHECK FUNCTION
 */
function nullCheck(flag) {
	if(flag === "") {
		return false;
	} else if (flag === undefined) {
		return false;
	} else if (flag === null) {
		return false;
	} else if (flag === 0) {
		return false;
	}
	return true;
}

/*
 * CHECKED NEWS SCRAP FUNCTION
 */
 function scrapNews() {
		var tdArr = new Array();
		var checkbox = $("input[name=news_checkbox]:checked");
		
		if(!nullCheck(checkbox.length)) {
			toast("스크랩 하실 기사를 선택해 주세요.");
			return;
		}
		
		checkbox.each(function(i) {
		var tr = checkbox.parent().parent().eq(i);
		var td = tr.children();
		
		var comp = td.eq(3).text();
		var title = td.eq(4).text();
		var href = td.eq(4).children().attr("id");
		//var href = td.eq(2).children().attr("href");
		
		var data = new Object(); 
		
		data.comp = comp;
		data.title = title;
		data.href= href;
		
		tdArr.push(data);
		});
		
	var jsonData = JSON.stringify(tdArr);	
	
	$.ajax({
		type : 'get'
		, url : '/seleniumhq/setScrapNews'
		, data : {"data" : jsonData}
		, success : function(data) {
			$("input[type=checkbox]").prop("checked", false);
			toast("스크랩 되었습니다.");
		}
	})
}

 /*
  * LOADING POPUP OPEN FUNCTION
  */
 function openLoading() {
	    var maskHeight = $(document).height();
	    var maskWidth = window.document.body.clientWidth;
	    
	    var mask ="<div id='mask' style='position:absolute; z-index:9000; background-color:#000000; display:none; left:0; top:0;'></div>";

	    var loadingImg ='';
	    loadingImg += "<div id='loadingImg' style='position:absolute; top: calc(50% - (200px / 2)); width:100%; z-index:99999999;'>";
	    loadingImg += " <img src='/resources/image/Spinner.gif' style='position: relative; display: block; margin: 0px auto;'/>";
	    loadingImg += "</div>"; 

	    $('body')
	    		.append(mask)
	    		.append(loadingImg)
	    $('#mask').css({
	            'width' : maskWidth,
	            'height': maskHeight,
	            'opacity' :'0.3'
	    });
	    $('#mask').show();  
	    $('#loadingImg').show();
}
 
 /*
  * LOADING POPUP CLOSE FUNCTION
  */
 function closeLoading() {
     $('#mask, #loadingImg').hide();
     $('#mask, #loadingImg').empty(); 
 }
 
 /*
  * SCRAP BOOKMARK SELECT FUNCTION
  */
 function reqScrapList() {
	$.ajax({
		type : 'post'
		, url : '/seleniumhq/getScrapList'
		, data : {}
		, success : function(data) {
			
			var root = "";
			
			for(var i=0; i<data.root.length; i++) {
				root += "<li id='node" + i + "box'>"
			    root +=    "<input type='checkbox' id='nodetitle" + i + "'>"
			    root +=    "<label for='nodetitle" + i + "'>" + data.root[i].REGISTDT + "</label>"
			    root +=    "<ul id='node" + data.root[i].REGISTDT + "'>"
			    if(data.node.length > 0) {
			    	for(var j=0; j<data.node.length; j++) {
						if(data.node[j].REGISTDT == data.root[i].REGISTDT) {
							root += "<li>";
							root += "<input type='checkbox' id='node" + data.node[j].SEQ + "'>"
							root += "<label for='node" + data.node[j].SEQ + "' class='lastTree'> <a class='scrapNewslink' id='" + data.node[j].NEWSHREF + "' onclick=newsPopup(this.id)>" + data.node[j].NEWSTITLE + "</a> </label>";
							//root += "<label for='node" + data.node[j].SEQ + "' class='lastTree'> <a class='scrapNewslink' href='" + data.node[j],NEWSHREF +"'>" + data.node[j].NEWSTITLE + "</a> </label>";
							root += "<a style='font-size : small;' href='#' class='scrapNewslink' onclick='deleteNewsScrap(" + data.node[j].SEQ + ")'> x </a>"
							root += "</li>"
						}
			    	}
			    }
			    root +=    "</ul>"
			    root += "</li>"
			}

			$("#rootbox").html(root);
		},
		error : function(error) {

			alert("ERROR!");
		}
	})
 }
 
 /*
  * BOOKMARK DELETE FUNCTION
  */
 function deleteNewsScrap(seq) {
		$.ajax({
			type : 'get'
			, url : '/seleniumhq/delNewsScrap'
			, data : {"seq" : seq}
			, success : function(data) {
				reqScrapList();
			},
			error : function(error) {

				alert("ERROR!");
			}
		})
	 
 }
 
 /*
  * URL CLICK NEW POPUP OPEN FUNCTION
  */
 var cnt = 0;
 function newsPopup(url) {
	 cnt++;
	 window.open(url,"news" + cnt,"width=1500, height=1000, top=10, left=10");
 }
 
 /*
  * TOAST POPUP
  */
 let removeToast;
 function toast(string) {
     const toast = document.getElementById("toast");

     toast.classList.contains("reveal") ?
         (clearTimeout(removeToast), removeToast = setTimeout(function () {
             document.getElementById("toast").classList.remove("reveal")
         }, 1000)) :
         removeToast = setTimeout(function () {
             document.getElementById("toast").classList.remove("reveal")
         }, 2000)
     toast.classList.add("reveal"),
     toast.innerText = string
 }
 
 
 /*
  * TIMER SETTING FUNCTION
  * flag : 0 - start
  *        1 - stop
  */
 const startTimer = function(flag) {
	  
	 var settime = $("#setTime").val()
	 var keyword = $("#keyword").val()
	 
	 if(!nullCheck(settime)) {
		 toast("timer주기를 입력해 주세요");
		 return;
	 } else if (!nullCheck(keyword)) {
		 toast("키워드를 지정해 주세요");
		 return;
	 }
	
	stopTimer(); 
	 
	reqSearchText(0,1,keyword);
	 
 	var Timer = document.getElementById('Timer');
 	var time = parseInt(settime) * 60000
 	//var time = 입력한 분 * 60000;
 	var min = parseInt(settime);
 	//var min = 입력한 분
 	var sec = 60;
 	//var sec = 60;
 	
 	Timer.value=min+":"+'00'; 
 	
    const interval = setInterval(function(){
    	
	        time=time-1000;
	        min=time/(60*1000);
	        
	       if(sec >= 10){
	            sec=sec-1;
	            Timer.value=Math.floor(min)+' : '+sec;
	       } else if(sec < 10 && sec > 0) {
	           sec=sec-1;
	           Timer.value=Math.floor(min)+' : 0'+sec;
	       } else if(sec === 0) {
		  		sec=60;
		       	Timer.value=Math.floor(min)+' : '+'00'
	       }
	        
	       if(Math.floor(min) === 0 && sec === 0) {
	    	   reqSearchText(0,1,keyword);
			   time = parseInt(settime) * 60000;
			   min = parseInt(settime);
			   sec = 60;
	       } 
    },1000);
 }
 
 /*
  * TimerTime, Keyword Save Function
  */
 function saveTimer() {
	 
	 var settime = $("#setTime").val()
	 var keyword = $("#keyword").val()
	 var id = '${sessionScope.loginSession.ID}'
	 
 	$.ajax({
		type : 'get'
		, url : '/login/saveTimer'
		, data : {"setTime" : settime
				, "keyword" : keyword
				, "loginSeq" : ${sessionScope.loginSession.SEQ}
 				, "id" : id}
		, success : function(data) {
			window.location.reload();
		},
		error : function(error) {

			alert("ERROR!");
		}
	})
 }
 
 function stopTimer() {
	 
	 var highestIntervalId = setInterval(";");
	 for (var i = 0 ; i < highestIntervalId ; i++) {
	   clearInterval(i);
	 }
 }
 
 function calendarInit() {

	    var date = new Date();
	    var utc = date.getTime() + (date.getTimezoneOffset() * 60 * 1000);
	    var kstGap = 9 * 60 * 60 * 1000;
	    var today = new Date(utc + kstGap);
	  
	    var thisMonth = new Date(today.getFullYear(), today.getMonth(), today.getDate());
	    
	    var currentYear = thisMonth.getFullYear();
	    var currentMonth = thisMonth.getMonth();
	    var currentDate = thisMonth.getDate();

	    renderCalender(thisMonth);

	    function renderCalender(thisMonth) {

	        currentYear = thisMonth.getFullYear();
	        currentMonth = thisMonth.getMonth();
	        currentDate = thisMonth.getDate();

	        // 이전 달의 마지막 날 날짜와 요일 구하기
	        var startDay = new Date(currentYear, currentMonth, 0);
	        var prevDate = startDay.getDate();
	        var prevDay = startDay.getDay();

	        // 이번 달의 마지막날 날짜와 요일 구하기
	        var endDay = new Date(currentYear, currentMonth + 1, 0);
	        var nextDate = endDay.getDate();
	        var nextDay = endDay.getDay();
	        
	        // 현재 월 표기
	        $('.year-month').text(currentYear + '.' + (currentMonth + 1));

	        calendar = document.querySelector('.dates')
	        calendar.innerHTML = '';
	        
	        // 지난달
	        for (var i = prevDate - prevDay + 1; i <= prevDate; i++) {
	            calendar.innerHTML = calendar.innerHTML + '<div class="day prev disable">' + i + '</div>'
	        }
	        // 이번달
	        for (var i = 1; i <= nextDate; i++) {
	            calendar.innerHTML = calendar.innerHTML + '<div class="day current">' + i + '</div>'
	        }
	        // 다음달
	        for (var i = 1; i <= (7 - nextDay == 7 ? 0 : 7 - nextDay); i++) {
	            calendar.innerHTML = calendar.innerHTML + '<div class="day next disable">' + i + '</div>'
	        }

	        // 오늘 날짜 표기
	        if (today.getMonth() == currentMonth) {
	            todayDate = today.getDate();
	            var currentMonthDate = document.querySelectorAll('.dates .current');
	            currentMonthDate[todayDate -1].classList.add('today');
	        }
	    }

	    // 이전달로 이동
	    $('.go-prev').on('click', function() {
	        thisMonth = new Date(currentYear, currentMonth - 1, 1);
	        renderCalender(thisMonth);
	    });

	    // 다음달로 이동
	    $('.go-next').on('click', function() {
	        thisMonth = new Date(currentYear, currentMonth + 1, 1);
	        renderCalender(thisMonth); 
	    });
}
  
</script>

</html>