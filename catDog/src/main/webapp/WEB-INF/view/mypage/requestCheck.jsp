<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/dogshop.css">
<style>

.star-input>.input,
.star-input>.input>label:hover,
.star-input>.input>input:focus+label,
.star-input>.input>input:checked+label{display: inline-block;vertical-align:middle;background:url('<%=cp%>/resource/img/star.png')no-repeat;}
.star-input{white-space:nowrap;width:225px;height:40px;line-height:30px;}
.star-input>.input{width:150px;background-size:150px;height:28px;white-space:nowrap;overflow:hidden;position: relative;}
.star-input>.input>input{position:absolute;width:1px;height:1px;opacity:0;}
.star-input>.input.focus{outline:1px dotted #ddd;}
.star-input>.input>label{width:30px;height:0;padding:28px 0 0 0;overflow: hidden;float:left;cursor: pointer;position: absolute;top: 0;left: 0;}
.star-input>.input>label:hover,
.star-input>.input>input:focus+label,
.star-input>.input>input:checked+label{background-size: 150px;background-position: 0 bottom;}
.star-input>.input>label:hover~label{background-image: none;}
.star-input>.input>label[for="p1"]{width:30px;z-index:5;}
.star-input>.input>label[for="p2"]{width:60px;z-index:4;}
.star-input>.input>label[for="p3"]{width:90px;z-index:3;}
.star-input>.input>label[for="p4"]{width:120px;z-index:2;}
.star-input>.input>label[for="p5"]{width:150px;z-index:1;}
.star-input>output{display:inline-block;width:60px; font-size:18px;text-align:right; vertical-align:middle;}

</style>

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

function requestCancle(requestNum) {
	var q = "requestNum="+requestNum;
	var url = "<%=cp%>/mypage/requestCancle?"+q;
	if(confirm("주문을 취소하시겠습니까 ?")) {
		location.href=url;
	}
}

function requestRefund(requestNum) {
	var q = "requestNum="+requestNum;
	var url = "<%=cp%>/mypage/refundRequest?"+q;
	if(confirm("상품을 환불하시겠습니까 ?")) {
		location.href=url;
	}
}

function requestSwap(requestNum) {
	var q = "requestNum="+requestNum;
	var url = "<%=cp%>/mypage/swapRequest?"+q;
	if(confirm("상품을 교환하시겠습니까 ?")) {
		location.href=url;
	}
}

function reviewDialog(productNum,requestDetailNum){
	var url ="<%=cp%>/mypage/readProduct";
	var query = "productNum="+productNum;
	
	$("input[name=productNum]").val("");
	$("input[name=requestDetailNum]").val("");
	
	var fn = function(data){
		var product = data.product;
		$("img[name=productImg]").attr("src","<%=cp%>/uploads/shop/"+product.imageFileName);
		$(".productInfo_right").text(product.productName);
		$("input[name=productNum]").val(productNum);
		$("input[name=requestDetailNum]").val(requestDetailNum);
	};
	
	ajaxJSON(url, "get", query, fn);
	
	$('#review_dialog').dialog({
		  modal: true,
		  height: 550,
		  width: 500,
		  title: '리뷰 쓰기',
		  close: function(event, ui) {
		  },
		  open: function(event, ui) {
				$(".ui-dialog-titlebar-close", $(this).parent()).hide();
			}
	});
}

$(function(){
	$(".btnDialogCanecl").click(function(){
		$('#review_dialog').dialog("close");
	});
});


$(function(){
	var $star = $(".star-input"),
    $result = $("input[name=rate]");
	
  	$(document)
	    .on("focusin", ".star-input>.input", 
		    function(){
   		       $(this).addClass("focus");
 	    })
	    .on("focusout", ".star-input>.input", function(){
		    var $this = $(this);
		    setTimeout(function(){
      		    if($this.find(":focus").length === 0){
       			  $this.removeClass("focus");
     	 	    }
    		 }, 100);
  	    })
	    .on("change", ".star-input :radio", function(){
		    $result.val($(this).next().text());
	    })
	    .on("mouseover", ".star-input label", function(){
		    $result.val($(this).text());
	    })
	    .on("mouseleave", ".star-input>.input", function(){
		    var $checked = $star.find(":checked");
		    if($checked.length === 0){
			    $result.val("0");
		    } else {
			    $result.val($checked.next().text());
		    }
	    });
});


function submitReview(){
	var f = document.reviewForm;
	
	if(!f.content.value) {
		f.content.focus();
		return false;
	}
	
	if(!f.rate.value){
		f.rate.val("1");
	}
	
	f.action="<%=cp%>/shop/insertReview";
	return true;
}

</script>

<div class="wide-container">
	<div class="body-title">
		<span style="font-family: Webdings"><i class="far fa-credit-card"></i> 주문 상품 정보</span>  
	</div>
	
	<div>
		<table style="width: 100%; border-spacing: 0px;">
			<tr height="35">
				<td align="left" width="50%">
					<span style="color: #D96262;">${dataCount}</span>개(<span style="color: #D96262;">${page}</span>/${total_page} 페이지)
				</td>
				<td align="right">
					&nbsp;
				</td>
			</tr>
		</table>
	
		<table style="width: 100%; border-spacing: 0px; border-collapse: collapse;">
			<tr align="center" bgcolor="#eaeaea" height="35" style="border-top: 1px solid #d4d4d4; border-bottom: 1px solid #d4d4d4;"> 
				<th width="130" style="color: black;">주문일자<br>[주문번호]</th>
				<th style="color: black; width: 80px;">이미지</th>
				<th width="300" style="color: black;">상품정보</th>
				<th width="70" style="color: black;">수량</th>
				<th width="70" style="color: black;">상품구매금액</th>
				<th width="60" style="color: black;">주문처리상태</th>
				<th width="70" style="color: black;">취소/교환/반품</th>
			</tr>
			
			<c:forEach var="dto" items="${list}">
			<tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;"> 
				<td>${dto.requestDate}<br><a href="<%=cp%>/mypage/requestDetailCheck?&requestNum=${dto.requestNum}" style="color: #f3a34e; font-weight: bold;">${dto.requestNum}</a></td>
				<td align="left" style="padding-left: 10px;">
					<a href="<%=cp%>/shop/article?productNum=${dto.productNum}"><img style="width: 80px; height: 80px;" src="<%=cp%>/uploads/shop/${dto.imageFileName}"></a>
				</td>
				<td>
					<a href="<%=cp%>/shop/article?productNum=${dto.productNum}" style="color: black;">${dto.productName}</a>
				</td>
				<td>${dto.productCount}</td>
				<td><fmt:formatNumber value="${dto.productSum}" type="number"/></td>
				<c:choose>
				<c:when test="${dto.status==0}">
					<td style="color: #f3a34e; font-weight: bold;">입금대기</td>
				</c:when>
				<c:when test="${dto.status==1}">
					<td style="color: #f3a34e; font-weight: bold;">결제완료</td>
				</c:when>
				<c:when test="${dto.status==2}">
					<td style="color: #f3a34e; font-weight: bold;">배송준비중</td>
				</c:when>
				<c:when test="${dto.status==3}">
					<td style="color: #f3a34e; font-weight: bold;">배송중</td>
				</c:when>
				<c:when test="${dto.status==4}">
					<td style="color: #f3a34e; font-weight: bold;">배송완료
						<br><button type="button" class="bts reviewBtn" style="color: white; background-color: #f3a34e" onclick="reviewDialog(${dto.productNum},${dto.requestDetailNum})">후기등록</button> 
					</td>
				</c:when>
				<c:when test="${dto.status==5}">
					<td style="color: #f3a34e; font-weight: bold;">취소완료</td>
				</c:when>
				<c:when test="${dto.status==10}">
					<td style="color: #f3a34e; font-weight: bold;">후기작성완료</td>
				</c:when>
				<c:otherwise>
					<td>-</td>
				</c:otherwise>
				</c:choose>
				<c:choose>
				<c:when test="${dto.status==0}">
					<td>
						<button type="button" class="bts" style="color: white; background-color: #f3a34e" onclick="requestCancle(${dto.requestNum});">주문취소</button> 
					</td>
				</c:when>
				<c:when test="${dto.status==1}">
					<td>
						<button type="button" class="bts" style="color: white; background-color: #f3a34e" onclick="">결제취소</button> 
					</td>
				</c:when>
				<c:when test="${dto.status==4}">
					<td><button type="button" class="bts" style="color: white; background-color: #f3a34e" onclick="requestRefund(${dto.requestNum});">환불신청</button>
						<br><button type="button" class="bts" style="color: white; background-color: #f3a34e" onclick="requestSwap(${dto.requestNum});">교환신청</button>
					</td>
				</c:when>
				<c:when test="${dto.status==6}">
					<td style="color: #f3a34e; font-weight: bold;">환불진행중</td>
				</c:when>
				<c:when test="${dto.status==7}">
					<td style="color: #f3a34e; font-weight: bold;">환불완료</td>
				</c:when>
				<c:when test="${dto.status==8}">
					<td style="color: #f3a34e; font-weight: bold;">교환진행중</td>
				</c:when>
				<c:when test="${dto.status==9}">
					<td style="color: #f3a34e; font-weight: bold;">교환 완료</td>
				</c:when>
				<c:otherwise><td>-</td></c:otherwise>
				</c:choose>
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
	<div id="review_dialog" style="display: none; text-align: center;">
		<form name="reviewForm" method="post" onsubmit="return submitReview(this);">
			<div id="productInfo">
				<div class="productInfo_left" style="float: left;">
					<input type="hidden" name="productNum" value="">
					<input type="hidden" name="requestDetailNum" value="">
					<img alt="" name="productImg" src="" width="75" height="75">
				</div>
				<span class="productInfo_right" style="float: left;margin-left: 15px;line-height: 75px;">
					
				</span>
			</div>
			<div style="clear: both; padding-top: 5px;" >
			<hr>
				<h5>상품은 만족하셨나요?</h5>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<span class="star-input">
						<span class="input">
					    	<input type="radio" name="star_input" value="1" id="p1">
					    	<label for="p1">1</label>
					    	<input type="radio" name="star_input" value="2" id="p2">
					    	<label for="p2">2</label>
					    	<input type="radio" name="star_input" value="3" id="p3">
					    	<label for="p3">3</label>
					    	<input type="radio" name="star_input" value="4" id="p4">
					    	<label for="p4">4</label>
					    	<input type="radio" name="star_input" value="5" id="p5">
					    	<label for="p5">5</label>
					  	</span>
					  	<output for="star-input" ><input type="hidden" name="rate" value="0"></output>						
					</span>	
				<hr>
				<h5>해당 상품에 관한 고객님의 생각은?</h5>
					<textarea class="payTA" name="content"></textarea>
				<hr>
			</div>
			<div class="btn_box">
				<button type="button" class="btnDialogCanecl dialog_cancel">취소</button>
				<button type="submit" class="dialog_submit">확인</button>
			</div>
		</form>
	</div>

</div>