﻿<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%
	String cp = request.getContextPath();
%>

<link href="https://fonts.googleapis.com/css?family=Jua&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<%=cp%>/resource/css/dogshop.css">
<style>
.ui-dialog-titlebar{
	background: none;
    border: none;
    border-bottom: 1px solid #e4e4e4;
    border-radius: 0px;
    color: red;
    text-align: center;
    font-size: 25px;
}

.ui-dialog-title{
	padding-left: 41px;
}

.ui-dialog{
	border-radius: 0px;
	position: fixed;
	
}

.ui-dialog-content{
	color: black;
}

/*
.ui-dialog .ui-dialog-content {
	background-image:url('<%=cp%>/resource/img/beast.jpg');
	background-position:center center;
	background-repeat: no-repeat;
}
*/



</style>

<script>
function ajaxJSON(url, type, query, fn) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			fn(data);
		}
		,beforeSend:function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return false;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

function ajaxHTML(url, type, query, selector) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,success:function(data) {
			$(selector).html(data);
		}
		,beforeSend:function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return false;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}



$(function(){
	$("#warningModal_open_btn").click(function(){
		
		var url1="<%=cp%>/customer/recentReport";
		var query = {temp:new Date().getTime()};
		
		var fn = function(data){
			var url2 = data.url;
			var reportDate = data.reportDate;
			var reasonName = data.reasonName;
			var reportCount = data.reportCount;
			
			var warning = "<a href = '"+url2+"' style='color:blue; font-weight:bold;'>회원님이 작성한 글</a>이 "+reportDate+"에 '"+reasonName;
			warning+="'의 사유로 신고되었고,<br>운영진의 심의 결과 경고 1회를 부여하였습니다.<br>현재 경고횟수는 ";
			warning+=reportCount+"회이며 경고 3회 누적시 회원 자격이 영구적으로 정지됩니다.";
			
			$("#warningModal").show();
			$(".warningModal-content").html(warning);
		};
		
		ajaxJSON(url1, "post", query, fn);
		
		$('#warningModal').dialog({
			  modal: true,
			  height: 290,
			  width: 800,
			  title: '경고',
			  close: function(event, ui) {
			  },
			  open: function(event, ui) {
					$(".ui-dialog-titlebar-close", $(this).parent()).hide();
				}
		});
	});
});

