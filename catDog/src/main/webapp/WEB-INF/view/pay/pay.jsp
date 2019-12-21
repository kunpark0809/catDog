<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/dogshop.css">
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
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
			f.action = "<%=cp%>/pay/pay";
			f.submit();
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
				f.action = "<%=cp%>/pay/pay";
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
		var xhr = new XMLHttpRequest();
		//url = "http://openapi.epost.go.kr/postal/retrieveNewAdressAreaCdSearchAllService/retrieveNewAdressAreaCdSearchAllService/getNewAddressListAreaCdSearchAll?ServiceKey=인증키&countPerPage=10&currentPage=1&srchwrd=세종로17"
		var url = 'http://openapi.epost.go.kr/postal/retrieveNewAdressAreaCdSearchAllService/retrieveNewAdressAreaCdSearchAllService/getNewAddressListAreaCdSearchAll'; /*URL*/
		var queryParams = '?' + encodeURIComponent('ServiceKey') + '='+'U4DSQooBi3rQnU3HF9Z6tXH%2FH5nEaR2EjMxq6XjqAkVO1hW3LP%2BvtFJNinrBiXcqCE%2BO%2FMmxDqWizrN3%2BuSZgA%3D%3D'; /*Service Key*/
		queryParams += '&' + encodeURIComponent('srchwrd') + '=' + encodeURIComponent('공평동'); /*검색어*/
		queryParams += '&' + encodeURIComponent('countPerPage') + '=' + encodeURIComponent('10'); /*페이지당 출력될 개수를 지정(최대50)*/
		queryParams += '&' + encodeURIComponent('currentPage') + '=' + encodeURIComponent('1'); /*출력될 페이지 번호*/
		xhr.open('GET', url + queryParams);
		xhr.onreadystatechange = function () {
		    if (this.readyState == 4) {
		        alert('Status: '+this.status+' Headers: '+JSON.stringify(this.getAllResponseHeaders())+' Body: '+this.responseText);
		    }
		};

		xhr.send('');
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
	
	function usePoint(){
		alert("함수");
/* 		var point = $("#usePoint");
		
		if(point.val() < 0){
			point.val("0");
			return;
		}
		
		if(point.val() > ${customer.point}){
			alert("보유금액 이상은 사용불가합니다.");
			point.val(${customer.point});
		}
		alert($("#total").val()-point.val());
		$("#purchase").val($("#total").val()-point.val()); */
	}
</script>


