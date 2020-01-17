<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/dogshop.css">
<script type="text/javascript" src="<%=cp%>/resource/vendor/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#sort-${smallSortNum}").addClass("sortActive");
	
	$(".sortName").click(function(){
		
		$(".sortName").each(function(){
			$(this).removeClass("sortActive");
		});
		
		
		var smallSortNum = $(this).attr("data-num");
		$("#sort-"+smallSortNum).addClass("sortActive");
		location.href="<%=cp%>/shop/list?smallSortNum="+smallSortNum+"&bigSortNum=${bigSortNum}";
	})
});
</script>
	<div class="wide-container">
		<div>
			<span class="body-title" style="float: left;"><i class="fas fa-sort-alpha-down"></i>&nbsp;${bigSortNum=="1"?"강아지":"고양이"}&nbsp;용품</span>
			<c:if test="${fn:indexOf(sessionScope.member.userId,'admin') == 0}">
				<span style="float: right;"><button type="button" class="smallPinkBtn" onclick="javascript:location.href='<%=cp%>/shop/created'" >상품등록</button></span>
			</c:if>
		</div> 
		<div class="sortList" style="clear: both;">
		
			<a class="sortName" data-num="0" id="sort-0">전체</a>
			<c:forEach var="sort" items="${smallSortList}">
				<a class="sortName" data-num="${sort.smallSortNum}" id="sort-${sort.smallSortNum}">${sort.sortName}</a>	
			</c:forEach>
		</div>
		<div class="productList">	
			<ul style="width: 100%">
					<c:forEach var="dto" items="${list}" varStatus="status">

						
							<li style="width:23%;" onclick="javascript:location.href='${articleUrl}&productNum=${dto.productNum}'">

									<div class="product-image">
										<img alt="" src="<%=cp%>/uploads/shop/${dto.imageFileName}" width="100%" height="250">
									</div>
									<div class="product-text">
										<p style="margin: 0px;">${dto.name}</p>
										
										<p style="margin: 0px;" class="product-price"><fmt:formatNumber value="${dto.price}" type="currency"/>원</p>
									</div>
							</li>
					</c:forEach>
			</ul>
		</div>
		
		<div class="paging">
			${dataCount==0?"데이터 준비중 입니다.":paging}
		</div>
	</div>