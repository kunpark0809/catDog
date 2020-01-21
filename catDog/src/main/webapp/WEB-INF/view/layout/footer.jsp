<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

	<!-- 푸터 -->
	
	<footer class="footer">
	<div class="info_foot_co">
				<div class="template_width">
					<ul style="margin: 0px auto; width: 1185px;">
						<li><a href="<%=cp%>/company/hello">회사소개&nbsp;&nbsp;&nbsp;</a></li>
						<li><a href="<%=cp%>/company/accessTerms">이용약관&nbsp;&nbsp;&nbsp;</a></li>
						<li><a href="<%=cp%>/company/privacyInfo"><strong>개인정보취급방침&nbsp;&nbsp;&nbsp;</strong></a></li>
						<li><a href="<%=cp%>/notice/list">고객센터&nbsp;&nbsp;&nbsp;</a></li>
						<li><a href="#">이용안내</a></li>

						<li style="float: right">
						<i class="fab fa-facebook"></i>
						<i class="fab fa-instagram"></i>
						<i class="fab fa-twitter-square"></i>
					</ul>
				</div>
			</div>
		<div class="container" style="margin: 10px auto 10px;">
			<div class="row">
				<div style="float: left; width: 370px;">
					<h5>멍냥개냥</h5>
					<h6>서울특별시 마포구 월드컵북로 21 2층 풍성빌딩</h6>
					<h6>회사명 : (주)멍냥개냥&nbsp;&nbsp;대표 : 신승연&nbsp;&nbsp;&nbsp;전화: 1111-5555</h6>
					<h6>사업자등록번호 : 111-11-11111&nbsp;&nbsp;&nbsp;<a href="#">[사업자정보확인]</a></h6>
					<h6>통신판매업 신고 : 제 2019-서울마포-2020 호</h6>
					<h6>개인정보관리책임자 : 박서현</h6>
					<h6>이메일문의 : dogandcat@naver.com</h6>
				</div>
				
				<div class="customer col-md-2" style="text-align: center;">
					<h5>고객센터</h5>
					<h4>1111-5555</h4>
					<h6>
						상담시간 : <br>10:00 ~ 17:00 <br> 점심시간 : <br>12:00 ~
						13:00
					</h6>
				</div>
				<div style="text-align: center;">
					<div class="bank_inner">
						<h5>후원계좌 안내</h5>
						<h4>
							국민은행 <br>000-0000-0000-00
						</h4>
						<h6>예금주 : (주)멍냥개냥</h6>

					</div>
				</div>
				<div style="padding-left: 120px; width: 250px;">
					<h6>구매안전서비스 가입사실 확인</h6>
					<h6>고객님은 안전거래를 위해 현금 등으로 결제시 저희 쇼핑몰이 가입한PG에스크로 구매안전 서비스를 이용하실
						수 있습니다.</h6>
					<br>
					<h6>
						<a href="#">서비스 가입사실 확인</a>
					</h6>
				</div>
			</div>
		</div>
		<div class="footer-copy">Copyright © 2019 멍냥개냥. All rights
			reserved.</div>
	</footer>