<div>
	<div class="payProduct">
		<table>
			<tr>
				<td colspan="2">상품정보</td>
				<td>판매가</td>
				<td>수량</td>
				<td>배송비</td>
				<td>합계</td>
			</tr>
			<tr>
				<td><img alt="" src="<%=cp%>/uploads/dogshop/${product.imageFileName}" width="50"></td>
				<td>${product.productName}</td>
				<td>${product.productSum}</td>
				<td>${product.productCount}</td>
				<td>2,500</td>
				<td>${product.productSum}</td>
			</tr>
		</table>
	</div>
	<div>
		<form action="" method="post" name="payForm">
			<div class="pay_customer">
				<div class="title">
					<h3>주문 정보</h3>
					<p class="">
						필수입력사항
					</p>
				</div>
				<div class="">
					<table border="1">
						<caption>주문 정보 입력</caption>
						<colgroup>
							<col style="width: 139px;">
							<col style="width: auto;">
						</colgroup>
						<!-- 국내 쇼핑몰 -->
						<tbody class="">
							<tr>
								<th>주문하시는 분 </th>
								<td>
								<input name="name" class="" placeholder="" size="15" value="${customer.name}" type="text">
								</td>
							</tr>
							<tr class="">
								<th>휴대전화 </th>
								<td>
									<select id="" name="tel1">
											<option value="010" ${customer.tel1=="010" ? "selected='selected'" : ""}>010</option>
											<option value="011" ${customer.tel1=="011" ? "selected='selected'" : ""}>011</option>
											<option value="016" ${customer.tel1=="016" ? "selected='selected'" : ""}>016</option>
											<option value="017" ${customer.tel1=="017" ? "selected='selected'" : ""}>017</option>
											<option value="018" ${customer.tel1=="018" ? "selected='selected'" : ""}>018</option>
											<option value="019" ${customer.tel1=="019" ? "selected='selected'" : ""}>019</option>
									</select>
									-<input id="" name="tel2" maxlength="4" size="4" value="${customer.tel2}" type="text">
									-<input id="" name="tel3" maxlength="4" size="4" value="${customer.tel3}" type="text">
								</td>
							</tr>
						</tbody>
						<!-- 해외 쇼핑몰 -->
						<!-- 이메일 국내/해외 -->
						<tbody class="">
							<tr>
								<th>이메일</th>
								<td>
									<input id="" name="email1" class="mailId" value="${customer.email1}" type="text">
									@<input id="" name="email2" class="mailAddress" readonly="readonly" value="${customer.email2}" type="text">
									<select id="" name="selectEmail" onchange="changeEmail();">
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
						</tbody>
						
					</table>
				</div>
			</div>
			
			<div class="pay_deliver">
				<div class="title">
					<h3>배송 정보</h3>
					<p class="">
						필수입력사항
					</p>
				</div>
				<div class="">
					<table border="1">
						<caption>주문 정보 입력</caption>
						<colgroup>
							<col style="width: 139px;">
							<col style="width: auto;">
						</colgroup>
						<!-- 국내 쇼핑몰 -->
						<tbody class="">
							<tr class="">
								<th>배송지 선택</th>
								<td>
									<div class="address">
										<input id="" name="addressType" value="same" type="radio" ${not empty sessionScope.member?"checked='checked'":""}>
										${not empty sessionScope.member?"기본 배송지":"주문자 정보와 동일"}
										
										<input id="" name="addressType" value="direct" type="radio">
										직접 입력
										<a href="#none" id="btn_shipp_addr" class="">
										<span class="">주소록 보기</span></a>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">받으시는 분 </th>
								<td>
								<input name="deliverName" class="" placeholder="" size="15" value="${customer.name}" type="text">
								</td>
							</tr>
							<tr class="">
								<th>주소</th>
								<td>
									<input id="" name="deliverZip" type="text" value="<%-- ${customer.zip} --%>"> 
									<a id="" class="" >
										<span class="" onclick="zipSerach()">우편번호</span>
									</a><br> 
									<input id="" name="deliverAddr1" class="" placeholder="" size="40" value="${customer.addr}" type="text"> 
									<span class="">기본주소</span><br>
									<input id="" name="deliverAddr2" class="" size="40" value="" type="text"> 
									<span class="">나머지주소</span><span class=" ">(선택입력가능)</span>
								</td>
							</tr>
							<tr class="">
								<th>휴대전화 </th>
								<td>
									<select id="" name="deliverTel1">
											<option value="010" ${customer.tel1=="010" ? "selected='selected'" : ""}>010</option>
											<option value="011" ${customer.tel1=="011" ? "selected='selected'" : ""}>011</option>
											<option value="016" ${customer.tel1=="016" ? "selected='selected'" : ""}>016</option>
											<option value="017" ${customer.tel1=="017" ? "selected='selected'" : ""}>017</option>
											<option value="018" ${customer.tel1=="018" ? "selected='selected'" : ""}>018</option>
											<option value="019" ${customer.tel1=="019" ? "selected='selected'" : ""}>019</option>
									</select>
									-<input id="" name="deliverTel2" maxlength="4" size="4" value="${customer.tel2}" type="text">
									-<input id="" name="deliverTel3" maxlength="4" size="4" value="${customer.tel3}" type="text">
								</td>
							</tr>
						</tbody>
						<!-- 배송메시지 -->
						<tbody class="">
							<tr class="">
								<th>배송 메시지</th>
								<td>
									<textarea rows="" cols="" name="memo"></textarea>
								</td>
							</tr>
						</tbody>
					</table>
				</div>

				<div class="">
					<table class="">
						<colgroup>
							<col style="width: 15%;">
							<col style="width: 85%;">
						</colgroup>
						<tbody>
							<tr>
								<th >상품 합계 금액</th>
								<td><strong id="" class=""><input id="total" name="total" readonly="readonly" value="${product.total}"></strong>
								</td>
							</tr>
							<tr>
								<th>배송비</th>
								<td>
									<span id="">2,500</span>원 
								</td>
							</tr>
							<c:if test="${not empty sessionScope.member}">
								<tr>
									<th>적립 포인트</th>
									<td>
								
										<span id=""><input id="" name="point" readonly="readonly" value="${product.point}"></span>원 
								
									</td>
								</tr>
								<tr>
									<th>포인트 사용</th>
									<td>
								
										<span id=""><input id="usePoint" type="text" value="0" name="usePoint" onchange="usePoint();"> </span>원 
										<span id="">(보유 포인트 : ${customer.mileage}원)</span>
								
									</td>
								</tr>
							</c:if>
							<tr>
								<th>최종 결제 금액</th>
								<td>
									<strong id="" class=""><input id="purchase" name="purchase" readonly="readonly" value="${product.total}"></strong>원

								</td>
							</tr>
						</tbody>
					</table>
				</div>

				<div class="title">
						<h3>결제수단</h3>
					</div>

					<div class="">
						<div class="">
							<div class="">
								<span class="">
									<input id="" name="payMethod" value="0" type="radio">
									무통장 입금
								</span> 
								<span class="">
									<input id="" name="payMethod" value="1" type="radio">
									신용카드
								</span> 
							</div>

							<div class="">
								<!-- 무통장입금, 카드결제 -->
								<div id="" class=""
									style="display: block;">
									<p id="" class=""
										style="display: block;">
										최소 결제 가능 금액은 결제금액에서 배송비를 제외한 금액입니다.<br>
									</p>
									<p id="" class="" style="display: none;">소액 결제의 경우 PG사 정책에 따라 결제 금액 제한이 있을 수
										있습니다.</p>
								</div>
							</div>

						<!-- 최종결제금액 -->
						<div class="" style="float: left;">

							<p class="" id="">
								<input id="" name="" value="T" type="checkbox" >
								결제정보를 확인하였으며, 구매진행에 동의합니다.
							
							</p>
							<div class="btn">
								<input type="hidden" name="productNum" value="${product.productNum}">
								<input type="hidden" name="num" value="${sessionScope.member.memberIdx}">  
								<input type="hidden" name="productCount" value="${product.productCount}">
								<input type="hidden" name="productSum" value="${product.productSum}">
								<button type="button" onclick="pay();">결제하기</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>

	
</div>