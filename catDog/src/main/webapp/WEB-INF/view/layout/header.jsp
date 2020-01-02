<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%
	String cp = request.getContextPath();
%>


<!-- 헤더(카테고리) -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
	<div style="width: 1300px; margin: 0px 300px 0px 270px;">
		<div style="float: left;">
			<a class="navbar-brand js-scroll-trigger" href="<%=cp%>/"><img
				alt="" width="200" src="<%=cp%>/resource/img/logos/dogcatdogcat.png">
			</a>
		</div>
		<div id="navbarResponsive" style="float: left; padding-top: 10px;">
			<ul class="navbar-nav text-uppercase">
				<li class="nav-item"><a class="nav-link js-scroll-trigger">회사소개</a>
					<ul class="nav-sub-menu">
						<li><a class="nav-sub-link" href="<%=cp%>/company/hello">인사말</a></li>
						<li><a class="nav-sub-link" href="<%=cp%>/company/history">회사연혁</a></li>
						<li><a class="nav-sub-link" href="<%=cp%>/company/road">찾아오시는길</a></li>
					</ul></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger">장소추천</a>
					<ul class="nav-sub-menu">
						<li><a class="nav-sub-link" href="<%=cp%>/park/list">공원/산책</a></li>
						<li><a class="nav-sub-link" href="<%=cp%>/cafe/list">카페/식당</a></li>
						<li><a class="nav-sub-link" href="<%=cp%>/training/list">훈련/유치원</a></li>
						<li><a class="nav-sub-link" href="<%=cp%>/hospital/list">동물병원</a></li>
						<li><a class="nav-sub-link" href="<%=cp%>/funeral/list">장례식장</a></li>
					</ul></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger">로스트펫</a>
					<ul class="nav-sub-menu">
						<li><a class="nav-sub-link" href="<%=cp%>/adopt/list">입양</a></li>
						<li><a class="nav-sub-link" href="<%=cp%>/abandoned/list">유기동물</a></li>
					</ul></li>

				<li class="nav-item"><a class="nav-link js-scroll-trigger">반려용품</a>
					<ul class="nav-sub-menu">
						<li><a class="nav-sub-link" href="<%=cp%>/dogshop/list">강아지</a></li>
						<li><a class="nav-sub-link" href="<%=cp%>/catshop/list">고양이</a></li>
					</ul></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger">놀이터</a>
					<ul class="nav-sub-menu">
						<li><a class="nav-sub-link" href="<%=cp%>/game/game">게임</a></li>
						<li><a class="nav-sub-link" href="<%=cp%>/event/list">이벤트</a></li>
						<li><a class="nav-sub-link" href="<%=cp%>/festival/month">행사일정</a></li>
					</ul></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger">수다방</a>
					<ul class="nav-sub-menu">
						<li><a class="nav-sub-link" href="<%=cp%>/honeyTip/list">꿀팁</a></li>
						<li><a class="nav-sub-link" href="<%=cp%>/pet/list">내새끼
								자랑</a></li>
						<li><a class="nav-sub-link" href="<%=cp%>/freeBoard/list">자유게시판</a></li>
					</ul></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger">고객센터</a>
					<ul class="nav-sub-menu">
						<li><a class="nav-sub-link" href="<%=cp%>/notice/list">공지사항</a></li>
						<li><a class="nav-sub-link" href="<%=cp%>/qna/list">질문과답변</a></li>
						<li><a class="nav-sub-link" href="<%=cp%>/faq/list">FAQ</a></li>
					</ul></li>
				<c:if test="${not empty sessionScope.member&&fn:indexOf(sessionScope.member.userId,'admin')!=0}">
					<li class="nav-item"><a class="nav-link js-scroll-trigger">마이페이지</a>
						<ul class="nav-sub-menu">
							<li><a class="nav-sub-link" href="<%=cp%>/mypage/pwd">회원정보수정</a></li>
							<li><a class="nav-sub-link" href="<%=cp%>/mypage/list">내가 쓴 글</a></li>
							<li><a class="nav-sub-link" href="<%=cp%>/mypage/list">주문조회</a></li>
							<li><a class="nav-sub-link" href="<%=cp%>/mypage/list">포인트조회</a></li>
							<li><a class="nav-sub-link" href="<%=cp%>/mypage/donation">기부</a></li>
						</ul></li>
				</c:if>
				
				<c:if test="${fn:indexOf(sessionScope.member.userId,'admin') == 0}">
					<li class="nav-item"><a class="nav-link js-scroll-trigger">관리자</a>
						<ul class="nav-sub-menu">
							<li><a class="nav-sub-link" href="<%=cp%>/admin/cs/list">고객센터 관리</a></li>
							<li><a class="nav-sub-link" href="<%=cp%>/admin/bbs">수다방 관리</a></li>
							<li><a class="nav-sub-link" href="<%=cp%>/admin/play">놀이터 관리</a></li>
							<li><a class="nav-sub-link" href="<%=cp%>/admin/money">매출 관리</a></li>
							<li><a class="nav-sub-link" href="<%=cp%>/admin/member">회원 관리</a></li>
						</ul></li>
				</c:if>
				
				
			</ul>
		</div>
		<div style="width: 215px; margin: 20px auto; float: right;">
			<c:if test="${not empty sessionScope.member}">
			<div style="margin: 12px 10px 0px 0px; float: left;">${sessionScope.member.nickName}님</div>
			</c:if>
			<ul>
				<c:if test="${empty sessionScope.member}">
					<li class="nav-icon"><a class="nav-link js-scroll-trigger"
						href="<%=cp%>/customer/login"><i class="fas fa-key"
							style="color: #d96262"></i></a></li>
				</c:if>
				<c:if test="${not empty sessionScope.member}">
					<li class="nav-icon"><a class="nav-link js-scroll-trigger" href="<%=cp%>/customer/logout"><i
							class="fas fa-sign-out-alt" style="color: #d96262"></i></a></li>
				</c:if>
				<li class="nav-icon"><a class="nav-link js-scroll-trigger" href="<%=cp%>/pay/cart"><i
						class="fas fa-cart-plus" style="color: #d96262"></i></a></li>
			</ul>
		</div>
	</div>
</nav>