$(function(){
	$("#confirm").click(function(){
				
		var url="<%=cp%>/customer/deactivateWarn";
		var query={};
		
		var fn = function(data){
			if(data.status==1){
			$('#warningModal').dialog("close");
			}
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});

</script>

<!-- 헤더(카테고리) -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
	<div style="width: 1600px; margin: 0px auto;">
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
						<li><a class="nav-sub-link" href="<%=cp%>/aband/list">유기동물</a></li>
					</ul></li> 

				<li class="nav-item"><a class="nav-link js-scroll-trigger">반려용품</a>
					<ul class="nav-sub-menu">
						<li><a class="nav-sub-link" href="<%=cp%>/shop/list?bigSortNum=1">강아지</a></li>
						<li><a class="nav-sub-link" href="<%=cp%>/shop/list?bigSortNum=0">고양이</a></li>
					</ul></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger">멍냥알림</a>
					<ul class="nav-sub-menu">
						<li><a class="nav-sub-link" href="<%=cp%>/game/game">게임</a></li>
						<li><a class="nav-sub-link" href="<%=cp%>/event/list">이벤트</a></li>
						<li><a class="nav-sub-link" href="<%=cp%>/festival/month">행사일정</a></li>
					</ul></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger">놀이터</a>
					<ul class="nav-sub-menu">
						<li><a class="nav-sub-link" href="<%=cp%>/tip/list">꿀팁</a></li>
						<li><a class="nav-sub-link" href="<%=cp%>/pet/list">멍냥
								자랑</a></li>
						<li><a class="nav-sub-link" href="<%=cp%>/freeBoard/list">자유게시판</a></li>
					</ul></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger">고객센터</a>
					<ul class="nav-sub-menu">
						<li><a class="nav-sub-link" href="<%=cp%>/notice/list">공지사항</a></li>
						<li><a class="nav-sub-link" href="<%=cp%>/qna/list">질문과답변</a></li>
						<li><a class="nav-sub-link" href="<%=cp%>/faq/list">FAQ</a></li>
					</ul></li>
				<c:if test="${fn:indexOf(sessionScope.member.userId,'admin')!=0}">
					<li class="nav-item"><a class="nav-link js-scroll-trigger">마이페이지</a>
						<ul class="nav-sub-menu">
							<li><a class="nav-sub-link" href="<%=cp%>/mypage/pwd">회원정보수정</a></li>
							<li><a class="nav-sub-link" href="<%=cp%>/mypage/main">내가 쓴 글</a></li>
							<li><a class="nav-sub-link" href="<%=cp%>/mypage/requestCheck">주문조회</a></li>
							<li><a class="nav-sub-link" href="<%=cp%>/mypage/point">포인트조회</a></li>
							<li><a class="nav-sub-link" href="<%=cp%>/mypage/donation">기부</a></li>
						</ul></li>
				</c:if>
				
				<c:if test="${fn:indexOf(sessionScope.member.userId,'admin') == 0}">
					<li class="nav-item"><a class="nav-link js-scroll-trigger">관리자</a>
						<ul class="nav-sub-menu">
							<li><a class="nav-sub-link" href="<%=cp%>/admin/shop">쇼핑몰 관리</a></li>
							<li><a class="nav-sub-link" href="<%=cp%>/admin/bbs">신고 관리</a></li>
							<li><a class="nav-sub-link" href="<%=cp%>/admin/money">매출 관리</a></li>
							<li><a class="nav-sub-link" href="<%=cp%>/admin/member">회원 관리</a></li>
						</ul></li>
				</c:if>
				
				
			</ul>
		</div>
		<div style="width: 300px; margin: 19px auto; float: right;">
			<div style="min-width: 40px;">
			<c:if test="${not empty sessionScope.member.userPic}">
				<img src="<%=cp%>/uploads/photo/${sessionScope.member.userPic}" style="float:left; border-radius: 30px; width: 40px; height: 40px;">
			</c:if>
			</div>
		
			<div style="min-width: 115px;">
			<c:if test="${not empty sessionScope.member}">
			<div style="margin: 8px 10px 0px; float: left;">
				<div style="font-family:'NanumSquareRound', sans-serif; float:left; max-width: 100px; overflow: hidden;
					text-overflow: ellipsis; white-space: nowrap;">
				${sessionScope.member.nickName}</div>
				<div style="float:left; font-family: 'NanumSquareRound', sans-serif;">
				님
				</div>
			</div>
			</c:if>
			</div>
			<ul>
			
			<c:if test="${sessionScope.member.warn == 1}">
			<li class="nav-icon">
			
			<img id="warningModal_open_btn" width="25" height="25" src="<%=cp%>/resource/img/warning.gif"
			style="float:left; padding-top: 7px; margin-right: 10px;"></li>
		
			</c:if>
			
				<c:if test="${empty sessionScope.member}">
					<li class="nav-icon" style="padding-top: 5px;"><a class="nav-link js-scroll-trigger"
						href="<%=cp%>/customer/login"><i class="fas fa-key"
							style="float:left; color: #d96262;"></i></a></li>
				</c:if>
				<c:if test="${not empty sessionScope.member}">
					<li class="nav-icon" style="padding-top: 5px;"><a class="nav-link js-scroll-trigger" href="<%=cp%>/customer/logout"><i
							class="fas fa-sign-out-alt" style="float:left; color: #d96262"></i></a></li>
				</c:if>
				<li class="nav-icon" style="padding-top: 5px;"><a class="nav-link js-scroll-trigger" href="<%=cp%>/pay/cart"><i
						class="fas fa-cart-plus" style="float:left; color: #d96262"></i></a></li>
			</ul>
		</div>
		
		

	</div>
<!-- 모달 창 -->
		<div id="warningModal" style="display: none; text-align: center; ">
	 		<div class="warningModal-content"></div>
	      	<div style="text-align: center;">
	 			<button type="button" id="confirm" class="bts">확인</button>
	 		</div>
		</div>
	
</nav>


