<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/dogshop.css">
<script type="text/javascript">
$(function(){
	$("#sort-${smallSortNum}").addClass("sortActive");
	
	$(".sortName").click(function(){
		
		$(".sortName").each(function(){
			$(this).removeClass("sortActive");
		});
		
		
		var smallSortNum = $(this).attr("data-num");
		$("#sort-"+smallSortNum).addClass("sortActive");
		location.href="<%=cp%>/dogshop/list?smallSortNum="+smallSortNum;
	})
});
</script>
	<div>
		<h2 class="text-uppercase">DogShop</h2>
		<button type="button" onclick="javascript:location.href='<%=cp%>/dogshop/created'">글올리기</button>
		
		<div class="bestProduct">
		<h3 class="text-muted">BEST</h3>
		</div>
		<div class="sortList">
		
			<a class="sortName" data-num="0" id="sort-0">전체</a>
			<c:forEach var="sort" items="${sortList}">
				<a class="sortName" data-num="${sort.smallSortNum}" id="sort-${sort.smallSortNum}">${sort.sortName}</a>	
			</c:forEach>
		</div>
		<div class="productList">	
			<c:forEach var="dto" items="${list}">
				<a onclick="javascript:location.href='${articleUrl}&productNum=${dto.productNum}'" class="productLink">
					<input type="hidden" value="${dto.productNum}">
					<input type="hidden" value="${dto.price}">
					<img alt="" src="<%=cp%>/uploads/dogshop/${dto.imageFileName}" width="200">
					<p>${dto.name}</p>
				</a>	
			</c:forEach>
		</div>
		
		<div class="paging">
			${dataCount==0?"데이터 준비중 입니다.":paging}
		</div>
	</div>