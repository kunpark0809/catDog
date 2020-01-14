<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/dogshop.css">
<style>
.ui-dialog-titlebar{
	background: none;
    color: black;
    border: none;
    border-bottom: 1px solid #e4e4e4;
    border-radius: 0px;
}
.ui-dialog .ui-dialog-titlebar {
    padding-left: 0px;
}
.ui-dialog{
	padding: 5px 20px;
	border-radius: 0px;
	position: fixed;
	
}
</style>
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

// 스크롤 이동
function moveTag(seq){
    var offset = $("#menu-" + seq).offset();
    $('html, body').animate({scrollTop : offset.top-97-34}, 400);
}


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
		  width: 400,
		  title: '장바구니 담기',
		  close: function(event, ui) {
		  },
		open: function(event, ui) {
			$(".ui-dialog-titlebar-close", $(this).parent()).hide();
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
	var productSum = parseInt(count)*${dto.price};
	$("input[name=productSum]").val(count*${dto.price});
	
	document.getElementById("pointSum").innerHTML= "(<i class='fas fa-paw' style='color: #d96363;'></i> "+Math.floor(productSum*0.01)+"원)";
	document.getElementById("productSum").innerHTML=new Intl.NumberFormat('ko-KR', { style: 'currency', currency: 'KRW' }).format(productSum)+"원";
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
		<div id="top-menu">
			<ul>
				<li onclick="moveTag('detail');">상세설명</li>
				<li onclick="moveTag('review');">상품후기</li>
				<li onclick="moveTag('deliver');">배송안내</li>
				<li onclick="moveTag('refund');">교환/반품</li>
			</ul>
		</div>
	<div class="shin_body"> 
		
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
				<p style="font-weight: bold;font-size: 35px;">${dto.name}</p>
			
				<table style="line-height: 30px;">
				<tr>
					<td width="100">가격</td>
					<fmt:formatNumber var="price" value="${dto.price}" type="currency" />
					<td><b>${price}원</b></td>
				</tr>
				<tr>
					<td width="100">구매혜택</td>
					<fmt:parseNumber var="point" value="${dto.price*0.01}" integerOnly="true"/>
					<td><i class="fas fa-paw" style="color: #d96363;"></i>&nbsp;적립 포인트 : <b>${point}원</b></td>
				</tr>
				<tr>
					<td width="100">배송비</td>
					<td>2,500원 / 주문시 결제(선결제)</td>
				</tr>

				</table>
				<div class="product_count" style="min-height: 50px;">
					<span style="width: 60%; float:left; line-height: 50px;">${dto.name}</span>
					<span style="width: 20%;float:left;padding-top: 11px;"><input type="number" value="1" name="productCount" onchange="changePrice();" class="numberInput"></span>
					<input type="hidden" readonly="readonly" name="productSum" value="${price}">
					<div style="float: left; width: 20%; text-align: right;">
					<b>
						<p id="productSum" > ${price}원</p>
						<p id="pointSum" > (<i class="fas fa-paw" style="color: #d96363;"></i>&nbsp;<fmt:parseNumber value="${dto.price*0.01}" integerOnly="true"/>원)</p>
					</b>
					</div>
				</div>
			
				<div class="product_btn" style="margin-top: 10px;">
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
		<div class="wide-container">
		<div class="product-main" style="clear: both;" id="menu-detail">
			<p class="product-menu">상세설명</p>
			${dto.content}
		</div>
		

		<div id="menu-review">
			<p class="product-menu">상품 후기</p>
			
				<div id="review"  class="review" style="float: left;">
				</div>
		</div>
		
		<div style="clear: both;" id="menu-deliver">
			<p class="product-menu">배송 안내</p>
			<div class="admin_msg">
				<p>
					<b><span style="font-size: 10pt; color:black;">&lt;배송정보&gt;</span></b>
				</p>
				<p>
					<b>- 배송방법 : </b>택배/소포/등기
				</p>
				<p>
					<b>- 배송지역 :</b> 국내배송
				</p>
				<p>
					<b>- 택배사 :</b>&nbsp;한진택배
				</p>
				<p>
					<b>- 배송완료일수 :</b> 2-3일정도 소요
				</p>
				<p>
					<b>- 배송비 : </b>2,500원
				</p>
				<p>
					<b>- 배송비 무료조건 : </b>30,000원 이상 주문 시 무료
				</p>
				<p>
					<b>- 추가 배송비 : </b>도서산간 지역
				</p>
				<p>※업체 직배송 제품이나 상품 종류에 따라 배송비가 추가될 수 있음&nbsp;</p>
				<p>&nbsp;</p>
				<p>
					<b><span style="font-size: 10pt; color:black;">&lt;반품주소&gt;</span></b>
				</p>
				<p>
					<b>- 반품지명 :</b> 올라펫 물류센터
				</p>
				<p>
					<b>- 반품주소 :</b>&nbsp;경기도 화성시 서신면 전곡산단9길 5, 백운엔지니어링 A동 올라펫물류센터
				</p>
				<p>
					<b>- 반품 연락처 :</b> 1544-7867
				</p>
				<p>
					<b>- 반품 택배사 : </b>한진택배
				</p>
				<p>&nbsp;</p>
				<p>
					<b><span style="font-size: 10pt; color:black;">&lt;출하지주소&gt;</span></b>
				</p>
				<p>
					<b>- 출하지명 :</b> 올라펫 물류센터
				</p>
				<p>
					<b>- 출하지 주소 : </b>경기도 화성시 서신면 전곡산단9길 5, 백운엔지니어링 A동 올라펫물류센터
				</p>
				<p>
					<b>- 출하지 연락처 :</b> 1544-7867
				</p>
			</div>
		</div>
		<div id="menu-refund">
			<p class="product-menu">교환/반품<p>
			<div class="admin_msg">
			<p>
				<b><span style="font-size: 10pt; color:black;">&lt;교환/반품 안내&gt;</span></b>
			</p>
			<p>- 상품 수령 후 7일 이내 개봉 전 상품이라면 교환/반품이 가능합니다.</p>
			
			<p>- 상품에 하자가 있을 경우 교환/반품의 택배비는 쇼핑몰에서 부담합니다.</p>
			
			<p>- 고객 변심으로 교환/반품을 원할 경우, 무료배송으로 상품을 받아 보셨다면 왕복 택배비 6,000원,</p>
			
			  <p>그러지 않은 경우에는 3,000원을 고객님께서 부담하셔야 합니다.</p>
			
			  <p>( 색상이나 디자인, 사이즈 등이 다를 경우에도 고객변심으로 해당 되오니 꼼꼼히 살펴보시고 구입 부탁드립니다. )</p>
			  </div>
			  <br>
			  <div class="admin_msg">
				<p>
					<b><span style="font-size: 10pt; color:black;">&lt;환불안내&gt;</span></b>
				</p>
				<p>- 환불관련 자세한 사항은 카카오톡 @올라펫 또는 올라펫샵 서비스센터 1544-7867 로 문의주시기 바랍니다.</p>
              </div>
              <br>
              <div class="admin_msg">
				<p>
					<b><span style="font-size: 10pt; color:black;">&lt;AS안내&gt;</span></b>
				</p>
				<p>- 소비자분쟁해결 기준(공정거래위원회 고시)에 따라 피해를 보상받을 수 있습니다.</p><p>- "식품"의 경우 A/S가 불가능 합니다.</p><p>- 상품 제조사의 A/S 기준에 따릅니다.&nbsp;</p><p>- A/S 관련 자세한 사항은 카카오톡 @올라펫 또는 올라펫샵 고객센터 1544-7867 로 문의주시기 바랍니다.</p>
              </div>
		</div>
		</div>
		<div id="cart_dialog" style="display: none; text-align: center;">
			<p style="margin: 10px 0px 15px;"><img alt="" src="<%=cp%>/resource/img/cart.png" width="80px"></p>
			<p class="dialog_msg" style="font-size: 11pt;">
				<strong>상품이 장바구니에 담겼습니다.</strong>
				<br>
				바로 확인하시겠습니까?
			</p>
			<div class="dialog_btn_box" >
				<button type="button" class="btnDialogCanecl dialog_cancel">취소</button>
				<button type="button" class="dialog_submit" onclick="javascript:location.href='<%=cp%>/pay/cart';">확인</button>
			</div>
		</div>
	</div>