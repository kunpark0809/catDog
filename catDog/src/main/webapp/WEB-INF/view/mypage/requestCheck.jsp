<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<div class="body-container" style="width: 1200px; margin: 20px auto 0px; border-spacing: 0px;">
	<div class="body-title">
		<h3><span style="font-family: Webdings"></span> 주문 상품 정보 </h3>
	</div>
	
	<div>
		<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
			<tr height="35">
				<td align="left" width="50%">
					${dataCount}개(${page}/${total_page} 페이지)
				</td>
				<td align="right">
					&nbsp;
				</td>
			</tr>
		</table>
	
		<table style="width: 100%; border-spacing: 0px; border-collapse: collapse;">
			<tr align="center" bgcolor="#eeeeee" height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				<th width="130" style="color: #787878;">주문일자<br>[주문번호]</th>
				<th style="color: #787878; width: 80px;">이미지</th>
				<th width="300" style="color: #787878;">상품정보</th>
				<th width="80" style="color: #787878;">수량</th>
				<th width="60" style="color: #787878;">상품구매금액</th>
				<th width="60" style="color: #787878;">주문처리상태</th>
				<th width="70" style="color: #787878;">취소/교환/반품</th>
			</tr>
			
			<c:forEach var="dto" items="${list}">
			<tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;"> 
				<td>${dto.requestDate}<br><a href="<%=cp%>${detailUrl}&requestNum=${dto.requestNum}">${dto.requestNum}</a></td>
				<td align="left" style="padding-left: 10px;">
					<a href="<%=cp%>/dogshop/article?productNum=${dto.productNum}"><img style="width: 80px; height: 80px;" src="<%=cp%>/uploads/dogshop/${dto.imageFileName}"></a>
				</td>
				<td>
					<a href="<%=cp%>/dogshop/article?productNum=${dto.productNum}">${dto.productName}</a>
				</td>
				<td>${dto.productCount}</td>
				<td>${dto.productSum}</td>
				<td>${dto.status}</td>
				<td>
					-
				</td>
			</tr>
			</c:forEach>
		
		</table>
		
		<table style="width: 100%; border-spacing: 0px;">
			<tr height="35">
				<td align="center">
					${dataCount==0 ? "등록된 자료가 없습니다." : paging}
				</td>
			</tr>
		</table>
	
	</div>






</div>