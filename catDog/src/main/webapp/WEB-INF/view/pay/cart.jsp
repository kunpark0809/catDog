<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/dogshop.css">
<script type="text/javascript">
function checkCart(){
	if($("#cartAllCheck").is(':checked')){
		$("input[name=productCheck]").prop("checked",true);
	} else{
		$("input[name=productCheck]").prop("checked",false);
	}
	
}
</script>

<div class="shin_body">
	<form>
		<div class="cartList">
			<table class="cartTable">
			<tr>
				<td><input type="checkbox" value="all" id="cartAllCheck" onchange="checkCart();"></td>
				<td colspan="2">상품정보</td>
				<td>판매가</td>
				<td>수량</td>
				<td>배송비</td>
				<td>합계</td>
			</tr>

			<c:forEach var="product" items="${cartList}">
				<tr>
					<td><input type="checkbox" value="${product.productNum}" name="productCheck"></td>
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

        <span class="btn_left_box">
            <button type="button" class="btn" onclick="">선택 상품 삭제</button>
            <button type="button" class="btn" onclick="">선택 상품 찜</button>
        </span>
        <span class="btn_right_box">
            <button type="button" class="btn" onclick="">선택 상품 주문</button>
            <button type="button" class="btn" onclick="">전체 상품 주문</button>
        </span>

	</div>
</div>	
