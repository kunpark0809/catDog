<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form>
		<div class="cartList">
			<table>
			<tr>
				<td colspan="2">상품정보</td>
				<td>판매가</td>
				<td>수량</td>
				<td>배송비</td>
				<td>합계</td>
			</tr>
			<c:forEach var="product" items="${cartList}">
				<tr>
					<td><img alt="" src="<%=cp%>/uploads/dogshop/${product.imageFileName}" width="50"></td>
					<td>${product.productName}</td>
					<td>${product.productSum}</td>
					<td>${product.productCount}</td>
					<td>2,500</td>
					<td>${product.productSum}</td>
				</tr>
			</c:forEach>
		</table>
		</div>
	</form>
	<div class="totalPay">
		총 결제 금액 : 
		
	</div>
	
	<div class="btnList">
		
	</div>
</body>
</html>