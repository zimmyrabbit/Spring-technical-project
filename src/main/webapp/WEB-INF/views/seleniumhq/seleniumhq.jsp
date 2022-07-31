<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>

<!-- Bootstrap 3.3.2 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<style type="text/css">

@import url(https://fonts.googleapis.com/css?family=Open+Sans);

body{
  background: #f2f2f2;
  font-family: 'Open Sans', sans-serif;
}

.parentNewsDiv{
    width: 95%;
    margin: 10px auto;
    display: flex;
}

.naverNewsDiv {
    flex:1;
    width:32%;
    box-sizing: border-box;
}

.daumNewsDiv {
    border: 1px solid green;
    flex:1;
    margin: 0px 1%;
    width:32%;
    box-sizing: border-box;
}

.googleNewsDiv {
    border: 1px solid blue;
    flex:1;
    width:32%;
    box-sizing: border-box;
}

.newsHead {
	text-align : center
}

.font {
	font-size: 10px;
}

.RegTmArr {
	width : 10%;
}

.search_box_DIV {
	text-align: center;
}

.search_box {
	width:400px; 
	height : 30px;
	display:inline;
  border: none;
  border-bottom: 2px solid black;
  background: #f2f2f2;
}

.tree{
  margin-top: 5px;
}
.tree, .tree ul{
  list-style: none; /* 기본 리스트 스타일 제거 */
  padding-left:10px;
}
.tree *:before{
  width:15px;
  height:15px;
  display:inline-block;
}
.tree label{
  cursor: pointer;
  font-family: NotoSansKrMedium, sans-serif !important;
  font-size: 14px;
  color: #0055CC;
}
.tree label:hover{
  color: #00AACC;
}
.tree label:before{
  content: '+'
}
.tree label.lastTree:before{
  content:'o';
}
.tree label:hover:before{
  content: '+'
}
.tree label.lastTree:hover:before{
  content:'o';
}
.tree input[type="checkbox"] {
  display: none;
}
.tree input[type="checkbox"]:checked~ul {
  display: none;
}
.tree input[type="checkbox"]:checked+label:before{
  content: '-'
}
.tree input[type="checkbox"]:checked+label:hover:before{
  content: '-'
}

.tree input[type="checkbox"]:checked+label.lastTree:before{
  content: 'o';
}
.tree input[type="checkbox"]:checked+label.lastTree:hover:before{
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
	color : black;
	text-decoration: none;
}

.newslink:hover {
	color : blue;
	font-size : 15px;
}

.scrapNewslink:link {
	color : black;
	text-decoration: none;
}

.scrapNewslink:hover {
	color : blue;
	text-decoration: none;
}

#toast {
    position: absolute;
    left: 50%;
    top:35%;
    width:200px;
    height:40px;
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
    text-align:center;
    line-height: 40px;
}

#toast.reveal {
    opacity: 1;
    visibility: visible;
    transform: translate(-50%, 0)
}

</style>

<meta charset="UTF-8">
<title>News Search Engine</title>
</head>
<body>

<p>
 <label for="Timer">남은 시간:</label>
 <input id="Timer" type="text" value="" readonly/>
 <input id="setTime" type="text" value="${sessionScope.loginSession.TIMER}" placeholder="timer 주기"/>
 <input id="keyword" type="text" value="${sessionScope.loginSession.KEYWORD}" placeholder="키워드"/>
 <button id="timerSetting" onclick="startTimer()">시작</button>
 <button id="timerSetting" onclick="stopTimer()">중지</button>
 <button id="timerSetting" onclick="saveTimer()">저장</button>
</p>

<div class="search_box_DIV">
	<input type="text" id="searchText" name="searchText" class="search_box" onkeypress="pressEnterKey(event)" placeholder="검색어 입력"/>
	<button id="searchBtn" onclick="reqSearchText(0,1); stopTimer();">검색</button>
</div>

<div>
	<button id="initBtn" onclick="initSearch(0)">초기화</button>
	<button id="scrapBtn" onclick="scrapNews()">스크랩</button>
	<button class="openBtn" onclick="reqScrapList()">북마크</button>
</div>

<div id="newsHead" class="parentNewsDiv newsHead">
	<div id="naverNewsHead" class="naverNewsDiv newsHead">News</div>
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
		  <li>
		    <input type="checkbox" id="scrap">
		    <label for="root">ROOT</label>
		    <ul id="rootbox">  
		    </ul>
		  </li>
		</ul>
		<div class="closeBtn">닫기</div>
	</div>
</div>

<div id="toast"></div>
</body>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
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
 	
 	//timer start
 	//startTimer();
 	if($("#setTime").value != "") {
 		startTimer(0);
 	}
})

/*
 * [SEARCH ENGINE FUNCTION]
 * flag 	0 : ALL
 *		 	1 : NAVER
 *         	2 : DAUM
 *         	3 : GOOGLE
 */
function reqSearchText(siteflag, pageflag, saveSearch) {
	
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

	openLoading();
	
	$.ajax({
		type : 'post'
		, url : '/seleniumhq/seleniumhq'
		, data : {"query" : query
				  ,"siteflag" : siteflag
				  ,"pageflag" : pageflag}
		, success : function(data) {
			
			var newsFormData = '';
			var newsFromPaging = '';
			
			newsFormData += "<table class='table table-striped table-hover text-center'>";
			newsFormData += "	<th width='30' class='text-center'></th> <th width='100' class='text-center'>플랫폼</th> <th width='200' class='text-center'>뉴스사</th> <th width='800' class='text-center'>제목</th> <th width='100' class='text-center'>작성일</th>";
			
			// NAVER NEWS SETTING
			if(siteflag == 0 || siteflag == 1) {
				//naverAPINewsSetting(data);
				newsFormData += naverNewsSetting(data,query);
			}
			
			// DAUM NEWS SETTING	
			if(siteflag == 0 || siteflag == 2) {
				newsFormData += daumNewsSetting(data,query);
			}
			
			// GOOGLE NEWS SETTING
			if(siteflag == 0 || siteflag == 3) {
				newsFormData += googleNewsSetting(data,query);
			}
			
			newsFormData += "</table>";
			
			$("#NewsBodyContent").html(newsFormData);
			
			newsFromPaging += "<ul class='pagination'>"
			for(var j=1; j<11; j++) {
				newsFromPaging += "<li> <a class='newslink' onclick=reqSearchText(0," + j +",'" + query + "') href='#'>" + j + " </a> </li>";
			}
			newsFromPaging += "</ul>"
		
			$("#NewsBodyPaging").html(newsFromPaging);
			
			closeLoading();
		},
		error : function(error) {
			closeLoading();

			alert("ERROR!");
		}
	})
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
		vGoogleNews += "	  	<td> GOOGLE </td>"
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
		$("#naverNewsBody").html("");
		$("#daumNewsBody").html("");
		$("#googleNewsBody").html("");
		$("#naverNewsPaging").html("");
		$("#daumNewsPaging").html("");
		$("#googleNewsPaging").html("");
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
 * KEY PRESS FUNCTION
 */
 function pressEnterKey(e) {
    var code = e.code;

    if(code == 'Enter'){
    	reqSearchText(0,1);
    	stopTimer();
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
		
		var comp = td.eq(1).text();
		var title = td.eq(2).text();
		var href = td.eq(2).children().attr("id");
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
  * SCRAP SUCCESS TOAST POPUP
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
  
</script>

</html>