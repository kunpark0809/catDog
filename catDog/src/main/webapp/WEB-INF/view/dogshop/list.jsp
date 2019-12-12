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
		
		<h3 class="text-muted">BEST</h3>
			<c:forEach var="sort" items="${sortList}">
				<a onclick="searchList(${sort.smallSortNum});" class="sortName">${sort.sortName}</a>	
			</c:forEach>
	</div>