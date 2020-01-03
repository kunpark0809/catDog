<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/dogshop.css">
<script type="text/javascript">
function ajaxJSON(url, type, query, fn) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			fn(data);
		}
		,beforeSend:function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return false;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

function checkCart(){
	if($("#cartAllCheck").is(':checked')){
		$("input[name=productCheck]").prop("checked",true);
	} else{
		$("input[name=productCheck]").prop("checked",false);
	}
}

function changeDialog(productNum, cartNum){
	var url = "<%=cp%>/pay/changeCount";
	var query = "productNum="+productNum;
	
	var fn=function(data){
		$("#proudct_name").val(data.product.productName);
		$("#proudct_price").val(data.product.price);
		$("input[name=productSum]").val(data.product.price);
		$("input[name=cartNum]").val(cartNum);
	}
	
	ajaxJSON(url, "get", query, fn);
	
	$('#change_dialog').dialog({
		  modal: true,
		  height: 300,
		  width: 750,
		  title: '수량 변경',
		  close: function(event, ui) {
			  $("input[name=productCount]").val(1);
		  }
	});
}

$(function(){
	$(".btnDialogCanecl").click(function(){
		$('#change_dialog').dialog("close");
	});
});

function changePrice(){
	var count = $("input[name=productCount]").val();
	console.log(count);
	
	if(count <= 0){
		alert("잘못된 수량입니다.");
		$("input[name=productCount]").val(1);
		count = 1;
	}
	
	$("input[name=productSum]").val(count*$("#proudct_price").val());
}

function deleteCart(){
	
	var cnt = $("input[name=productCheck]:checked").length;
	
	if(cnt == 0){
		alert("선택된 장바구니 항목이 없습니다.");
		return;
	}
	
	if(confirm("선택한 게시물을 삭제하시겠습니까? ")){
		var f = document.cartList;
		f.action="<%=cp%>/pay/deleteCart";
		f.submit();
	}
	
}

function productPay(mode){
	if(mode=="all"){
		$("input[name=productCheck]").prop("checked",true);
	}
	
	var cnt = $("input[name=productCheck]:checked").length;
	
	if(cnt == 0){
		alert("선택된 장바구니 항목이 없습니다.");
		return;
	}
	
	var f = document.cartList;
	f.action="<%=cp%>/pay/cart/payForm";
	f.submit();
	
}
</script>

<div class="shin_body">
	<div class="order_tit" style="width: 100%;">
        <h2 style="display: inline; float: left;">장바구니</h2>
        <ol style="display: inline-block; float: right;">
            <li class="page_on"><span>01</span>장바구니 > </li>
            <li><span>02</span> 주문서작성/결제 > </li>
            <li><span>03</span> 주문완료</li>
        </ol>
    </div>

	<c:if test="${not empty cartList}">
		<form name="cartList" method="post">
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
						<td>
							<input type="checkbox" value="${product.cartNum}" name="productCheck">
						</td> 
						<td><img alt="" src="<%=cp%>/uploads/dogshop/${product.imageFileName}" width="50"></td>
						<td><a href="<%=cp%>/dogshop/article?productNum=${product.productNum}">${product.productName}</a></td>
						<td>${product.productSum}</td>
						<td>${product.productCount}
							<p><button type="button" class="btn" onclick="changeDialog('${product.productNum}','${product.cartNum}');">수량변경</button></p>						
						</td>
						<td>2,500</td>
						<td>${product.productSum}</td>
					</tr>
				</c:forEach>                                                                                              
			</table>
			</div>
		</form>
	</c:if>
	
	<c:if test="${empty cartList}">

		<div class="cartList">
			<table class="cartTable">
				 <tr>
				 	<td>
				 		장바구니에 담겨있는 상품이 없습니다.
				 	</td>
				 </tr>                                                                                             
			</table>
		</div>

	</c:if>
	<div class="totalPay">
		총 결제 금액 : 
		
	</div>
	
	<div class="btnList">
        <span class="btn_left_box">
            <button type="button" class="btn" onclick="deleteCart();">선택 상품 삭제</button>
        </span>
        <span class="btn_right_box">
            <button type="button" class="btn" onclick="productPay('select');">선택 상품 주문</button>
            <button type="button" class="btn" onclick="productPay('all');">전체 상품 주문</button>
        </span>
	</div>
	
		<div id="change_dialog" style="display: none;">
		<form method="post" name="countForm" action="<%=cp%>/pay/changeCount">
			<table>
				<tr>
					<td>
						<input type="text" id="proudct_name" name="productName" readonly="readonly" value="">
					</td>
					<td>
						<input type="number" value="1" name="productCount" onchange="changePrice();">
					</td>
					<td>
						<input type="hidden" name="cartNum" value="">
						<input type="hidden" id="proudct_price" value="">
						<input type="text" name="productSum" readonly="readonly" value="">
					</td>
				</tr>
			</table>
			<div class="btn_box">
				<button type="button" class="btnDialogCanecl">취소</button>
				<button type="submit">확인</button>
			</div>
		</form>

		</div>
</div>
