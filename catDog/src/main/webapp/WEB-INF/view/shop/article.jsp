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
function login() {
	location.href="<%=cp%>/customer/login";
}

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

function ajaxHTML(url, type, query, selector) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,success:function(data) {
			$(selector).html(data);
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

$(function(){
	$("body").on("click",".sub-img",function(){
		var imgName = $(this).attr("data-img");
		$(".main-img img").attr("src","<%=cp%>/uploads/shop/"+imgName);
	});
});

function cart(){
	
	var productNum = ${dto.productNum};
	var productCount = $("input[name=productCount]").val();
	var url = "<%=cp%>/pay/insertCart";
	var query = "productNum="+productNum+"&productCount="+productCount;
	var fn = function(data){
	}
	
	ajaxJSON(url, "get", query, fn);
	
	$('#cart_dialog').dialog({
		  modal: true,
		  height: 300,
		  width: 300,
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
	var productCount = $("input[name=productCount]").val();
	location.href="<%=cp%>/pay/direct/pay?productNum="+productNum+"&productCount="+productCount;
}

function changePrice(){
	var count = $("input[name=productCount]").val();
	
	if(count <= 0){
		alert("잘못된 수량입니다.");
		$("input[name=productCount]").val(1);
		count = 1;
	}
	
	$("input[name=productSum]").val(count*${dto.price});
}

function deleteProduct(){
	if(confirm("위 자료를 삭제 하시겠습니까?")){
		location.href="<%=cp%>/shop/delete?${query}&productNum=${dto.productNum}";
	}
}

$(function(){
	listReview(1);
});

function listReview(page){
	var url= "<%=cp%>/shop/listRate";
	var query ="productNum=${dto.productNum}&pageNo="+page;
	var selector ="#review";
	
	ajaxHTML(url, "get", query, selector);
}

</script>
	<div class="wide-container"> 
		<div class="sortList">
		
			<a class="sortName" data-num="0" id="sort-0">전체</a>
			<c:forEach var="sort" items="${smallSortList}">
				<a class="sortName" data-num="${sort.smallSortNum}" id="sort-${sort.smallSortNum}">${sort.sortName}</a>	
			</c:forEach>
		</div>
		<div class="product-info">
			<div class="product-img">
				<div class="main-img">
					<img alt="" src="<%=cp%>/uploads/shop/${dto.imageFileName}">
				</div>
				<div class="imgList">
					<c:forEach var="dto" items="${picList}">
						<div class="sub-img" data-img="${dto.imageFileName}">
							<img alt="" src="<%=cp%>/uploads/shop/${dto.imageFileName}">
						</div>
					</c:forEach>
				</div>
			</div>
			
			<div class="product-info-detail"> 
				<table>
				<tr>
					<td colspan="2">${dto.name}</td>
				</tr>
				<tr>
					<td>가격</td>
					<fmt:formatNumber var="price" value="${dto.price}" type="currency" />
					<td>${price}원</td>
				</tr>
				<tr>
					<td>배송비</td>
					<td>2,500원 / 주문시 결제(선결제)</td>
				</tr>
				<tr>
					<td>포인트</td>
					<fmt:parseNumber var="point" value="${dto.price*0.01}" integerOnly="true"/>
					<td>${point}원</td>
				</tr>
				</table>
				<div class="product_count">
					<input type="number" value="1" name="productCount" onchange="changePrice();">

					<span><input type="text" readonly="readonly" name="productSum" value="${price}">원</span>
				</div>
				<div class="product_btn">
					<button type="button" class="payBtn" onclick="pay('${dto.productNum}');">구매하기</button>
					<button type="button" class="cartBtn" onclick="cart();">장바구니</button>
				</div>
				<c:if test="${fn:indexOf(sessionScope.member.userId,'admin') == 0}">
					<div class="admin_btn">
						<button type="button" onclick="javascript:location.href='<%=cp%>/shop/update?${query}&productNum=${dto.productNum}';">수정</button>
						<button type="button" onclick="deleteProduct();">삭제</button>
					</div>
				</c:if>
			</div>
		</div>
		<div class="product-main" style="clear: both;">
			<h4>상세설명</h4>
			${dto.content}
		</div>
		
		<div>
			<h4>상품 후기</h4>
			
				<div id="review"  class="review" style="float: left;">
				</div>
		<div style="clear: both;">
			<h4>배송 안내</h4>
			<p>배송 방법 : 택배</p>
			<p>배송 지역 : 전국지역</p>
			<p>배송 비용 : 2,500원</p>
			<p>배송 기간 : 2일 ~ 7일</p>
			<p>배송 안내 :</p>
			<p>- 3만원이상 무료 배송!</p>
			
			  <p>( 고객변심으로 인한 주문 취소 후 3만원 미만일 경우 배송비는 추가 됩니다. )</p>
			
			<p>- 기본 배송료는 2,500원입니다.</p>
			
			<p>- 오후 3시 이전에 결제 완료된 주문 건은 당일 출고 됩니다!</p>
			
			 <p> ( 주문 취소는 오후 3시 이전에 가능합니다. )</p>
			
			<p>- 평균 배송일은 출고일 기준 1~3일입니다.</p>
			
			<p>  ( 단, 업체 배송 상품은 업체에서 출고가 되며, 당일 출고가 되지 않을 수 있습니다. )</p>
		</div>
		<div>
			<h4>교환/반품</h4>
			<p>- 상품 수령 후 7일 이내 개봉 전 상품이라면 교환/반품이 가능합니다.</p>
			
			<p>- 상품에 하자가 있을 경우 교환/반품의 택배비는 쇼핑몰에서 부담합니다.</p>
			
			<p>- 고객 변심으로 교환/반품을 원할 경우, 무료배송으로 상품을 받아 보셨다면 왕복 택배비 6,000원,</p>
			
			  <p>그러지 않은 경우에는 3,000원을 고객님께서 부담하셔야 합니다.</p>
			
			  <p>( 색상이나 디자인, 사이즈 등이 다를 경우에도 고객변심으로 해당 되오니 꼼꼼히 살펴보시고 구입 부탁드립니다. )</p>
		</div>
		<div id="cart_dialog" style="display: none; text-align: center;">
			<strong>상품이 장바구니에 담겼습니다.</strong>
			<br>
			바로 확인하시겠습니까?
			<div class="btn_box">
				<button type="button" class="btnDialogCanecl dialog_cancel">취소</button>
				<button type="button" class="dialog_submit" onclick="javascript:location.href='<%=cp%>/pay/cart';">확인</button>
			</div>
		</div>
	</div>
	</div>