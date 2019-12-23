<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
		location.href="<%=cp%>/dogshop/list?smallSortNum="+smallSortNum;
	})
});

$(function(){
	$("body").on("click",".sub-img",function(){
		var imgName = $(this).attr("data-img");
		$(".main-img img").attr("src","<%=cp%>/uploads/dogshop/"+imgName);
	});
});

function cart(productNum){
	console.log(productNum);
	
	
	$('#cart_dialog').dialog({
		  modal: true,
		  height: 650,
		  width: 600,
		  title: '장바구니 담기',
		  close: function(event, ui) {
		  }
	});
}

$(function(){
	$(".btnDialogCanecl").click(function(){
		$('#cart_dialog').dialog("close");
	});
});

function pay(productNum){
	var quantity = $("input[name=quantity]").val();
	location.href="<%=cp%>/pay/pay?productNum="+productNum+"&quantity="+quantity;
}
</script>
	<div>
		<div class="sortList">
		
			<a class="sortName" data-num="0" id="sort-0">전체</a>
			<c:forEach var="sort" items="${sortList}">
				<a class="sortName" data-num="${sort.smallSortNum}" id="sort-${sort.smallSortNum}">${sort.sortName}</a>	
			</c:forEach>
		</div>
		<div class="product-info">
			<div class="product-img">
				<div class="main-img">
					<img alt="" src="<%=cp%>/uploads/dogshop/${list.get(0).imageFileName}">
				</div>
				<div class="imgList">
					<c:forEach var="dto" items="${list}">
						<div class="sub-img" data-img="${dto.imageFileName}">
							<img alt="" src="<%=cp%>/uploads/dogshop/${dto.imageFileName}">
						</div>
					</c:forEach>
				</div>
			</div>
			
			<div class="product-info-detail"> 
				<table>
				<tr>
					<td colspan="2">${list.get(0).name}</td>
				</tr>
				<tr>
					<td>가격</td>
					<fmt:formatNumber var="price" value="${list.get(0).price}" type="currency" />
					<td>${price}원</td>
				</tr>
				<tr>
					<td>배송비</td>
					<td>2,500원 / 주문시 결제(선결제)</td>
				</tr>
				<tr>
					<td>포인트</td>
					<fmt:parseNumber var="point" value="${list.get(0).price*0.01}" integerOnly="true"/>
					<td>${point}원</td>
				</tr>
				</table>
				<div class="product_quantity">
					<input type="text" value="1" name="quantity">
					<span>
						<button type="button"  class="quantity_up"></button>
						<button type="button" class="quantity_down"></button> 
					</span>
					<span>${price}원</span>
				</div>
				<div class="product_btn">
					<button type="button" class="shop_order" onclick="pay('${list.get(0).productNum}');">구매하기</button>
					<button type="button" class="shop_cart" onclick="cart('${list.get(0).productNum}');">장바구니</button>
				</div>
			</div>
		</div>
		<div class="product-main" style="clear: both;">
			${list.get(0).content}
		</div>
		
		<div id="cart_dialog" style="display: none;">
			<strong>상품이 장바구니에 담겼습니다.</strong>
			<br>
			바로 확인하시겠습니까?
			<div class="btn_box">
				<button type="button" class="btnDialogCanecl">취소</button>
				<button type="button" onclick="javascript:location.href='<%=cp%>/pay/cart';">확인</button>
			</div>
		</div>
	</div>