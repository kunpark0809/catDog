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


<div>
	<div class="order_table_type">
                    <table class="table_left">
                        <colgroup>
                            <col style="width:15%;">
                            <col style="width:85%;">
                        </colgroup>
                        <tbody>
                        <tr>
                            <th>결제수단</th>
                            <td><div class="pay_with_list">
                                <strong>무통장 입금</strong>
                                <ul>
                                    <li>입금은행 : 농협</li>
                                    <li>입금계좌 : 355-0033-7027-63</li>
                                    <li>예금주명 : 주식회사 이에쓰씨컴퍼니</li>
                                    <li>입금금액 : <strong class="deposit_money">26,480원</strong></li>
                                    <li>입금자명 : 신승연</li>
                                </ul>
                            </div>
                            </td>
                        </tr>
                        <tr>
                            <th>주문번호</th>
                            <td>${list.get(0).requestNum}</td>
                        </tr>
                        <tr>
                            <th>주문일자</th>
                            <td>${list.get(0).requestDate}</td>
                        </tr>
                        <tr>
                            <th>주문자명</th>
                            <td>신승연</td>
                        </tr>
                        <tr>
                            <th>배송정보</th>
                            <td>
                                <p>
                                    <strong>신승연</strong> <br>
                                    [08056] 서울특별시 양천구 신정로7길 17 (양천공영차고지) 111<br>
                                      /    /  010-9911-0488<br>
                                    남기실 말씀 : 
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <th>상품 금액</th>
                            <td><strong class="order_payment_sum">26,480원</strong>
                                <span class="add_currency"></span>
                            </td>
                        </tr>
                        <tr>
                            <th>배송비</th>
                            <td>기본배송 0원
                                <span class="add_currency"></span>
                            </td>
                        </tr>
                        <tr>
                            <th>할인 및 적립</th>
                            <td>
                                <ul class="order_benefit_list">
                                    <li class="order_benefit_sale">
                                        <em>할인 : <strong>(-) 0원</strong>
                                            <span>(
                                            상품 0원
                                            , 회원 0원
                                            , 배송비 0원
                                            , 상품쿠폰 0원
                                            , 주문쿠폰 0원
                                            , 배송비쿠폰 0원
                                            )</span>
                                        </em>
                                    </li>
                                    <li class="order_benefit_mileage">
                                        <em> 적립 포인트 : <strong>(+) 528원</strong>
                                            <span>(
상품 264원, 회원 264원                                            )</span>
                                        </em>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <th>총 결제금액</th>
                            <td><strong class="order_payment_sum">26,480원</strong>
                                <span class="add_currency"></span>
                            </td>
                        </tr>
                        <tr>
                            <th>현금영수증</th>
                            <td>
                                미발급
                            </td>
                        </tr>
                        <tr>
                            <th>세금계산서</th>
                            <td>
                                미발급
                            </td>
                        </tr>
                    </tbody></table>
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