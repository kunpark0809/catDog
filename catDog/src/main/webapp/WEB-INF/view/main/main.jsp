<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   String cp = request.getContextPath();
%>
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
	
	<!-- 가로 배너 -->
	<div align="center"><br>
	<a href="<%=cp%>/shop/list"><img alt="" src="<%=cp%>/resource/img/logos/baner.JPG"></a>
	</div>
	
	<!-- 장소추천 -->
	<section class="page-section" id="command">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<h2 class="section-heading text-uppercase">장소추천</h2>
					<h3 class="section-subheading text-muted">오늘, 이런 장소는 어떠세요?</h3>
				</div>
			</div>
			<div class="row text-center">
				<c:forEach var="dto" items="${parkList}">
				<div class="col-md-4" style="max-width: 30%;">
					<a onclick="javascript:location.href='${parkListUrl}&recommendNum=${dto.recommendNum}'" style="color: #262626;">
					<input type="hidden" value="${dto.recommendNum}">
					<img alt="" src="<%=cp%>/uploads/park/${dto.imageFileName}" width="351px" height="263.250px" style="padding-top: 15px;"><br>
					<span class="placeName" onclick="javascript:article('${dto.recommendNum}');" style="font-weight: bold; font-size: 24px;">${dto.placeName}</span><br>
				</a>
				</div>
				</c:forEach>
			</div>
		</div>
	</section>

	<!-- 강아지용품추천 -->
	<section class="bg-light page-section" id="portfolio">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<h2 class="section-heading text-uppercase">강아지 용품추천</h2>
					<h3 class="section-subheading text-muted">이번주 최고의 멍멍 PICK!</h3>
				</div>
			</div>
			<div class="row">
				<c:forEach var="dto" items="${dogProductList}">
				<div class="col-md-4 col-sm-6 portfolio-item" style="max-width: 30%;">
					<a class="portfolio-link" href="${dogProductListUrl}&productNum=${dto.productNum}">
						<div class="portfolio-hover">
							<div class="portfolio-hover-content">
								<i class="fas fa-plus fa-3x"></i>
							</div>
						</div> <img class="img-fluid"
						src="<%=cp%>/uploads/shop/${dto.imageFileName}" alt="" style="height: 351px; width: 351px;">
						<!-- 사진사이즈 정해져있음 -->
					</a>
					<div class="portfolio-caption" style="height: 70px;">
						<h5>${dto.name}</h5>
						<p class="text-muted">가격 : ${dto.price}원</p>
					</div>
				</div>
				</c:forEach>
			</div>
		</div>
	</section>

	<!-- 고양이용품추천 -->
	<section class="bg-light page-section" id="portfolio">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<h2 class="section-heading text-uppercase">고양이 용품추천</h2>
					<h3 class="section-subheading text-muted">이번주 최고의 냥냥 PICK!</h3>
				</div>
			</div>
			<div class="row">
				<c:forEach var="dto" items="${catProductList}">
				<div class="col-md-4 col-sm-6 portfolio-item" style="max-width: 30%;">
					<a class="portfolio-link" href="${catProductListUrl}&productNum=${dto.productNum}">
						<div class="portfolio-hover">
							<div class="portfolio-hover-content">
								<i class="fas fa-plus fa-3x"></i>
							</div>
						</div> <img class="img-fluid"
						src="<%=cp%>/uploads/shop/${dto.imageFileName}" alt="" style="height: 351px; width: 351px;">
						<!-- 사진사이즈 정해져있음 -->
					</a>
					<div class="portfolio-caption"  style="height: 70px;">
						<h5>${dto.name}</h5>
						<p class="text-muted">가격 : ${dto.price}원</p>
					</div>
				</div>
				</c:forEach>
			</div>
		</div>
	</section>

	<!-- 세번째 화면 -->
	<section class="page-section" id="team">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<h2 class="section-heading text-uppercase">금주의 멍냥 어워드 BAAM!</h2>
					<h4 class="section-subheading text-muted">&nbsp;</h4>
				</div>
			</div>
			<div class="row">
				<div class="col-md-6" style="max-width: 46%;">
					<div class="team-member">
						<a href="#"> <img class="mx-auto rounded-circle"
							src="<%=cp%>/resource/img/dog1.jpg" alt="">
						</a>
						<h4>댕댕이</h4>
					</div>
				</div>
				<div class="col-md-6" style="max-width: 46%;">
					<div class="team-member">
						<a href="#"> <img class="mx-auto rounded-circle"
							src="<%=cp%>/resource/img/소금후추맘.jpg" alt="">
						</a>
						<h4>소금후추맘</h4>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-8 mx-auto text-center">
					<p class="large text-muted">금주 최고의 멍냥 어워드</p>
				</div>
			</div>
		</div>
	</section>

	<!-- 공지사항 및 후기 -->
	<section class="main_bottom" style="background-color: #262626;">
		<div class="container">
			<div class="row">
				<div class="col-md-6" style="box-sizing: border-box;">
					<span> <font color="#F2F2F2" size="4px;"><i
							class="fas fa-check" style="color: #F2F2F2">&nbsp;</i>공지사항</font><br>
					</span><br>
					<c:forEach var="vo" items="${noticeList}">
					<p style="margin-bottom: 10px;">
						<a href="${noticeListUrl}&noticeNum=${vo.noticeNum}" style="color: #666666">${vo.subject}</a>
						
					</p>
					</c:forEach>
				</div>
				<div class="col-md-6" style="box-sizing: border-box;">
					<span> <font color="#F2F2F2" size="4px;"><i
							class="far fa-grin-hearts" style="color: #F2F2F2">&nbsp;</i>후기</font><br>
					</span> <br>
					<c:forEach var="vo" items="${reviewList}">
					<p style="margin-bottom: 10px;">
						<a href="${reviewListUrl}&productNum=${vo.productNum}" style="color: #666666">${vo.content}</a>
					</p>
					</c:forEach>
				</div>
			</div>
		</div>
	</section>
	

	