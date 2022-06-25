<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>

<style type="text/css">

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
	font-size: 5px;
}

.RegTmArr {
	width : 10%;
}

</style>

<meta charset="UTF-8">
<title>News Search Engine</title>
</head>
<body>
<div>
<input type="text" id="searchText" name="searchText" style="width:400px; display:inline" onkeypress="pressEnterKey(event)"/>
<button id="searchBtn" onclick="reqSearchText(0,1)">검색</button>
<button id="initBtn" onclick="initSearch(0)">초기화</button>
<button id="initBtn" onclick="scrapNews()">스크랩</button>
</div>

<div id="newsHead" class="parentNewsDiv newsHead">
	<div id="naverNewsHead" class="naverNewsDiv newsHead">NAVER</div>
	<div id="daumNewsHead" class="daumNewsDiv newsHead">DAUM</div>
	<div id="googleNewsHead" class="googleNewsDiv newsHead">GOOGLE</div>
</div>

<div id="newsBody" class="parentNewsDiv">

	<div class="naverNewsDiv">
		<div id="naverNewsBody">z</div>
		<div id="naverNewsPaging"></div>
	</div>
	
	<div class="daumNewsDiv">
		<div id="daumNewsBody">z</div>
		<div id="daumNewsPaging"></div>
	</div>
	
	<div class="googleNewsDiv">
		<div id="googleNewsBody">z</div>
		<div id="googleNewsPaging"></div>
	</div>
</div>


<script type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">

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
		if(param == 1) {
			alert("검색어를 입력해 주세요.");
			return;
		}
	}
	
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
		vNaverNews += "   <td> <a href='" + vNaverNewsItem.items[i].link + "' target='_blank'>" + vNaverNewsItem.items[i].title + "</a> </td>"
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
 		vNaverNews += "   <td> <a href='" + data.naver.NaverNewsHrefArr[i] + "' target='_blank'>" + data.naver.NaverNewsTitleArr[i] + "</a> </td>"
 		vNaverNews += "   <td class='font'>" + data.naver.NaverNewsRegTmArr[i] + "</td>"
 		vNaverNews += "  </tr>"
 	}
 	
 	vNaverNews += "</table>"
 		
 	$("#naverNewsBody").html(vNaverNews);
 	
 	
 	for(var j=1; j<11; j++) {
 		vNaverPaging += "<a onclick=reqSearchText(1," + j +")>" + j + " </a>";
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
		vDaumNews += "    <td> <a href='" + data.daum.daumNewsHrefArr[i] + "' target='_blank'>" + data.daum.daumNewsTitleArr[i] + "</a> </td>"
		vDaumNews += "    <td class='font'>" + data.daum.daumNewsRegTmArr[i] + "</td>"
		vDaumNews += "   </tr>"
	}
	
	vDaumNews += "</table>"
		
	$("#daumNewsBody").html(vDaumNews);

	
	for(var j=1; j<11; j++) {
		vDaumPaging += "<a onclick=reqSearchText(2," + j +")>" + j + " </a>";
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
		vGoogleNews += "    <td> <a href='" + data.google.googleNewsHrefArr[i] + "' target='_blank'>" + data.google.googleNewsTitleArr[i] + "</a> </td>"
		vGoogleNews += "    <td class='font'>" + data.google.googleNewsRegTmArr[i] + "</td>"
		vGoogleNews += "  </tr>"
	}
	
	vGoogleNews += "</table>"
	
	$("#googleNewsBody").html(vGoogleNews);
	
	
	for(var j=1; j<11; j++) {
		vGooglePaging += "<a onclick=reqSearchText(3," + j +")>" + j + " </a>";
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
	}
	return true;
}

/*
 * CHECKED NEWS SCRAP FUNCTION
 */
 function scrapNews() {
		var tdArr = new Array();
		var checkbox = $("input[name=news_checkbox]:checked");
		
		checkbox.each(function(i) {
		var tr = checkbox.parent().parent().eq(i);
		var td = tr.children();
		
		var comp = td.eq(1).text();
		var title = td.eq(2).text();
		
		var data = new Object(); 
		
		data.comp = comp;
		data.title = title;
		
		tdArr.push(data);
		});
		
	var jsonData = JSON.stringify(tdArr);	
	
	$.ajax({
		type : 'get'
		, url : '/seleniumhq/getScrapNews'
		, data : {"data" : jsonData}
		, success : function(data) {
			
		}
	})
}

</script>

</body>
</html>