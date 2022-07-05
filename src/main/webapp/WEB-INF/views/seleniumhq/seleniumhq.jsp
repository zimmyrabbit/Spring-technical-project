<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>

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
    border: 1px solid red;
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

<div class="search_box_DIV">
	<input type="text" id="searchText" name="searchText" class="search_box" onkeypress="pressEnterKey(event)" placeholder="검색어 입력"/>
	<button id="searchBtn" onclick="reqSearchText(0,1)">검색</button>
</div>

<div>
	<button id="initBtn" onclick="initSearch(0)">초기화</button>
	<button id="scrapBtn" onclick="scrapNews()">스크랩</button>
	<button class="openBtn" onclick="reqScrapList()">북마크</button>
</div>

<div id="newsHead" class="parentNewsDiv newsHead">
	<div id="naverNewsHead" class="naverNewsDiv newsHead">NAVER</div>
	<div id="daumNewsHead" class="daumNewsDiv newsHead">DAUM</div>
	<div id="googleNewsHead" class="googleNewsDiv newsHead">GOOGLE</div>
</div>

<div id="newsBody" class="parentNewsDiv">
	<div class="naverNewsDiv">
		<div id="naverNewsBody"></div>
		<div id="naverNewsPaging" class="newsHead"></div>
	</div>
	
	<div class="daumNewsDiv">
		<div id="daumNewsBody"></div>
		<div id="daumNewsPaging" class="newsHead"></div>
	</div>
	
	<div class="googleNewsDiv">
		<div id="googleNewsBody"></div>
		<div id="googleNewsPaging" class="newsHead"></div>
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
})

/*
 * [SEARCH ENGINE FUNCTION]
 * flag 	0 : ALL
 *		 	1 : NAVER
 *         	2 : DAUM
 *         	3 : GOOGLE
 */
function reqSearchText(siteflag, pageflag) {
	
	var query = $("#searchText").val();
	
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
			
			// NAVER NEWS SETTING
			if(siteflag == 0 || siteflag == 1) {
				//naverAPINewsSetting(data);
				naverNewsSetting(data);
			}
			
			// DAUM NEWS SETTING	
			if(siteflag == 0 || siteflag == 2) {
				daumNewsSetting(data);
			}
			
			// GOOGLE NEWS SETTING
			if(siteflag == 0 || siteflag == 3) {
				googleNewsSetting(data);
			}
			
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
 function naverNewsSetting(data) {
 	
 	initSearch(1);
 	
 	var vNaverNews = "";
 	var vNaverPaging = "";
 	
 	vNaverNews += "<table>"
 	vNaverNews += "	<th></th> <th>뉴스사</th> <th>제목</th> <th>작성일</th>"
 	
 	for(var i=0; i<data.naver.NaverNewsTitleArr.length; i++) {
 		vNaverNews += "	 <tr>"
 		vNaverNews += "	  <td> <input type='checkbox' name='news_checkbox'> </td>"
 		vNaverNews += "	  <td>" + data.naver.NaverNewsCompArr[i] + "</td>"
 		vNaverNews += "   <td> <a class='newslink' id='" + data.naver.NaverNewsHrefArr[i] + "' onclick=newsPopup(this.id)>" + data.naver.NaverNewsTitleArr[i] + "</a> </td>"
 		vNaverNews += "   <td class='font'>" + data.naver.NaverNewsRegTmArr[i] + "</td>"
 		vNaverNews += "  </tr>"
 	}
 	
 	vNaverNews += "</table>"
 		
 	$("#naverNewsBody").html(vNaverNews);
 	
 	
 	for(var j=1; j<11; j++) {
 		vNaverPaging += "<a class='newslink' onclick=reqSearchText(1," + j +") href='#'>" + j + " </a>";
 	}
 	
 	$("#naverNewsPaging").html(vNaverPaging);
 }

/*
 * DAUM NEWS SETTING FUNCTION
 */
function daumNewsSetting(data) {
	
	initSearch(2);
	
	var vDaumNews = "";
	var vDaumPaging = "";
	
	vDaumNews += "<table>"
	vDaumNews += "	<th></th> <th>뉴스사</th> <th>제목</th> <th>작성일</th>"
	
	for(var i=0; i<data.daum.daumNewsTitleArr.length; i++) {
		vDaumNews += "	 <tr>"
		vDaumNews += "	  <td> <input type='checkbox' name='news_checkbox'> </td>"
		vDaumNews += "	  <td>" + data.daum.daumNewsCompArr[i] + "</td>"
		vDaumNews += "    <td> <a class='newslink' id='" + data.daum.daumNewsHrefArr[i] + "' onclick=newsPopup(this.id)>" + data.daum.daumNewsTitleArr[i] + "</a> </td>"
		vDaumNews += "    <td class='font'>" + data.daum.daumNewsRegTmArr[i] + "</td>"
		vDaumNews += "   </tr>"
	}
	
	vDaumNews += "</table>"
		
	$("#daumNewsBody").html(vDaumNews);
	
	for(var j=1; j<11; j++) {
		vDaumPaging += "<a class='newslink' onclick=reqSearchText(2," + j +") href='#'>" + j + " </a>";
	}
	
	$("#daumNewsPaging").html(vDaumPaging);
}
 
/*
 * GOOGLE NEWS SETTING FUNCTION
 */
function googleNewsSetting(data) {

	initSearch(3);
	
	var vGoogleNews = "";
	var vGooglePaging = "";
	
	vGoogleNews += "<table>"
	vGoogleNews += " <th></th> <th>뉴스사</th> <th>제목</th> <th>작성일</th>"	
	
	for(var i=0; i<data.google.googleNewsTitleArr.length; i++) {
		vGoogleNews += "  <tr>"
		vGoogleNews += "	<td> <input type='checkbox' name='news_checkbox'> </td>"
		vGoogleNews += "	<td>" + data.google.googleNewsCompArr[i] + "</td>"
		vGoogleNews += "    <td> <a class='newslink' id='" + data.google.googleNewsHrefArr[i] + "' onclick=newsPopup(this.id)>" + data.google.googleNewsTitleArr[i] + "</a> </td>"
		vGoogleNews += "    <td class='font'>" + data.google.googleNewsRegTmArr[i] + "</td>"
		vGoogleNews += "  </tr>"
	}
	
	vGoogleNews += "</table>"
	
	$("#googleNewsBody").html(vGoogleNews);
	
	
	for(var j=1; j<11; j++) {
		vGooglePaging += "<a class='newslink' onclick=reqSearchText(3," + j +") href='#'>" + j + " </a>";
	}
	
	$("#googleNewsPaging").html(vGooglePaging);
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
</script>

</html>