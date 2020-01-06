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
	<div class="shin_body">
		<h3 style="display: inline;">Shop</h3>
		<c:if test="${fn:indexOf(sessionScope.member.userId,'admin') == 0}">
			<span><button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/shop/created'">글올리기</button></span>
		</c:if>
		
		<div class="bestProduct">
		<h3 class="text-muted">BEST</h3>
		</div>
		<div class=" ">
		
			<a class="sortName" data-num="0" id="sort-0">전체</a>
			<c:forEach var="sort" items="${smallSortList}">
				<a class="sortName" data-num="${sort.smallSortNum}" id="sort-${sort.smallSortNum}">${sort.sortName}</a>	
			</c:forEach>
		</div>
		<div class="productList">	
			<table style="width: 100%">
					<c:forEach var="dto" items="${list}" varStatus="status">
					     <c:if test="${status.index==0}">
                     		  <tr>
		                 </c:if>
		                 <c:if test="${status.index!=0 && status.index%4==0}">
		                       <c:out value="</tr><tr>" escapeXml="false"/>
		                 </c:if>
						
							<td width="20%">
								<div class="productLink" onclick="javascript:location.href='${articleUrl}&productNum=${dto.productNum}'">
									<input type="hidden" value="${dto.productNum}">
									<input type="hidden" value="${dto.price}">
										<img alt="" src="<%=cp%>/uploads/shop/${dto.imageFileName}" width="200" height="200">
									<p style="margin: 0px;">${dto.name}</p>
								</div>
							</td>
					</c:forEach>
			</table>
		</div>
		
		<div class="paging">
			${dataCount==0?"데이터 준비중 입니다.":paging}
		</div>
	</div>