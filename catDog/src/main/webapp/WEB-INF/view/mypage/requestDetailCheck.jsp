<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript">
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

$(function(){
	var myKey="SSnicrqY2jJjrBR4d6eIfw";
	// 배송정보와 배송추적 tracking-api
    $("#myButton1").click(function() {
        var t_code = "${express.expressNum}";
        var t_invoice = "${express.invoice}";
        $.ajax({
            type:"GET",
            dataType : "json",
            url:"http://info.sweettracker.co.kr/api/v1/trackingInfo?t_key="+myKey+"&t_code="+t_code+"&t_invoice="+t_invoice,
            success:function(data){
                console.log(data);
                var myInvoiceData = "";
                if(data.status == false){
                    myInvoiceData += ('<p>'+data.msg+'<p>');
                }else{
                    myInvoiceData += ('<tr>');                
                    myInvoiceData += ('<th>'+"보내는사람"+'</td>');                     
                    myInvoiceData += ('<th>'+data.senderName+'</td>');                     
                    myInvoiceData += ('</tr>'); 
                    myInvoiceData += ('<tr>');                
                    myInvoiceData += ('<th>'+"받는사람"+'</td>');                     
                    myInvoiceData += ('<th>'+data.receiverName+'</td>');                     
                    myInvoiceData += ('</tr>'); 
                    myInvoiceData += ('<tr>');                
                    myInvoiceData += ('<th>'+"제품정보"+'</td>');                     
                    myInvoiceData += ('<th>'+data.itemName+'</td>');                     
                    myInvoiceData += ('</tr>');     
                    myInvoiceData += ('<tr>');                
                    myInvoiceData += ('<th>'+"송장번호"+'</td>');                     
                    myInvoiceData += ('<th>'+data.invoiceNo+'</td>');                     
                    myInvoiceData += ('</tr>');                                     
                }
                
                
                $("#myPtag").html(myInvoiceData)
                
                var trackingDetails = data.trackingDetails;
                
                if(trackingDetails != null) {
                var myTracking="";
                var header ="";
                header += ('<tr>');                
                header += ('<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+"시간"+'</th>');
                header += ('<th>&nbsp;&nbsp;&nbsp;&nbsp;'+"장소"+'</th>');
                header += ('<th>&nbsp;&nbsp;&nbsp;&nbsp;'+"유형"+'</th>');
                header += ('<th>'+"전화번호"+'</th>');                     
                header += ('</tr>');     
                
                $.each(trackingDetails,function(key,value) {
                    myTracking += ('<tr>');                
                    myTracking += ('<td>'+value.timeString+'</td>');
                    myTracking += ('<td>&nbsp;&nbsp;'+value.where+'</td>');
                    myTracking += ('<td>&nbsp;&nbsp;'+value.kind+'</td>');
                    myTracking += ('<td>&nbsp;&nbsp;'+value.telno+'</td>');                     
                    myTracking += ('</tr>');                                    
                });
                }
                $("#myPtag2").html(header+myTracking);
                
            }
        });
    });
})
</script>

<div class="body-container" style="width: 1200px; margin: 20px auto 0px; border-spacing: 0px;">
	<div class="body-title">
		<h3><span style="font-family: Webdings"></span> 주문 상세 조회 </h3>
	</div>
	
	<div>
		<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
			<tr height="35">
				<td align="left" width="50%">
					주문 정보
				</td>
				<td align="right">
					&nbsp;
				</td>
			</tr>
		</table>
		
		<br>
		<table style="width: 100%; border-spacing: 0px; border-collapse: collapse;">
			<tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;">
				<td style="width: 200px; text-align: left;">&nbsp;&nbsp;주문번호</td>
				<td style="text-align: left;">&nbsp;&nbsp;&nbsp;${detailList.get(0).requestNum}</td>
			</tr>
			<tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;">
				<td style="width: 200px; text-align: left;">&nbsp;&nbsp;주문일자</td>
				<td style="text-align: left;">&nbsp;&nbsp;&nbsp;${detailList.get(0).requestDate}</td>
			</tr>
			<tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;">
				<td style="width: 200px; text-align: left;">&nbsp;&nbsp;주문자</td>
				<td style="text-align: left;">&nbsp;&nbsp;&nbsp;${detailList.get(0).name}</td>
			</tr>
			<tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;">
				<td style="width: 200px; text-align: left;">&nbsp;&nbsp;주문처리상태</td>
				<c:choose>
				<c:when test="${detailList.get(0).status==0}">
					<td style="text-align: left;">&nbsp;&nbsp;&nbsp;입금대기</td>
				</c:when>
				<c:when test="${detailList.get(0).status==1}">
					<td style="text-align: left;">&nbsp;&nbsp;&nbsp;결제완료</td>
				</c:when>
				<c:when test="${detailList.get(0).status==2}">
					<td style="text-align: left;">&nbsp;&nbsp;&nbsp;배송준비중</td>
				</c:when>
				<c:when test="${detailList.get(0).status==3}">
					<td style="text-align: left;">&nbsp;&nbsp;&nbsp;배송중</td>
				</c:when>
				<c:when test="${detailList.get(0).status==4}">
					<td style="text-align: left;">&nbsp;&nbsp;&nbsp;배송완료
						<br><button type="button" class="btn" onclick="#">후기등록</button> 
					</td>
				</c:when>
				<c:when test="${detailList.get(0).status==5}">
					<td style="text-align: left;">&nbsp;&nbsp;&nbsp;취소완료</td>
				</c:when>
				<c:when test="${detailList.get(0).status==6}">
					<td style="text-align: left;">&nbsp;&nbsp;&nbsp;환불진행중</td>
				</c:when>
				<c:when test="${detailList.get(0).status==7}">
					<td style="text-align: left;">&nbsp;&nbsp;&nbsp;환불완료</td>
				</c:when>
				<c:when test="${detailList.get(0).status==8}">
					<td style="text-align: left;">&nbsp;&nbsp;&nbsp;교환진행중</td>
				</c:when>
				<c:when test="${detailList.get(0).status==9}">
					<td style="text-align: left;">&nbsp;&nbsp;&nbsp;교환완료
					<br><button type="button" class="btn" onclick="#">후기등록</button>
					</td>
				</c:when>
				</c:choose>
			</tr>
		</table>
		<br>
		
		<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
			<tr height="35">
				<td align="left" width="50%">
					결제 정보
				</td>
				<td align="right">
					&nbsp;
				</td>
			</tr>
		</table>
		
		<br>
		
		<table style="width: 100%; border-spacing: 0px; border-collapse: collapse;">
			<tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;">
				<td style="width: 200px; text-align: left;">&nbsp;&nbsp;총 주문금액</td>
				<td style="text-align: left;">&nbsp;&nbsp;&nbsp;${detailList.get(0).total}</td>
			</tr>
			<tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;">
				<td style="width: 200px; text-align: left;">&nbsp;&nbsp;사용 포인트</td>
				<td style="text-align: left;">&nbsp;&nbsp;&nbsp;${detailList.get(0).usePoint}</td>
			</tr>
			<tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;">
				<td style="width: 200px; text-align: left;">&nbsp;&nbsp;총 결제금액</td>
				<td style="text-align: left;">&nbsp;&nbsp;&nbsp;${detailList.get(0).purchase}</td>
			</tr>
			<tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;">
				<td style="width: 200px; text-align: left;">&nbsp;&nbsp;적립 포인트</td>
				<td style="text-align: left;">&nbsp;&nbsp;&nbsp;${detailList.get(0).point}</td>
			</tr>
			<tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;">
				<td style="width: 200px; text-align: left;">&nbsp;&nbsp;결제수단</td>
				<td style="text-align: left;">&nbsp;&nbsp;&nbsp;${detailList.get(0).payMethod}</td>
			</tr>
		</table>
		
		<br>
		
		<table style="width: 100%; border-spacing: 0px; border-collapse: collapse;">
			<tr align="center" bgcolor="#eeeeee" height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				<th width="130" style="color: #787878;">주문일자<br>[주문상세번호]</th>
				<th style="color: #787878; width: 80px;">이미지</th>
				<th width="300" style="color: #787878;">상품정보</th>
				<th width="80" style="color: #787878;">수량</th>
				<th width="60" style="color: #787878;">상품구매금액</th>
				<th width="60" style="color: #787878;">주문처리상태</th>
				<th width="70" style="color: #787878;">취소/교환/반품</th>
			</tr>
			
			<c:forEach var="dto" items="${detailList}">
			<tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;"> 
				<td>${dto.requestDate}<br>${dto.requestDetailNum}</td>
				<td align="left" style="padding-left: 10px;">
					<img style="width: 80px; height: 80px;" src="<%=cp%>/uploads/dogshop/${dto.imageFileName}">
				</td>
				<td>
					<a href="<%=cp%>/dogshop/article?productNum=${dto.productNum}">${dto.productName}</a>
				</td>
				<td>${dto.productCount}</td>
				<td>${dto.productSum}</td>
				<c:choose>
				<c:when test="${dto.status==0}">
					<td>입금대기</td>
				</c:when>
				<c:when test="${dto.status==1}">
					<td>결제완료</td>
				</c:when>
				<c:when test="${dto.status==2}">
					<td>배송준비중</td>
				</c:when>
				<c:when test="${dto.status==3}">
					<td>배송중</td>
				</c:when>
				<c:when test="${dto.status==4}">
					<td>배송완료
						<br><button type="button" class="btn" onclick="#">후기등록</button> 
					</td>
				</c:when>
				<c:when test="${dto.status==5}">
					<td>취소완료</td>
				</c:when>
				<c:otherwise>
					<td>-</td>
				</c:otherwise>
				</c:choose>
				<c:choose>
				<c:when test="${dto.status==0}">
					<td>
						<button type="button" class="btn" onclick="requestCancle(${dto.requestNum});">주문취소</button> 
					</td>
				</c:when>
				<c:when test="${dto.status==1}">
					<td>
						<button type="button" class="btn" onclick="#">결제취소</button> 
					</td>
				</c:when>
				<c:when test="${dto.status==4}">
					<td><button type="button" class="btn" onclick="requestRefund(${dto.requestNum});">환불신청</button>
						<br><button type="button" class="btn" onclick="requestSwap(${dto.requestNum});">교환신청</button>
					</td>
				</c:when>
				<c:when test="${dto.status==6}">
					<td>환불진행중</td>
				</c:when>
				<c:when test="${dto.status==7}">
					<td>환불완료</td>
				</c:when>
				<c:when test="${dto.status==8}">
					<td>교환진행중</td>
				</c:when>
				<c:when test="${dto.status==9}">
					<td>교환 완료</td>
				</c:when>
				<c:otherwise><td>-</td></c:otherwise>
				</c:choose>
			</tr>
			</c:forEach>
		</table>
		
		<br>
		
		<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
			<tr height="35">
				<td align="left" width="50%">
					배송 정보
				</td>
				<td align="right">
					&nbsp;
				</td>
			</tr>
		</table>
		
		<br>
		
		<table style="width: 100%; border-spacing: 0px; border-collapse: collapse;">
			<tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;">
				<td style="width: 200px; text-align: left;">&nbsp;&nbsp;배송자 정보</td>
				<td style="text-align: left;">&nbsp;&nbsp;&nbsp;${detailList.get(0).deliverName}</td>
			</tr>
			<tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;">
				<td style="width: 200px; text-align: left;">&nbsp;&nbsp;주소</td>
				<td style="text-align: left;">&nbsp;&nbsp;&nbsp;[${detailList.get(0).deliverZip}]&nbsp;${detailList.get(0).deliverAddr1}&nbsp;${detailList.get(0).deliverAddr2}&nbsp;</td>
			</tr>
			<tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;">
				<td style="width: 200px; text-align: left;">&nbsp;&nbsp;휴대폰 번호</td>
				<td style="text-align: left;">&nbsp;&nbsp;&nbsp;${detailList.get(0).deliverTel}</td>
			</tr>
			<tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;">
				<td style="width: 200px; text-align: left;">&nbsp;&nbsp;메모</td>
				<td style="text-align: left;">&nbsp;&nbsp;&nbsp;${detailList.get(0).memo}</td>
			</tr>
		</table>
		<br>
		
		
            <button type="button" id="myButton1">배송조회</button>
     	<br>
        
        <div id="myPtag">
        	
        </div>
        
        <div id="myPtag2">
        </div>
	</div>


</div>