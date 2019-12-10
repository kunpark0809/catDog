<%@ page contentType="text/html; charset=UTF-8" %>
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
			<a class="navbar-brand js-scroll-trigger"><img
				alt="" width="200" src="<%=cp%>/resource/img/logos/dogcatdogcat.png">
			</a>
			</div>
			<div id="navbarResponsive" style="float: left; padding-top:10px;">
				<ul class="navbar-nav text-uppercase">
					<li class="nav-item"><a class="nav-link js-scroll-trigger">회사소개</a>
						<ul class="nav-sub-menu">
							<li><a class="nav-sub-link" href="#">인사말</a></li>
							<li><a class="nav-sub-link" href="#">회사연혁</a></li>
							<li><a class="nav-sub-link" href="#">찾아오시는길</a></li>
						</ul>	
					</li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger">장소추천</a>
						<ul class="nav-sub-menu">
							<li><a class="nav-sub-link" href="#">공원/산책</a></li>
							<li><a class="nav-sub-link" href="#">카페/식당</a></li>
							<li><a class="nav-sub-link" href="#">훈련/유치원</a></li>
							<li><a class="nav-sub-link" href="#">동물병원</a></li>
							<li><a class="nav-sub-link" href="#">장례식장</a></li>
						</ul>		
					</li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger">로스트펫</a>
						<ul class="nav-sub-menu">
							<li><a class="nav-sub-link" href="#">입양</a></li>
							<li><a class="nav-sub-link" href="#">유기동물</a></li>
						</ul>	
					</li>

					<li class="nav-item"><a class="nav-link js-scroll-trigger">반려용품</a>
						<ul class="nav-sub-menu">
							<li><a class="nav-sub-link" href="#">강아지</a></li>
							<li><a class="nav-sub-link" href="#">고양이</a></li>
						</ul>	
					</li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger">놀이터</a>
						<ul class="nav-sub-menu">
							<li><a class="nav-sub-link" href="#">게임</a></li>
							<li><a class="nav-sub-link" href="#">이벤트</a></li>
							<li><a class="nav-sub-link" href="#">행사일정</a></li>
						</ul>	
					</li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger">수다방</a>
						<ul class="nav-sub-menu">
							<li><a class="nav-sub-link" href="#">꿀팁</a></li>
							<li><a class="nav-sub-link" href="#">내새끼 자랑</a></li>
							<li><a class="nav-sub-link" href="#">자유게시판</a></li>
						</ul>	
					</li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger">고객센터</a>
						<ul class="nav-sub-menu">
							<li><a class="nav-sub-link" href="#">공지사항</a></li>
							<li><a class="nav-sub-link" href="#">질문과답변</a></li>
							<li><a class="nav-sub-link" href="#">FAQ</a></li>
						</ul>	
					</li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger">마이페이지</a>
						<ul class="nav-sub-menu">
							<li><a class="nav-sub-link" href="#">회원정보수정</a></li>
							<li><a class="nav-sub-link" href="#">내가 쓴 글</a></li>
							<li><a class="nav-sub-link" href="#">구매정보</a></li>
							<li><a class="nav-sub-link" href="#">출석체크</a></li>
							<li><a class="nav-sub-link" href="#">기부</a></li>
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
	
			<!-- 슬라이드페이지 -->
	<div class="swiper-container">
		<div class="swiper-wrapper">
			<div class="swiper-slide">
				<img alt="" src="<%=cp%>/resource/img/logos/rundog.jpg">
			</div>
			<div class="swiper-slide">
				<img alt="" src="<%=cp%>/resource/img/logos/peacedog.jpg">
			</div>
			<div class="swiper-slide">
				<img alt="" src="<%=cp%>/resource/img/logos/sidecat.jpg">
			</div>
			<div class="swiper-slide">
				<img alt="" src="<%=cp%>/resource/img/logos/sidezbra.jpg">
			</div>
			<div class="swiper-slide">
				<img alt="" src="<%=cp%>/resource/img/logos/grassdog.jpg">
			</div>
		</div>
		<!-- Add Pagination -->
		<div class="swiper-pagination"></div>
		<!-- Add Arrows -->
		<div class="swiper-button-next"></div>
		<div class="swiper-button-prev"></div>
	</div>
	
	