<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String cp = request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/dogshop.css">
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript">
	
</script>


<div class="container-board">
	<div class="order_tit" style="width: 100%;height: 60px;margin-bottom: 10px; line-height: 60px;">
        <div class="body-title" style="display: inline-block;"><i class="fas fa-clipboard-list"></i>&nbsp;주문완료</div>
        <div class="pay-seq" style="float: right; font-size: 14pt;">
        <ul>
            <li class="page-off">01&nbsp;&nbsp;장바구니&nbsp;&nbsp;&nbsp;>&nbsp;&nbsp;&nbsp; </li>
            <li class="page-off">02&nbsp;&nbsp;주문서작성/결제&nbsp;&nbsp;&nbsp;>&nbsp;&nbsp;&nbsp;</li>
            <li class="page-on">03&nbsp;&nbsp;주문완료</li>
        </ul>
        </div>
    </div>	
    <div class="complete" style=" border-top: 2px solid #d4d4d4; text-align: center; padding-top:50px; margin-bottom: 50px;">
				<img alt="complete" src="<%=cp%>/resource/img/complete.png"
					width="100" height="100" style="margin-bottom: 10px; "/>
			<p style="margin-bottom: 5px;">
				<b style="font-size: 18pt; ">고객님의 주문이 완료되었습니다.</b>
			</p>
			<p style="font-size: 11pt; ">
				주문 내역 및 배송에 관한 안내는 <a
					style="color: #d96363; text-decoration: underline;"
					href="<%=cp%>/mypage/requestDetailCheck?requestNum=${list.get(0).requestNum}">주문조회</a>&nbsp;를
				통하여 확인 가능 합니다.
			</p>
	</div>


		<div class="payProduct" style="clear: both; margin-bottom: 50px;">
			<h3>주문 상품 정보</h3>
				<table style="text-align: center; border-top: 1.5px solid #b7b7b7;">
					<tr style="color: black;background-color: #eaeaea;">
						<td>이미지</td>
						<td  style="padding: 5px 0px;">상품정보</td>
						<td>판매가</td>
						<td>수량</td>
						<td>배송비</td>
						<td>합계</td>
					</tr>
				<c:forEach var="dto" items="${list}">
					<tr style="border-bottom: 1px solid #cccccc;">
						<td><img alt="" src="<%=cp%>/uploads/shop/${dto.imageFileName}" width="75" height="75" ></td>
						<td style="padding: 5px 0px;">
							<input type="hidden" name="requestDetailNum" value="${dto.requestDetailNum}">
							
							${dto.productName}
						</td>
						<td><fmt:formatNumber value="${dto.productSum}" type="number"/></td>
						<td>${dto.productCount}</td>
						<td>기본배송</td>
						<td><fmt:formatNumber value="${dto.productSum}" type="number"/></td>
					</tr>
				</c:forEach>
				</table>
			</div>
			<div class="payTable" style="margin-bottom: 50px;">
				<h3>결제 정보</h3>
                    <table>
                        <tr style="	border-bottom: 1px solid #d4d4d4;">
                            <td class="payTdTit">결제수단</td>
                            <td class="payTdCon"><div class="pay_with_list">
                                <strong>
                                	<c:choose>
                                		<c:when test="${list.get(0).payMethod==0}">무통장 입금</c:when>
                                		<c:when test="${list.get(0).payMethod==1}">신용카드</c:when>
                                		<c:when test="${list.get(0).payMethod==2}">계좌이체</c:when>
                                		<c:otherwise>핸드폰 결제</c:otherwise>
                                	</c:choose>
                                </strong>
                                <c:if test="${list.get(0).payMethod==0}">
	                                  	<p>입금은행 : 국민은행</p>
	                                   	<p>입금계좌 : 000000-00-000000</p>
	                                   	<p>예금주명 : 주식회사 멍냥개냥</p>
	                                   	<p>입금금액 : <strong class="deposit_money"><fmt:formatNumber value="${list.get(0).purchase}" type="number"/>원</strong></p>
	                                 	<p>입금자명 : ${list.get(0).name}</p>
                                </c:if>
                            </div>
                            </td>
                        </tr>
                        <tr style="	border-bottom: 1px solid #d4d4d4;">
                        	<td class="payTdTit">주문번호</td>
                        	<td class="payTdCon">${list.get(0).requestNum}</td>
                        </tr>
                         <tr style="	border-bottom: 1px solid #d4d4d4;">
                        	<td class="payTdTit">주문일자</td>
                        	<td class="payTdCon">${list.get(0).requestDate}</td>
                        </tr>
                      </table>
                </div>  
                <div class="payTable" style="margin-bottom: 50px;">
                	<h3>배송지 정보</h3>
                <table>        
                        <tr style="	border-bottom: 1px solid #d4d4d4;">
                            <td class="payTdTit">배송정보</td>
	                            <td class="payTdCon">
	                                 <strong>${list.get(0).deliverName}</strong> <br>
	                            </td>
                        	</tr>
                        	<tr style="	border-bottom: 1px solid #d4d4d4;">
                        		<td class="payTdTit">주소</td>
                        		<td class="payTdCon">
                        			[${list.get(0).deliverZip}] ${list.get(0).deliverAddr1} ${list.get(0).deliverAddr2}
                        		</td>
                        	</tr>
                        	<tr style="	border-bottom: 1px solid #d4d4d4;">
                        		<td class="payTdTit">전화번호</td>
                        		<td class="payTdCon">${list.get(0).deliverTel}</td>
                        	</tr>
                        	<tr style="	border-bottom: 1px solid #d4d4d4;">
                        		<td class="payTdTit">남기실 말씀</td>
                        		<td class="payTdCon">${list.get(0).memo}&nbsp;</td>
                        	</tr>
                        <tr style="	border-bottom: 1px solid #d4d4d4;">
                            <td class="payTdTit">상품 금액</td>
                            <td class="payTdCon"><strong class="order_payment_sum"><fmt:formatNumber value="${list.get(0).total}" type="number"/></strong>
                                <span class="add_currency"></span>
                            </td>
                        </tr>
                        <tr style="	border-bottom: 1px solid #d4d4d4;">
                            <td class="payTdTit">배송비</td>
                            <td class="payTdCon">2,500원
                                <span class="add_currency"></span>
                            </td>
                        </tr>
                        <tr style="	border-bottom: 1px solid #d4d4d4;">
                            <td class="payTdTit">적립 예정 포인트</td>
                            <td class="payTdCon">
                            	${list.get(0).point} 포인트
                            </td>
                        </tr>
                        <tr style="	border-bottom: 1px solid #d4d4d4;">
                            <td class="payTdTit">총 결제금액</td>
                            <td class="payTdCon"><strong class="order_payment_sum"><fmt:formatNumber value="${list.get(0).purchase}" type="number"/></strong>
                                <span class="add_currency"></span>
                            </td>
                        </tr>
                     </table>
                     </div>
 						<div style="text-align: center;">
							<button type="button" onclick="javascript:location.href='<%=cp%>/mypage/requestCheck';" class="pinkBtn" style="width: 250px;font-size: 15pt;">확인</button>
						</div>
</div>