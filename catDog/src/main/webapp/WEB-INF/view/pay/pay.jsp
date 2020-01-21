<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
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
    text-align: left;
}
.ui-dialog .ui-dialog-titlebar {
    padding-left: 0px;
}

.ui-dialog-title {
    padding-left: 10px;
    font-size: 14pt;
}
.ui-dialog{
	padding: 5px 20px;
	border-radius: 0px;
	position: fixed;
	font-size: 10pt;
}
</style>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	<script type="text/javascript" src="<%=cp%>/resource/vendor/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript">
	var IMP = window.IMP; // 생략가능
	IMP.init('imp14710810'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용

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
	
	function pay() {
		var f= document.payForm;

		if(f.payMethod.value == "0"){
			f.action = "<%=cp%>/pay/${mode}/pay";
			f.submit();
			return;
		}
		
		
		if(f.checkAgree.value!=1){
			alert("상기 내용 확인 후 동의해주셔야 결제진행이 가능합니다.");
			return;
		}
		
		var email = f.email1.value+"@"+f.email2.value;
		var tel = f.tel1.value+"-"+f.tel2.value+"-"+f.tel3.value;
		
	
		IMP.request_pay({
			pg : 'inicis', // version 1.1.0부터 지원.
			pay_method : 'card',
			merchant_uid : 'merchant_' + new Date().getTime(),
			name : '주문명:결제테스트',
			amount : 10,
			buyer_email : email,
			buyer_name : f.name.value,
			buyer_tel : tel,
			buyer_addr : f.deliverAddr1.value,
			buyer_postcode : f.deliverZip.value,
			m_redirect_url : '<%=cp%>/pay/complete'
		}, function(rsp) {
			if (rsp.success) {
				f.action = "<%=cp%>/pay/${mode}/pay";
				f.submit();
				
				var msg = '결제가 완료되었습니다.';
				msg += '고유ID : ' + rsp.imp_uid;
				msg += '상점 거래ID : ' + rsp.merchant_uid;
				msg += '결제 금액 : ' + rsp.paid_amount;
				msg += '카드 승인번호 : ' + rsp.apply_num;
			} else {
				var msg = '결제에 실패하였습니다.';
				msg += '에러내용 : ' + rsp.error_msg;
			}
			//alert(msg);
		});

	}
	
	// xml 파싱하는법 공부
	function zipSerach(){
		var url = "<%=cp%>/pay/zip";
		var query = "srchwrd="+srchwrd;
		
		var fn = function(data){
			console.log(data);
		}
		
		ajaxJSON(url, "get", query, fn);
		
		
	}
	

	function changeEmail() {
		var f= document.payForm;
		    
	    var str = f.selectEmail.value;
	    if(str!="etc") {
	        f.email2.value=str; 
	        f.email2.readOnly = true;
	        f.email1.focus(); 
	    }
	    else {
	        f.email2.value="";
	        f.email2.readOnly = false;
	        f.email1.focus();
	    }
	}
	
	
	function changePoint(){
 		var point = $("#usePoint");
		var total = ${mode=='cart'? cartList.get(0).total:product.total}+2500;
		
		if(point.val() < 0){
			point.val("0");
			return;
		}
		
		if(point.val() > ${customer.mileage}){
			alert("보유금액 이상은 사용불가합니다.");
			point.val(${customer.mileage});
		}
		
		if(point.val() > total){
			alert(point.val()+"결제금액을 초과하는 포인트 입니다.");
			point.val(total);
		}
		
		$("input[name=purchase]").val(total-point.val());
		$("#purchase").text((total-point.val()).toLocaleString()+"원" ); 
		
	}
	
	$(function(){
		$("#btnZip").click(function(){
			$('#zip_dialog').dialog({
				  modal: true,
				  height: 530,
				  width: 700,
				  title: '우편번호 검색',
				  close: function(event, ui) {
				  },
					open: function(event, ui) {
						$(".ui-dialog-titlebar-close", $(this).parent()).hide();
					}
			
			});
		});
	});
	
	$(function(){
		
		$(".btnDialogCanecl").click(function(){
 			$("#zip_dialog").find("input").val("");
 			$(".post-search-tip").show();
 			$(".search-empty").hide();	
 			$("#search-result").hide();	
 			$("#paging").hide();
			$('#zip_dialog').dialog("close");
		});
	});
	
	$(function(){
		$("input[name=payMethod]").click(function(){
			if($(this).val()==0){
				$("#bankBox").show();
			} else{
				$("#bankBox").hide();
			}
		})
	});
	
	function zipCode(page){
		var url = "<%=cp%>/pay/zipCode";
		var query = "page="+page+"&searchKeyword="+$("input[name=search-keyword]").val();

		$.ajax({
			type:"get"
			,url:url
			,data:query
			,dataType:"xml"
			,success:function(data){
				printXML(data);
			}
		});
	}
	$(function(){
 		$(document).on("click","#zipCodeTable tr",function(){
 			
 			var $td = $(this).children();
 			var addr = $td.eq(1).text();
 			var zipCode = $td.eq(2).text();
 			
 			
 			$("input[name=deliverAddr1]").val(addr);
 			$("input[name=deliverZip]").val(zipCode);
 			
 			$("#zip_dialog").find("input").val("");
 			$(".post-search-tip").show();
 			$(".search-empty").hide();		
 			$("#search-result").hide();	
 			$("#paging").hide();
 			
 			$('#zip_dialog').dialog("close");
 		});
 	});
 	function printXML(data) {
		var out="";
		$(".post-search-tip").hide();
		$(".search-empty").hide();
		$("#search-result").hide();	
		
		var header=$(data).find("cmmMsgHeader");
		var totalCount = header.find("totalCount").text();
		
		if(totalCount == ""){
			$(".search-empty").show();
 			$("#search-result").hide();	
 			$("#paging").hide();
			return;
		}
		

 		var url = "<%=cp%>/pay/zipCodePaging";
		var query = "total="+header.find("totalPage").text()+"&page="+header.find("currentPage").text();;

		$.ajax({
			type:"get"
			,url:url
			,data:query
			,success:function(data) {
				$("#paging").html(data);
			}
			,beforeSend:function(jqXHR) {
		        jqXHR.setRequestHeader("AJAX", true);
		    }
		    ,error:function(jqXHR) {
		    	console.log(jqXHR.responseText);
		    }
		}); 
		
		out += "<table id='zipCodeTable' style='width: 100%;'>";
		$(data).find("newAddressListAreaCdSearchAll").each(function(){
			var record = $(this);
			out +="<tr style='border-top: 1px solid #e4e4e4;'><td style='padding: 5px 0px;'>";
			out += "<span  style='display: inline-block;padding: 2px 8px;background: #f3a34e;color: #FFFFFF;width: 40px;text-align: center;''>도로명</span>";
			out +="</td><td style='padding-left: 10px;' class='zipCode_addr'>"
			out += record.find("lnmAdres").text();
			out += "</td><td style='width: 60px;'>";
			out += record.find("zipNo").text();
			out += "</td></tr>";
			out += "<tr><td style='padding: 5px 0px;'>";
			out += "<span  style='display: inline-block;padding: 2px 8px;background: #f3a34e;color: #FFFFFF;width: 40px;text-align: center;'>지번</span>";
			out += "</td><td style='padding-left: 10px;' class='zipCode_addr'>"+record.find("rnAdres").text();
			out += "</td><td  style='display:none;'>";
			out += record.find("zipNo").text();
			out +="</td></tr>";
		});
		
		out+="</table>";
		$("#search-result").html(out);
		$("#search-result").show();	
		$("#paging").show();
	} 
 	
 	
</script>


<div class="container-board">
		<div class="order_tit" style="width: 100%;height: 60px;margin-bottom: 10px; line-height: 60px;">
        <div class="body-title" style="display: inline-block;"><i class="far fa-credit-card"></i>&nbsp;주문서작성/결제</div>
        <div class="pay-seq" style="float: right; font-size: 14pt;">
        <ul>
            <li class="page-off">01&nbsp;&nbsp;장바구니&nbsp;&nbsp;&nbsp;>&nbsp;&nbsp;&nbsp; </li>
            <li class="page-on">02&nbsp;&nbsp;주문서작성/결제&nbsp;&nbsp;&nbsp;>&nbsp;&nbsp;&nbsp;</li>
            <li class="page-off">03&nbsp;&nbsp;주문완료</li>
        </ul>
        </div>
    	</div>

		<form method="post" name="payForm">
			<div class="payProduct" style="margin-bottom: 50px;">
				<table style="text-align: center;">
					<tr style="color: black;background-color: #eaeaea;">
						<td>이미지</td>
						<td style="padding: 5px 0px;">상품정보</td>
						<td>판매가</td>
						<td>수량</td>
						<td>배송비</td>
						<td >합계</td>
					</tr>
					<c:if test="${mode=='direct'}">
						<tr style="border-bottom: 1px solid #cccccc;">
							<td><img alt=""
									src="<%=cp%>/uploads/shop/${product.imageFileName}"
									width="75" height="75"></td>
							<td  style="padding: 5px 0px;">
								<input type="hidden" name="productNum" value="${product.productNum}">
								
								${product.productName}
							</td>
							<td><fmt:formatNumber value="${product.productSum}" type="number"/></td>
							<td><input type="hidden" name="productCount" value="${product.productCount}">${product.productCount}</td>
							<td>기본배송</td>
							<td><input type="hidden" name="productSum" value="${product.productSum}"><fmt:formatNumber value="${product.productSum}" type="number"/></td>
						</tr>
					</c:if>

					<c:if test="${mode=='cart'}">
						<c:forEach var="dto" items="${cartList}">
							<tr style="border-bottom: 1px solid #cccccc;">
								<td>
								<input type="hidden" name="payCartNum" value="${dto.cartNum}">
								<img alt="" src="<%=cp%>/uploads/shop/${dto.imageFileName}" width="50"></td>
								<td>${dto.productName}</td>
								<td><fmt:formatNumber value="${dto.productSum}" type="number"/></td>
								<td>${dto.productCount}</td>
								<td>기본배송</td>
								<td><fmt:formatNumber value="${dto.productSum}" type="number"/></td>
							</tr>
						</c:forEach>
					</c:if>
				</table>
				<p onclick="javascript:location.href='<%=cp%>/pay/cart'" style="margin: 5px 0px;border-bottom: 1px solid black;width: max-content;font-size: 11pt; cursor: pointer;">&lt;&nbsp;장바구니 가기</p>
			</div>
			<div class="pay_customer" style="margin-bottom: 50px;">
				<div class="title">
					<h3>주문 정보</h3>
				</div>
				<div class="payTable">
					<table>
						<!-- 국내 쇼핑몰 -->
							<tr style="	border-bottom: 1px solid #d4d4d4;">
								<td class="payTdTit">주문하시는 분 </td>
								<td class="payTdCon">
								<input name="name" class="payInput" placeholder="" size="15" value="${customer.name}" type="text">
								</td>
							</tr>
							<tr style="	border-bottom: 1px solid #d4d4d4;">
								<td class="payTdTit">휴대전화 </td>
								<td class="payTdCon">
									<select name="tel1" class="payInput" >
											<option value="010" ${customer.tel1=="010" ? "selected='selected'" : ""}>010</option>
											<option value="011" ${customer.tel1=="011" ? "selected='selected'" : ""}>011</option>
											<option value="016" ${customer.tel1=="016" ? "selected='selected'" : ""}>016</option>
											<option value="017" ${customer.tel1=="017" ? "selected='selected'" : ""}>017</option>
											<option value="018" ${customer.tel1=="018" ? "selected='selected'" : ""}>018</option>
											<option value="019" ${customer.tel1=="019" ? "selected='selected'" : ""}>019</option>
									</select>
									-<input class="payInput" name="tel2" maxlength="4" size="4" value="${customer.tel2}" type="text">
									-<input class="payInput" name="tel3" maxlength="4" size="4" value="${customer.tel3}" type="text">
								</td>
							</tr>
						<!-- 해외 쇼핑몰 -->
						<!-- 이메일 국내/해외 -->
							<tr style="	border-bottom: 1px solid #d4d4d4;">
								<td class="payTdTit">이메일</td>
								<td class="payTdCon">
									<input class="payInput" name="email1" class="mailId" value="${customer.email1}" type="text">
									@<input class="payInput" name="email2" class="mailAddress" readonly="readonly" value="${customer.email2}" type="text">
									<select name="selectEmail" onchange="changeEmail();" class="payInput">
										<option value="" selected="selected">- 이메일 선택 -</option>
										<option value="naver.com" ${customer.email2=="naver.com" ? "selected='selected'" : ""}>naver.com</option>
										<option value="daum.net" ${customer.email2=="daum.net" ? "selected='selected'" : ""}>daum.net</option>
										<option value="nate.com" ${customer.email2=="nate.com" ? "selected='selected'" : ""}>nate.com</option>
										<option value="hanmail.net" ${customer.email2=="hanmail.net" ? "selected='selected'" : ""}>hotmail.com</option>
										<option value="hotmail.com" ${customer.email2=="hotmail.com" ? "selected='selected'" : ""}>yahoo.com</option>
										<option value="icloud.com" ${customer.email2=="icloud.com" ? "selected='selected'" : ""}>dreamwiz.com</option>
										<option value="gmail.com" ${customer.email2=="gmail.com" ? "selected='selected'" : ""}>gmail.com</option>
										<option value="etc">직접입력</option>
								</select>
									<ul class="gBlank5 txtInfo">
										<li>- 이메일을 통해 주문처리과정을 보내드립니다.</li>
										<li>- 이메일 주소란에는 반드시 수신가능한 이메일주소를 입력해 주세요</li>
									</ul></td>
							</tr>
						
					</table>
				</div>
			</div>
			
			<div class="pay_deliver" >
				<div class="title">
					<h3>배송 정보</h3>
				</div>
				<div class="payTable" style="margin-bottom: 50px;">
					<table>
						<!-- 국내 쇼핑몰 -->
							
							<tr style="	border-bottom: 1px solid #d4d4d4;">
								<td class="payTdTit">받으시는 분 </td>
								<td class="payTdCon">
								<input name="deliverName" class="payInput" placeholder="" size="15" value="${customer.name}" type="text">
								</td>
							</tr>
							<tr style="	border-bottom: 1px solid #d4d4d4;">
								<td class="payTdTit">주소</td>
								<td class="payTdCon">
									<input class="payInput" name="deliverZip" type="text" value="${customer.zip}" readonly="readonly"> 
										<button type="button" id="btnZip" data-toggle="modal" style="background:white; color:black; width: 100px;height: 35px; font-size: 11pt; border: 1px solid #d4d4d4; ">우편번호검색</button>
									<br> 
									<input name="deliverAddr1" class="payInput" style="width:500px; margin-top: 5px;" placeholder="" size="40" value="${customer.addr1}" type="text" readonly="readonly"> 
									<input name="deliverAddr2" class="payInput" size="40" value="${customer.addr2}" type="text"> 
								</td>
							</tr>
							<tr style="	border-bottom: 1px solid #d4d4d4;">
								<td class="payTdTit">휴대전화 </td>
								<td class="payTdCon">
									<select name="deliverTel1" class="payInput">
											<option value="010" ${customer.tel1=="010" ? "selected='selected'" : ""}>010</option>
											<option value="011" ${customer.tel1=="011" ? "selected='selected'" : ""}>011</option>
											<option value="016" ${customer.tel1=="016" ? "selected='selected'" : ""}>016</option>
											<option value="017" ${customer.tel1=="017" ? "selected='selected'" : ""}>017</option>
											<option value="018" ${customer.tel1=="018" ? "selected='selected'" : ""}>018</option>
											<option value="019" ${customer.tel1=="019" ? "selected='selected'" : ""}>019</option>
									</select>
									-<input class="payInput" name="deliverTel2" maxlength="4" size="4" value="${customer.tel2}" type="text">
									-<input class="payInput" name="deliverTel3" maxlength="4" size="4" value="${customer.tel3}" type="text">
								</td>
							</tr>
						<!-- 배송메시지 -->
							<tr style="	border-bottom: 1px solid #d4d4d4;">
								<td class="payTdTit">배송 메시지</td>
								<td class="payTdCon">
									<textarea  class="payTA" name="memo"></textarea>
								</td>
							</tr>
					</table>
				</div>

				<div class="payTable" style="margin-bottom: 50px;">
					<div class="title">
						<h3>결제정보</h3>
					</div>
					<table>
							<tr style="	border-bottom: 1px solid #d4d4d4;">
								<td class="payTdTit"> 상품 합계 금액</td>
								<td class="payTdCon">
								<input class="readInput" type="hidden" name="total" value="${mode=='cart'? cartList.get(0).total:product.total}">
								<strong id="total" class="">
								<fmt:formatNumber value="${mode=='cart'? cartList.get(0).total:product.total}" type="number"/>원
								</strong>
								</td>
							</tr>
							<tr style="	border-bottom: 1px solid #d4d4d4;">
								<td class="payTdTit">배송비</td>
								<td class="payTdCon">
									<span id="deliver">2,500</span>원 
								</td>
							</tr>
							<c:if test="${not empty sessionScope.member}">
								<tr style="	border-bottom: 1px solid #d4d4d4;">
									<td class="payTdTit">적립 포인트</td>
									<td class="payTdCon">
										<input name="point" type="hidden" class="readInput" value="${mode=='cart'? cartList.get(0).point:product.point}">
										<span id="point">
											${mode=='cart'? cartList.get(0).point:product.point}&nbsp;포인트
										</span> 
								
									</td>
								</tr>
								<tr style="	border-bottom: 1px solid #d4d4d4;">
									<td class="payTdTit">포인트 사용</td>
									<td class="payTdCon">
								
										<span><input id="usePoint" class="payInput" type="text" value="0" name="usePoint" onchange="changePoint();"> </span>
										<span>(보유 포인트 : ${customer.mileage}&nbsp;포인트)</span>
								
									</td>
								</tr>
							</c:if>
							<tr style="	border-bottom: 1px solid #d4d4d4;">
								<td class="payTdTit">최종 결제 금액</td>
								<td class="payTdCon">
									<input name="purchase" class="readInput" type="hidden" value="${mode=='cart'? (cartList.get(0).total+2500):(product.total+2500)}">
									<strong>
									<span id="purchase"><fmt:formatNumber value="${mode=='cart'? (cartList.get(0).total+2500):(product.total+2500)}" type="number"/>원</span>
									</strong>

								</td>
							</tr>
					</table>
				</div>


							<div class="" style="margin-bottom: 50px;">
								<div class="title" style="border-bottom: 2px solid #d4d4d4;">
									<h3>결제수단</h3>
								</div>
							<div style="padding: 10px 0px;">
								<span class="">
									<input name="payMethod" value="0" type="radio">
									무통장 입금
								</span> 
								<span class="">
									<input name="payMethod" value="1" type="radio">
									신용카드
								</span> 
								<span class="">
									<input name="payMethod" value="2" type="radio">
									계좌이체
								</span> 
								<span class="">
									<input name="payMethod" value="3" type="radio">
									휴대폰결제
								</span>
							<div id="bankBox" class="pay_bankbook_box" style="display: none;">
						<p style="color: #949494; border-bottom: 1px solid #d4d4d4; padding-bottom: 10px;">※ 무통장 입금 의 경우 입금확인 후부터 배송단계가 진행됩니다.</p>
						<table style="width: 100%">
									<tr style="padding: 10px 0px; 	border-bottom: 1px solid #d4d4d4;" >
	
										<td class="payTdTit">입금자명</td>
										<td class="payTdCon"><input type="text" name="bankSender" class="payInput"
											readonly="readonly" value="${sessionScope.member.name}"></td>
									</tr>
									<tr style="padding: 10px 0px; 	border-bottom: 1px solid #d4d4d4;">
										<td class="payTdTit">입금은행</td>
										<td class="payTdCon"><select name="bankAccount" class="payInput" style="width:350px;">
												<option value="">선택하세요</option>
												<option value="1">국민은행 000000-00-000000 주식회사 멍냥개냥</option>
										</select></td>
									</tr>
								</table>
							</div>
							</div>
					</div>

						

						<!-- 최종결제금액 -->
						<div class="" style="text-align: center;">

							<p class="" style="margin-bottom: 50px;">
								<input id="" name="checkAgree" value="1" type="checkbox" >
								<b>(필수)</b>&nbsp;결제정보를 확인하였으며, 구매진행에 동의합니다.
							
							</p>
							<div class="btn">
								<input type="hidden" name="mileage" value="${customer.mileage}">
								<button type="button" onclick="pay();" class="pinkBtn" style="width: 250px;font-size: 15pt;">결제하기</button>
							</div>
						</div>
			</div>
		</form>

	<div id="zip_dialog" style="display: none; text-align: center;">
		<div class="">
			<input type="text" class="payInput" name="search-keyword" placeholder="검색어(도로명,지번,건물명)를 입력해주세요" style=" width: 80%;">
			<button type="button" onclick="zipCode(1);" class="smallPinkBtn" style="width: 15%; height:36px;">검색</button>
		</div>

		<div class="post-search-tip" style="display: black; text-align: left; margin: 10px 0px 0px 15px;">
			<span class="post-search-tip-title">tip</span><br> 아래와같이 검색하면 더욱
			정확한 결과가 검색됩니다.<br>
			<br>
			<div>도로명 + 건물번호</div>
			<div class="post-search-tip-ex">예) 영동대로 513, 제주 첨단로 242</div>
			<div>지역명(동/리) + 번지</div>
			<div class="post-search-tip-ex">예) 삼성동 25, 제주 영평동 2181</div>
			<div>지역명(동/리) + 건물명(아파트명)</div>
			<div class="post-search-tip-ex">예) 분당 주공, 삼성동 코엑스</div>
		</div>


		<div class="search-empty" style="display: none; text-align: left; margin: 10px 0px 0px 15px;">
			<span><b>검색결과가 없습니다.</b></span><br>
			<br> <span>검색어에 잘못된 철자가 없는지, 정확한 주소인지 다시 한번 확인해 주세요.</span>
			<span class="post-search-tip-title">Tip</span><br>
			 <span>지번주소(동/읍/면), 도로명, 건물명(아파트)을 확인해주세요.</span><br> <span>일부
				신축건물, 신도시의 경우 일시적으로 검색이 되지 않을 수 있습니다.</span><br> <span>도로명 주소를
				모르실 경우 www.juso.go.kr 에서 확인 가능합니다.</span><br> <span>동명으로 검색시
				법정동명으로 검색하셔야 합니다.</span><br> <span>(행정동명으로는 검색이 되지 않습니다.)</span><br>
		</div>

		<div id="search-result" style="display: none; width: 95%; overflow-y:auto; overflow-x:hidden;height:300px; margin: 10px auto;" >
		

		</div>
			<div id="paging">
			</div>
		<div class="dialog_btn_box" style="text-align: center;" >
			<button type="button" class="btnDialogCanecl dialog_cancel">닫기</button>
		</div>
	</div>




</div>
		

