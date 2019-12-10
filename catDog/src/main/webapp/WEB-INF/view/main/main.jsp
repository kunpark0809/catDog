<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   String cp = request.getContextPath();
%>

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
				<div class="col-md-4">
					<img alt="" src="<%=cp%>/resource/img/소금후추맘.jpg"
						style="width: 100%;">
					<h4 class="service-heading">장소1</h4>
					<p class="text-muted">멋진장소</p>
				</div>
				<div class="col-md-4">
					<img alt="" src="<%=cp%>/resource/img/소금후추맘.jpg"
						style="width: 100%;">
					<h4 class="service-heading">장소2</h4>
					<p class="text-muted">예쁜장소</p>
				</div>
				<div class="col-md-4">
					<img alt="" src="<%=cp%>/resource/img/소금후추맘.jpg"
						style="width: 100%;">
					<h4 class="service-heading">장소3</h4>
					<p class="text-muted">예쁘고 멋진 장소</p>
				</div>
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
				<div class="col-md-4 col-sm-6 portfolio-item">
					<a class="portfolio-link" data-toggle="modal"
						href="#portfolioModal1">
						<div class="portfolio-hover">
							<div class="portfolio-hover-content">
								<i class="fas fa-plus fa-3x"></i>
							</div>
						</div> <img class="img-fluid"
						src="<%=cp%>/resource/img/portfolio/01-thumbnail.jpg" alt="">
						<!-- 사진사이즈 정해져있음 -->
					</a>
					<div class="portfolio-caption">
						<h4>멍용품1</h4>
						<p class="text-muted">추천1</p>
					</div>
				</div>
				<div class="col-md-4 col-sm-6 portfolio-item">
					<a class="portfolio-link" data-toggle="modal"
						href="#portfolioModal2">
						<div class="portfolio-hover">
							<div class="portfolio-hover-content">
								<i class="fas fa-plus fa-3x"></i>
							</div>
						</div> <img class="img-fluid"
						src="<%=cp%>/resource/img/portfolio/02-thumbnail.jpg" alt="">
					</a>
					<div class="portfolio-caption">
						<h4>멍용품2</h4>
						<p class="text-muted">추천2</p>
					</div>
				</div>
				<div class="col-md-4 col-sm-6 portfolio-item">
					<a class="portfolio-link" data-toggle="modal"
						href="#portfolioModal3">
						<div class="portfolio-hover">
							<div class="portfolio-hover-content">
								<i class="fas fa-plus fa-3x"></i>
							</div>
						</div> <img class="img-fluid"
						src="<%=cp%>/resource/img/portfolio/03-thumbnail.jpg" alt="">
					</a>
					<div class="portfolio-caption">
						<h4>멍용품3</h4>
						<p class="text-muted">추천3</p>
					</div>
				</div>
				<div class="col-md-4 col-sm-6 portfolio-item">
					<a class="portfolio-link" data-toggle="modal"
						href="#portfolioModal4">
						<div class="portfolio-hover">
							<div class="portfolio-hover-content">
								<i class="fas fa-plus fa-3x"></i>
							</div>
						</div> <img class="img-fluid"
						src="<%=cp%>/resource/img/portfolio/04-thumbnail.jpg" alt="">
					</a>
					<div class="portfolio-caption">
						<h4>멍용품4</h4>
						<p class="text-muted">추천4</p>
					</div>
				</div>
				<div class="col-md-4 col-sm-6 portfolio-item">
					<a class="portfolio-link" data-toggle="modal"
						href="#portfolioModal5">
						<div class="portfolio-hover">
							<div class="portfolio-hover-content">
								<i class="fas fa-plus fa-3x"></i>
							</div>
						</div> <img class="img-fluid"
						src="<%=cp%>/resource/img/portfolio/05-thumbnail.jpg" alt="">
					</a>
					<div class="portfolio-caption">
						<h4>멍용품5</h4>
						<p class="text-muted">추천5</p>
					</div>
				</div>
				<div class="col-md-4 col-sm-6 portfolio-item">
					<a class="portfolio-link" data-toggle="modal"
						href="#portfolioModal6">
						<div class="portfolio-hover">
							<div class="portfolio-hover-content">
								<i class="fas fa-plus fa-3x"></i>
							</div>
						</div> <img class="img-fluid"
						src="<%=cp%>/resource/img/portfolio/06-thumbnail.jpg" alt="">
					</a>
					<div class="portfolio-caption">
						<h4>멍용품6</h4>
						<p class="text-muted">추천6</p>
					</div>
				</div>
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
				<div class="col-md-4 col-sm-6 portfolio-item">
					<a class="portfolio-link" data-toggle="modal"
						href="#portfolioModal1">
						<div class="portfolio-hover">
							<div class="portfolio-hover-content">
								<i class="fas fa-plus fa-3x"></i>
							</div>
						</div> <img class="img-fluid"
						src="<%=cp%>/resource/img/portfolio/01-thumbnail.jpg" alt="">
					</a>
					<div class="portfolio-caption">
						<h4>냥용품1</h4>
						<p class="text-muted">추천1</p>
					</div>
				</div>
				<div class="col-md-4 col-sm-6 portfolio-item">
					<a class="portfolio-link" data-toggle="modal"
						href="#portfolioModal2">
						<div class="portfolio-hover">
							<div class="portfolio-hover-content">
								<i class="fas fa-plus fa-3x"></i>
							</div>
						</div> <img class="img-fluid"
						src="<%=cp%>/resource/img/portfolio/02-thumbnail.jpg" alt="">
					</a>
					<div class="portfolio-caption">
						<h4>냥용품2</h4>
						<p class="text-muted">추천2</p>
					</div>
				</div>
				<div class="col-md-4 col-sm-6 portfolio-item">
					<a class="portfolio-link" data-toggle="modal"
						href="#portfolioModal3">
						<div class="portfolio-hover">
							<div class="portfolio-hover-content">
								<i class="fas fa-plus fa-3x"></i>
							</div>
						</div> <img class="img-fluid"
						src="<%=cp%>/resource/img/portfolio/03-thumbnail.jpg" alt="">
					</a>
					<div class="portfolio-caption">
						<h4>냥용품3</h4>
						<p class="text-muted">추천3</p>
					</div>
				</div>
				<div class="col-md-4 col-sm-6 portfolio-item">
					<a class="portfolio-link" data-toggle="modal"
						href="#portfolioModal4">
						<div class="portfolio-hover">
							<div class="portfolio-hover-content">
								<i class="fas fa-plus fa-3x"></i>
							</div>
						</div> <img class="img-fluid"
						src="<%=cp%>/resource/img/portfolio/04-thumbnail.jpg" alt="">
					</a>
					<div class="portfolio-caption">
						<h4>냥용품4</h4>
						<p class="text-muted">추천4</p>
					</div>
				</div>
				<div class="col-md-4 col-sm-6 portfolio-item">
					<a class="portfolio-link" data-toggle="modal"
						href="#portfolioModal5">
						<div class="portfolio-hover">
							<div class="portfolio-hover-content">
								<i class="fas fa-plus fa-3x"></i>
							</div>
						</div> <img class="img-fluid"
						src="<%=cp%>/resource/img/portfolio/05-thumbnail.jpg" alt="">
					</a>
					<div class="portfolio-caption">
						<h4>냥용품5</h4>
						<p class="text-muted">추천5</p>
					</div>
				</div>
				<div class="col-md-4 col-sm-6 portfolio-item">
					<a class="portfolio-link" data-toggle="modal"
						href="#portfolioModal6">
						<div class="portfolio-hover">
							<div class="portfolio-hover-content">
								<i class="fas fa-plus fa-3x"></i>
							</div>
						</div> <img class="img-fluid"
						src="<%=cp%>/resource/img/portfolio/06-thumbnail.jpg" alt="">
					</a>
					<div class="portfolio-caption">
						<h4>냥용품6</h4>
						<p class="text-muted">추천6</p>
					</div>
				</div>
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
				<div class="col-md-6">
					<div class="team-member">
						<a href="#"> <img class="mx-auto rounded-circle"
							src="<%=cp%>/resource/img/dog1.jpg" alt="">
						</a>
						<h4>댕댕이</h4>
					</div>
				</div>
				<div class="col-md-6">
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
				<div class="col-md-6">
					<span> <font color="#F2F2F2" size="4px;"><i
							class="fas fa-check" style="color: #F2F2F2">&nbsp;</i>공지사항</font><br>
					</span> <br>
					<p style="color: #666666">공지사항입니다.</p>
					<p style="color: #666666">공지사항입니다.</p>
					<p style="color: #666666">공지사항입니다.</p>
					<p style="color: #666666">공지사항입니다.</p>
				</div>
				<div class="col-md-6">
					<span> <font color="#F2F2F2" size="4px;"><i
							class="far fa-grin-hearts" style="color: #F2F2F2">&nbsp;</i>후기</font><br>
					</span> <br>
					<p style="color: #666666">후기입니다후기입니다후기입니다후기입니다후기입니다후기입니다</p>
					<p style="color: #666666">후기입니다후기입니다후기입니다후기입니다후기입니다후기입니다</p>
					<p style="color: #666666">후기입니다후기입니다후기입니다후기입니다후기입니다후기입니다</p>
					<p style="color: #666666">후기입니다후기입니다후기입니다후기입니다후기입니다후기입니다</p>
				</div>
			</div>
		</div>
	</section>
