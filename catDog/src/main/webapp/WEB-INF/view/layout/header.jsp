﻿<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>


	<!-- 헤더(카테고리) -->
	<nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
	<div style="width: 1200px; margin: 0px auto;">
			<div style="float: left;">
			<a class="navbar-brand js-scroll-trigger" href="<%=cp%>/"><img
				alt="" width="200" src="<%=cp%>/resource/img/logos/dogcatdogcat.png">
			</a>
			</div>
			<div id="navbarResponsive" style="float: left; padding-top:10px;">
				<ul class="navbar-nav text-uppercase">
					<li class="nav-item"><a class="nav-link js-scroll-trigger">회사소개</a>
						<ul class="nav-sub-menu">
							<li><a class="nav-sub-link" href="<%=cp%>/company/hello">인사말</a></li>
							<li><a class="nav-sub-link" href="<%=cp%>/company/history">회사연혁</a></li>
							<li><a class="nav-sub-link" href="<%=cp%>/company/road">찾아오시는길</a></li>
						</ul>	
					</li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger">장소추천</a>
						<ul class="nav-sub-menu">
							<li><a class="nav-sub-link" href="<%=cp%>/commend/park">공원/산책</a></li>
							<li><a class="nav-sub-link" href="<%=cp%>/commend/cafe">카페/식당</a></li>
							<li><a class="nav-sub-link" href="<%=cp%>/commend/hospital">훈련/유치원</a></li>
							<li><a class="nav-sub-link" href="<%=cp%>/commend/training">동물병원</a></li>
							<li><a class="nav-sub-link" href="<%=cp%>/commend/funeral">장례식장</a></li>
						</ul>		
					</li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger">로스트펫</a>
						<ul class="nav-sub-menu">
							<li><a class="nav-sub-link" href="<%=cp%>/adopt/list">입양</a></li>
							<li><a class="nav-sub-link" href="<%=cp%>/abandoned/list">유기동물</a></li>
						</ul>	
					</li>

					<li class="nav-item"><a class="nav-link js-scroll-trigger">반려용품</a>
						<ul class="nav-sub-menu">
							<li><a class="nav-sub-link" href="<%=cp%>/dogshop/list">강아지</a></li>
							<li><a class="nav-sub-link" href="<%=cp%>/catshop/list">고양이</a></li>
						</ul>	
					</li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger">놀이터</a>
						<ul class="nav-sub-menu">
							<li><a class="nav-sub-link" href="<%=cp%>/game/game">게임</a></li>
							<li><a class="nav-sub-link" href="<%=cp%>/event/event">이벤트</a></li>
							<li><a class="nav-sub-link" href="<%=cp%>/calendar/calendar">행사일정</a></li>
						</ul>	
					</li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger">수다방</a>
						<ul class="nav-sub-menu">
							<li><a class="nav-sub-link" href="<%=cp%>/bbs/tip">꿀팁</a></li>
							<li><a class="nav-sub-link" href="<%=cp%>/bbs/photo">내새끼 자랑</a></li>
							<li><a class="nav-sub-link" href="<%=cp%>/bbs/freeboard">자유게시판</a></li>
						</ul>	
					</li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger">고객센터</a>
						<ul class="nav-sub-menu">
							<li><a class="nav-sub-link" href="<%=cp%>/cs/notice">공지사항</a></li>
							<li><a class="nav-sub-link" href="<%=cp%>/cs/qna">질문과답변</a></li>
							<li><a class="nav-sub-link" href="<%=cp%>/cs/faq">FAQ</a></li>
						</ul>	
					</li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger">마이페이지</a>
						<ul class="nav-sub-menu">
							<li><a class="nav-sub-link" href="<%=cp%>/mypage/update">회원정보수정</a></li>
							<li><a class="nav-sub-link" href="<%=cp%>/mypage/list">내가 쓴 글</a></li>
							<li><a class="nav-sub-link" href="<%=cp%>/mypage/list">구매정보</a></li>
							<li><a class="nav-sub-link" href="<%=cp%>/mypage/list">출석체크</a></li>
							<li><a class="nav-sub-link" href="<%=cp%>/mypage/list">기부</a></li>
						</ul>
					</li>
					
				</ul>
				</div>
				<div class="navbar-nav text-uppercase text-Image" id="icon-image">
				<ul>
					<li class="nav-icon"><a class="nav-link js-scroll-trigger" href="<%=cp%>/customer/login"><i class="fas fa-key" style="color: #d96262"></i></a>
					</li>
					<li class="nav-icon"><a class="nav-link js-scroll-trigger"><i class="fas fa-sign-in-alt"
							style="color: #d96262"></i></a></li>
					<li class="nav-icon"><a class="nav-link js-scroll-trigger"><i class="fas fa-cart-plus"
							style="color: #d96262"></i></a></li>
				</ul>
				</div>
			</div>
	</nav>
	

	