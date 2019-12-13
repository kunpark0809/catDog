<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/dogshop.css">
<script type="text/javascript">
function searchList(smallSortNum){
	alert(smallSortNum);
}
</script>
	<div>
		<h2 class="text-uppercase">DogShop</h2>
		<button type="button" onclick="javascript:location.href='<%=cp%>/dogshop/created'">글올리기</button>
		
		<div class="bestProduct">
		<h3 class="text-muted">BEST</h3>
		</div>
		<div class="sortList">
		
			<a onclick="javascript:location.href='<%=cp%>/dogshop/list';" class="sortName">전체</a>
			<c:forEach var="sort" items="${sortList}">
				<a onclick="searchList(${sort.smallSortNum});" class="sortName">${sort.sortName}</a>	
			</c:forEach>
		</div>
		<div class="productList">	
			<c:forEach var="dto" items="${list}">
				<input type="hidden" value="${dto.productNum}">
				<input type="hidden" value="${dto.price}">
				<img alt="" src="<%=cp%>/uploads/dogshop/${dto.imageFileName}" width="200">
				<p>${dto.name}</p>			
			</c:forEach>
		</div>
	</div>