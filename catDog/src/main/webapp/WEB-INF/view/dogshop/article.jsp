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
		location.href="<%=cp%>/dogshop/delete?${query}&productNum=${dto.productNum}";
	}
}
</script>
	<div class="shin_body"> 
		<div class="sortList">
		
			<a class="sortName" data-num="0" id="sort-0">전체</a>
			<c:forEach var="sort" items="${sortList}">
				<a class="sortName" data-num="${sort.smallSortNum}" id="sort-${sort.smallSortNum}">${sort.sortName}</a>	
			</c:forEach>
		</div>
		<div class="product-info">
			<div class="product-img">
				<div class="main-img">
					<img alt="" src="<%=cp%>/uploads/dogshop/${dto.imageFileName}">
				</div>
				<div class="imgList">
					<c:forEach var="dto" items="${picList}">
						<div class="sub-img" data-img="${dto.imageFileName}">
							<img alt="" src="<%=cp%>/uploads/dogshop/${dto.imageFileName}">
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
						<button type="button" onclick="javascript:location.href='<%=cp%>/dogshop/update?${query}&productNum=${dto.productNum}';">수정</button>
						<button type="button" onclick="deleteProduct();">삭제</button>
					</div>
				</c:if>
			</div>
		</div>
		<div class="product-main" style="clear: both;">
			${dto.content}
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