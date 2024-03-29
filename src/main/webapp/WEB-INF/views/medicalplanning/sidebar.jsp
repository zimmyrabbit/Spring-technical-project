<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<body>
	<div id="wrapper">
      	<div class="topbar" style="position: absolute; top:0;">
          	<!-- 왼쪽 메뉴 -->
          	<div class="left side-menu">
              	<div class="sidebar-inner">
                  	<div id="sidebar-menu">
                      	<ul>
                          	<li class="has_sub"><a href="javascript:void(0);" class="waves-effect">
                              	<i class="fas fa-bars"></i>
                          	</a></li>
                      	</ul>
                  	</div>
              	</div>
          	</div>
          	<!-- 왼쪽 서브 메뉴 -->
           	<div class="left_sub_menu">
               	<div class="sub_menu">
                   	<input type="search" name="SEARCH" placeholder="SEARCH">
                   	<h2>TITLE</h2>
                   	<ul class="big_menu">
                       	<li>MENU 1 <i class="arrow fas fa-angle-right"></i></li>
                       	<ul class="small_menu">
                           	<li><a href="#">소메뉴1-1</a></li>
                          	<li><a href="#">소메뉴1-2</a></li>
                           	<li><a href="">소메뉴1-3</a></li>
                           	<li><a href="#">소메뉴1-4</a></li>
                       </ul>
                   </ul>
                   <ul class="big_menu">
                       	<li>MENU 2 <i class="arrow fas fa-angle-right"></i></li>
                       	<ul class="small_menu">
                           	<li><a href="#">소메뉴2-1</a></li>
                           	<li><a href="#"></a>소메뉴2-2</a></li>
                       	</ul>
                   </ul>
               	</div>
           	</div>
           	<div class="overlay"></div>
       	</div>
	</div>
</body>

<script type="text/javascript">
$(function () {
    $(".left_sub_menu").hide();
    $(".has_sub").click(function () {
        $(".left_sub_menu").fadeToggle(300);
    });
    // 왼쪽메뉴 드롭다운
    $(".sub_menu ul.small_menu").hide();
    $(".sub_menu ul.big_menu").click(function () {
        $("ul", this).slideToggle(300);
    });
    // 외부 클릭 시 좌측 사이드 메뉴 숨기기
    $('.overlay').on('click', function () {
        $('.left_sub_menu').fadeOut();
        $('.hide_sidemenu').fadeIn();
    });
});
</script>