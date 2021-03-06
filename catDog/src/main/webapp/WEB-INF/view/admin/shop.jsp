<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<style type="text/css">
.selectField {
	background-color: white;
	border: 2px solid #51321b;
	color: black;
	padding: 3px 0;
	text-align: center;
	display: inline-block;
	font-size: 15px;
	margin: 2px;
}

.boxTF {
	background-color: white;
	border: 2px solid #51321b;
	color: black;
	padding: 3px 0;
	text-align: center;
	display: inline-block;
	font-size: 15px;
	margin: 2px;
}
</style>

<script type="text/javascript">
	function searchList() {
		var f = document.searchForm;
		f.submit();
	}

</script>


<div class="body-container" style="width: 1200px; padding-top:60px; min-height:490px; margin: 0px auto;">
	<div class="body-title">
		<h3>
			<span style="font-family: Wingdings">-</span> 쇼핑몰 관리
		</h3>
	</div>
	<div>
		<table
			style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
			<tr height="35">
				<td align="left" width="50%">
					총 주문 수 : ${dataCount}건 (${page}/${total_page} 페이지)</td>
				<td align="right">&nbsp;</td>
			</tr>
		</table>
		<table
			style="font-size: 15px; width: 100%; margin: 0px auto; border-spacing: 0px; border-collapse: collapse;">
			<tr align="center" bgcolor="#eeeeee" height="35"
				style="color:white; background-color:#51321b;">
				<th width="80">주문번호</th>
				<th width="150">주문자</th>
				<th width="150">이메일</th>
				<th width="150">전화번호</th>
				<th width="150">주문일</th>
				<th width="90">총주문액수</th>
				<th width="90">진행상태</th>
				<th width="90">상세정보</th>
			</tr>


			 <c:forEach var="dto" items="${list}"> 
				<tr align="center" bgcolor="white" height="35"
				style="border-bottom: 1px solid #cccccc;">
				<td>${dto.requestNum }</td>
				<td>${dto.customerName}(${dto.userId})</td>
				<td>${dto.email }</td>
				<td>${dto.tel }</td>
				<td>${dto.requestDate}</td>
				<td align="right">${dto.totalWithComma }원</td>
				<td>${dto.statusToString}</td>
				<td><button class="yellowBts" style="padding: 0px;">수정</button> </td>
			</tr>
			</c:forEach>
		</table>

		<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			<tr height="35">
				<td align="center">${dataCount==0?"해당되는 회원이 없습니다.":paging}</td>
			</tr>
		</table>
	
		<table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
			<tr height="40">
				<td align="left">
					<button type="button" class="bts"
						onclick="javascript:location.href='<%=cp%>/admin/shop';">새로고침</button>
				</td>
				<td align="left" style="width:65%;">
					<form name="searchForm" action="<%=cp%>/admin/shop" method="post">
						<select name="condition" class="selectField">
							<option value="orderer"
								${condition=="orderer"?"selected='selected'":""}>주문자(ID,이름)</option>
							<option value="email"
								${condition=="email"?"selected='selected'":""}>이메일</option>
							<option value="tel"
								${condition=="tel"?"selected='selected'":""}>전화번호</option>
							<option value="requestDate"
								${condition=="requestDate"?"selected='selected'":""}>주문일자</option>
							<option value="productName"
								${condition=="productName"?"selected='selected'":""}>상품명</option>
							<option value="status"
								${condition=="status "?"selected='selected'":""}>진행상태</option>
						</select> <input type="text" name="keyword" value="${keyword}"
							class="boxTF">
							
						
							
						<button type="button" class="bts" onclick="searchList()" style="width: 5%;"><i class="fas fa-search"></i></button>
					</form>
				</td>

			</tr>
		</table>

	</div>
	<form name="reviveForm" method="post">
		<input type="hidden" name="userId">
		<input type="hidden" name="condition" value="${condition}">
		<input type="hidden" name="keyword" value="${keyword}">
		<input type="hidden" name="page" value="${page}">
	</form>
</div>