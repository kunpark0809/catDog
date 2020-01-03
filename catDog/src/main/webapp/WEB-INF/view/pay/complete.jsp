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
	
</script>


<div class="shin_body">
	<div class="order_table_type">
	<div class="complete">
		<p>주문번호 : <strong>${list.get(0).requestNum}</strong></p>
		<p>주문일자 : ${list.get(0).requestDate}</p>
	</div>
		<div class="payProduct">
			<h3>주문 상품 정보</h3>
				<table>
					<tr>
						<td colspan="2">상품정보</td>
						<td>판매가</td>
						<td>수량</td>
						<td>배송비</td>
						<td>합계</td>
					</tr>
				<c:forEach var="dto" items="${list}">
					<tr>
						
						<td>
						<input type="hidden" name="requestDetailNum" value="${dto.requestDetailNum}">
						<img alt="" src="<%=cp%>/uploads/dogshop/${dto.imageFileName}" width="50">
						</td>
						<td>${dto.productName}</td>
						<td>${dto.productSum}</td>
						<td>${dto.productCount}</td>
						<td>기본배송</td>
						<td>${dto.productSum}</td>
					</tr>
				</c:forEach>
				</table>
			</div>
			<div class="payment">
				<h3>결제 정보</h3>
                    <table>
                        <tr>
                            <th>결제수단</th>
                            <td><div class="pay_with_list">
                                <strong>
                                	<c:choose>
                                		<c:when test="${list.get(0).payMethod==0}">무통장 입금</c:when>
                                		<c:when test="${list.get(0).payMethod==1}">신용카드</c:when>
                                		<c:when test="${list.get(0).payMethod==2}">계좌이체</c:when>
                                		<c:otherwise>핸드폰 결제</c:otherwise>
                                	</c:choose>
                                </strong>
                                <c:if test="${list.get(0).payMethod==0}">
	                                <ul>
	                                    <li>입금은행 : 국민은행</li>
	                                    <li>입금계좌 : 000000-00-000000</li>
	                                    <li>예금주명 : 주식회사 멍냥개냥</li>
	                                    <li>입금금액 : <strong class="deposit_money">${list.get(0).purchase}원</strong></li>
	                                    <li>입금자명 : ${list.get(0).name}</li>
	                                </ul>
                                </c:if>
                            </div>
                            </td>
                        </tr>
                      </table>
                </div>  
                <div class="deliver">
                	<h3>배송지 정보</h3>
                <table>        
                        <tr>
                            <th>배송정보</th>
	                            <td>
	                                 <strong>${list.get(0).deliverName}</strong> <br>
	                            </td>
                        	</tr>
                        	<tr>
                        		<th>주소</th>
                        		<td>
                        			[${list.get(0).deliverZip}] ${list.get(0).deliverAddr1} ${list.get(0).deliverAddr2}
                        		</td>
                        	</tr>
                        	<tr>
                        		<th>전화번호</th>
                        		<td>${list.get(0).deliverTel}</td>
                        	</tr>
                        	<tr>
                        		<th>남기실 말씀</th>
                        		<td>${list.get(0).memo}</td>
                        	</tr>
                        <tr>
                            <th>상품 금액</th>
                            <td><strong class="order_payment_sum">${list.get(0).total}</strong>
                                <span class="add_currency"></span>
                            </td>
                        </tr>
                        <tr>
                            <th>배송비</th>
                            <td>2,500원
                                <span class="add_currency"></span>
                            </td>
                        </tr>
                        <tr>
                            <th>적립 예정 포인트</th>
                            <td>
                            	${list.get(0).point}원
                            </td>
                        </tr>
                        <tr>
                            <th>총 결제금액</th>
                            <td><strong class="order_payment_sum">${list.get(0).purchase}</strong>
                                <span class="add_currency"></span>
                            </td>
                        </tr>
                     </table>
                     </div>
                </div>
	<div class="ec-base-help">
		<h3>이용안내</h3>
		<div class="inner">
			<ol>
				<li class="item1">비회원 주문의 경우, 주문번호를 꼭 기억하세요. 주문번호로 주문조회가 가능합니다.</li>
				<li class="item2">배송은 결제완료 후 지역에 따라 2일 ~ 7일 가량이 소요됩니다.</li>
				<li class="item3">상품별 자세한 배송과정은 주문조회를 통하여 조회하실 수 있습니다.</li>
				<li class="item4">주문의 취소 및 환불, 교환에 관한 사항은 이용안내의 내용을 참고하십시오.</li>
			</ol>
			<h4>세금계산서 발행 안내</h4>
			<ol>
				<li class="item1">부가가치세법 제 54조에 의거하여 세금계산서는 배송완료일로부터 다음달 10일까지만
					요청하실 수 있습니다.</li>
				<li class="item2">세금계산서는 사업자만 신청하실 수 있습니다.</li>
				<li class="item3">배송이 완료된 주문에 한하여 세금계산서 발행신청이 가능합니다.</li>
				<li class="item4">[세금계산서 신청]버튼을 눌러 세금계산서 신청양식을 작성한 후 팩스로
					사업자등록증사본을 보내셔야 세금계산서 발생이 가능합니다.</li>
				<li class="item5">[세금계산서 인쇄]버튼을 누르면 발행된 세금계산서를 인쇄하실 수 있습니다.</li>
			</ol>
			<h4>부가가치세법 변경에 따른 신용카드매출전표 및 세금계산서 변경안내</h4>
			<ol>
				<li class="item1">변경된 부가가치세법에 의거, 2004.7.1 이후 신용카드로 결제하신 주문에
					대해서는 세금계산서 발행이 불가하며</li>
				<li class="item2">신용카드매출전표로 부가가치세 신고를 하셔야 합니다.(부가가치세법 시행령 57조)</li>
				<li class="item3">상기 부가가치세법 변경내용에 따라 신용카드 이외의 결제건에 대해서만 세금계산서
					발행이 가능함을 양지하여 주시기 바랍니다.</li>
			</ol>
			<h4>현금영수증 이용안내</h4>
			<ol>
				<li class="item1">현금영수증은 1원 이상의 현금성거래(무통장입금, 실시간계좌이체, 에스크로,
					예치금)에 대해 발행이 됩니다.</li>
				<li class="item2">현금영수증 발행 금액에는 배송비는 포함되고, 적립금사용액은 포함되지 않습니다.</li>
				<li class="item3">발행신청 기간제한 현금영수증은 입금확인일로 부터 48시간안에 발행을 해야 합니다.</li>
				<li class="item4">현금영수증 발행 취소의 경우는 시간 제한이 없습니다. (국세청의 정책에 따라 변경
					될 수 있습니다.)</li>
				<li class="item5">현금영수증이나 세금계산서 중 하나만 발행 가능 합니다.</li>
			</ol>
		</div>
	</div>
</div>