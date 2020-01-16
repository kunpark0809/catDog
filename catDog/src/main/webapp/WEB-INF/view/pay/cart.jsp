<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String cp=request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/dogshop.css">
<style>
.ui-dialog-titlebar{
	background: none;
    color: black;
    border: none;
    border-bottom: 1px solid #e4e4e4;
    border-radius: 0px;
    text-align: left;
}
.ui-dialog .ui-dialog-titlebar {
    padding-left: 0px;
}
.ui-dialog-title{
	padding-left: 10px;
	font-size: 14pt;
}

.ui-dialog{
	padding: 5px 20px;
	border-radius: 0px;
	position: fixed;
	
}
</style>
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
		$("input[name=productSum]").val(new Intl.NumberFormat('ko-KR', { style: 'currency', currency: 'KRW' }).format(data.product.price)+"원");
		$("input[name=cartNum]").val(cartNum);
	}
	
	ajaxJSON(url, "get", query, fn);
	
	$('#change_dialog').dialog({
		  modal: true,
		  height: 300,
		  width: 650,
		  title: '수량 변경',
		  close: function(event, ui) {
			  $("input[name=productCount]").val(1);
		  },
			open: function(event, ui) {
				$(".ui-dialog-titlebar-close", $(this).parent()).hide();
			}
	});
}

$(function(){
	$(".dialog_cancel").click(function(){
		$('#change_dialog').dialog("close");
	});
});


$(function(){
	$("input[type=checkbox]").on("change",function(){
		var check =  $("input[name=productCheck]:checked");
		var total = 0;
		
		if(check.length == 0){
			$("#cart_total").text(0);
			$("#cart_purchase").text(0 + " 원");
			$("#cart_deliver").text(0);
			return;
		}
		
		var length=${fn:length(cartList)};
		

		$.each(check,function(idx,item){
			<c:forEach var="product" items="${cartList}">
				if(${product.cartNum} == check[idx].value){
					total += ${product.productSum};
				}
			</c:forEach>
		});
		
		$("#cart_total").text(total.toLocaleString());
		$("#cart_deliver").text("2,500");
		$("#cart_purchase").text((total+2500).toLocaleString()+" 원");
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
	
	$("input[name=productSum]").val(new Intl.NumberFormat('ko-KR', { style: 'currency', currency: 'KRW' }).format(count*$("#proudct_price").val())+"원");
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

<div class="wide-container">
	<div class="order_tit" style="width: 100%;height: 60px;margin-bottom: 10px; line-height: 60px;">
        <div class="body-title" style="display: inline-block;"><i class="fas fa-cart-arrow-down"></i>&nbsp;장바구니</div>
        <div class="pay-seq" style="float: right; font-size: 14pt;">
        <ul>
            <li class="page-on">01&nbsp;&nbsp;장바구니&nbsp;&nbsp;&nbsp;>&nbsp;&nbsp;&nbsp; </li>
            <li class="page-off">02&nbsp;&nbsp;주문서작성/결제&nbsp;&nbsp;&nbsp;>&nbsp;&nbsp;&nbsp;</li>
            <li class="page-off">03&nbsp;&nbsp;주문완료</li>
        </ul>
        </div>
    </div>

	<c:if test="${not empty cartList}">
		<form name="cartList" method="post">
			<div class="cartList">
				<table class="cartTable" >
				<tr style="color: black;background-color: #eaeaea;">
					<td><input type="checkbox" value="all" id="cartAllCheck" onchange="checkCart();"></td>
					<td>이미지</td>
					<td style="padding: 5px 0px;">상품정보</td>
					<td>판매가</td>
					<td>수량</td>
					<td>배송비</td>
					<td>합계</td>
				</tr>
	
				<c:forEach var="product" items="${cartList}">
					<tr style="border-bottom: 1px solid #d4d4d4;">
						<td>
							<input type="checkbox" value="${product.cartNum}" name="productCheck">
						</td> 
						<td><img alt="" src="<%=cp%>/uploads/shop/${product.imageFileName}" width="75" height="75"></td>
						<td><a href="<%=cp%>/shop/article?productNum=${product.productNum}&bigSortNum=${product.bigSortNum}">${product.productName}</a></td>
						<td> <fmt:formatNumber value="${product.productSum}" type="number"/></td>
						<td style="padding: 5px 0px;">${product.productCount}개
							<p><button type="button" class="whiteBtn" style="width: 50%;height: 35px;" onclick="changeDialog('${product.productNum}','${product.cartNum}');">수량변경</button></p>						
						</td>
						<td>2,500</td>
						<td><fmt:formatNumber value="${product.productSum}" type="number"/></td>
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
	<div class="totalPay" style="text-align: right;border-bottom: 1.5px solid #d4d4d4;padding: 15px 15px 15px 0px;">
		상품구매금액 
		<span id="cart_total" style="font-weight: bold;">0</span> 
		+ 배송비 <span id="cart_deliver">0</span> 
		= 합계 : <span id="cart_purchase" style="font-weight: bold; color: #d96363; font-size: 15pt;">0 원</span>
	</div>
	
	<div class="btnList" style="margin-top: 20px;">
        <span class="btn_left_box">
            <button type="button" class="whiteBtn" onclick="deleteCart();">선택 상품 삭제</button>
        </span>
        <span class="btn_right_box">
            <button type="button" class="whiteBtn" onclick="productPay('select');">선택 상품 주문</button>
            <button type="button" class="pinkBtn" onclick="productPay('all');">전체 상품 주문</button>
        </span>
	</div>
	
		<div id="change_dialog" style="display: none; text-align: center;">
		<form method="post" name="countForm" action="<%=cp%>/pay/changeCount">
		<table style="margin-top: 20px;">
		
			<tr style="background: #d96262;border-bottom: 1px solid #d96262;color: white;font-size: 10pt;">
				<th width="400" style="padding: 5px 0px;">상품정보</th>
				<th width="100">수&nbsp;&nbsp;량</th>
				<th width="100">합&nbsp;&nbsp;계</th>
			</tr>
			<tr style="border-bottom: 1px solid #bfbfbf; font-size: 10pt;">
				<td><input type="text" id="proudct_name" name="productName" readonly="readonly" value="" style="border: none; width: 100%; text-align: center; padding: 10px 0px;"></td>
				<td><input type="number" value="1" name="productCount" onchange="changePrice();" class="numberInput"></td>
				<td><input type="text" name="productSum" readonly="readonly" value="" style="border: none; text-align: center; font-weight: bold; width: 100%;"></td>
			</tr>
		</table>	
				<input type="hidden" name="cartNum" value="">
				<input type="hidden" id="proudct_price" value="">
				
			<div class="dialog_btn_box">
				<button type="button" class="dialog_cancel">취소</button>
				<button type="submit" class="dialog_submit">확인</button>
			</div>
		</form>

		</div>
</div>
