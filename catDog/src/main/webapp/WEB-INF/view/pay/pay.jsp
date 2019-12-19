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
			buyer_addr : f.address1.value,
			buyer_postcode : f.zip.value,
			m_redirect_url : '<%=cp%>/pay/complete'
		}, function(rsp) {
			if (rsp.success) {
				paySuccess(f);
				
				var msg = '결제가 완료되었습니다.';
				msg += '고유ID : ' + rsp.imp_uid;
				msg += '상점 거래ID : ' + rsp.merchant_uid;
				msg += '결제 금액 : ' + rsp.paid_amount;
				msg += '카드 승인번호 : ' + rsp.apply_num;
			} else {
				var msg = '결제에 실패하였습니다.';
				msg += '에러내용 : ' + rsp.error_msg;
			}
			alert(msg);
		});

	}
	

	function paySuccess(f){
		f.action = "<%=cp%>/pay/pay";
		f.submit();
	}
	function changeEmail() {
	    var f = document.payForm;
		    
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
</script>


<div>
	<div class="payProduct">
		<table>
			<tr>
				<td colspan="2">상품정보</td>
				<td>판매가</td>
				<td>수량</td>
				<td>적립금</td>
				<td>배송비</td>
				<td>합계</td>
			</tr>
			<tr>
				<td><img alt="" src="<%=cp%>/uploads/dogshop/${product.imageFileName}" width="50"></td>
				<td>${product.productName}</td>
				<td>${product.productSum}</td>
				<td>${product.productCount}</td>
				<td>${product.point}</td>
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
								<th scope="row">주문하시는 분 </th>
								<td>
								<input name="name" class="" placeholder="" size="15" value="" type="text">
								</td>
							</tr>
							<tr class="">
								<th>주소</th>
								<td>
									<input id="" name="zip" type="text"> 
									<a id="" class="">
										<span class="">우편번호</span>
									</a><br> 
									<input id="" name="address1" class="" placeholder="" size="40" value="" type="text"> 
									<span class="">기본주소</span><br>
									<input id="" name="address2" class="" size="40" value="" type="text"> 
									<span class="">나머지주소</span><span class=" ">(선택입력가능)</span>
								</td>
							</tr>
							<tr class="">
								<th>휴대전화 </th>
								<td>
									<select id="" name="tel1">
											<option value="010">010</option>
											<option value="011">011</option>
											<option value="016">016</option>
											<option value="017">017</option>
											<option value="018">018</option>
											<option value="019">019</option>
									</select>
									-<input id="" name="tel2" maxlength="4" size="4" value="" type="text">
									-<input id="" name="tel3" maxlength="4" size="4" value="" type="text">
								</td>
							</tr>
						</tbody>
						<!-- 해외 쇼핑몰 -->
						<!-- 이메일 국내/해외 -->
						<tbody class="">
							<tr>
								<th>이메일</th>
								<td>
									<input id="" name="email1" class="mailId" value="" type="text">
									@<input id="" name="email2" class="mailAddress" readonly="readonly" value="" type="text">
									<select id="" name="selectEmail" onchange="changeEmail();">
										<option value="" selected="selected">- 이메일 선택 -</option>
										<option value="naver.com">naver.com</option>
										<option value="daum.net">daum.net</option>
										<option value="nate.com">nate.com</option>
										<option value="hotmail.com">hotmail.com</option>
										<option value="yahoo.com">yahoo.com</option>
										<option value="empas.com">empas.com</option>
										<option value="korea.com">korea.com</option>
										<option value="dreamwiz.com">dreamwiz.com</option>
										<option value="gmail.com">gmail.com</option>
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
								<th scope="row">배송지 선택</th>
								<td>
									<div class="address">
										<input id="" name="" value="T" type="radio">
										
										<label for="sameaddr0">주문자 정보와 동일</label> 
										<input id="" name="" value="F" type="radio">
										
										<label for="sameaddr1">새로운배송지</label> 
										<span class="recent ec-shop-RecentDelivery "> 
											<input id="" name="" value="47229" type="radio">
											최근 배송지 : <label for="recent_delivery_info0"></label>
										</span> 
										<a href="#none" id="btn_shipp_addr" class="">
										<span class="">주소록 보기</span></a>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">받으시는 분 </th>
								<td>
								<input name="deliverName" class="" placeholder="" size="15" value="" type="text">
								</td>
							</tr>
							<tr class="">
								<th>주소</th>
								<td>
									<input id="" name="deliverZip" type="text"> 
									<a id="" class="">
										<span class="">우편번호</span>
									</a><br> 
									<input id="" name="deliverAddr1" class="" placeholder="" size="40" value="" type="text"> 
									<span class="">기본주소</span><br>
									<input id="" name="deliverAddr2" class="" size="40" value="" type="text"> 
									<span class="">나머지주소</span><span class=" ">(선택입력가능)</span>
								</td>
							</tr>
							<tr class="">
								<th>휴대전화 </th>
								<td>
									<select id="" name="deliverTel1">
											<option value="010">010</option>
											<option value="011">011</option>
											<option value="016">016</option>
											<option value="017">017</option>
											<option value="018">018</option>
											<option value="019">019</option>
									</select>
									-<input id="" name="deliverTel2" maxlength="4" size="4" value="" type="text">
									-<input id="" name="deliverTel3" maxlength="4" size="4" value="" type="text">
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
								<td><strong id="" class="">14,900원</strong>
								</td>
							</tr>
							<tr>
								<th>배송비</th>
								<td>
									<span id="">0</span>원 
								</td>
							</tr>
							<tr>
								<th scope="row">적립 포인트</th>
								<td>
							
									<span id="">0</span>원 
							
								</td>
							</tr>
							<tr>
								<th scope="row">최종 결제 금액</th>
								<td>
									<strong id="" class="">14,900</strong>원

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
									<input id="" name="" value="card" type="radio">
									<label for="addr_paymethod1">
										<img src="//img.echosting.cafe24.com/design/skin/admin/ko_KR/ico_card_disabled.gif">
									</label>
								</span> 
							</div>

							<div class="">
								<!-- 무통장입금, 카드결제, 휴대폰결제, 실시간계좌이체 -->
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
								<button type="button" onclick="pay();">결제하기</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>

	
</div>