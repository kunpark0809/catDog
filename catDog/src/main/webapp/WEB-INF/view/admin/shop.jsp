<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<script type="text/javascript">
	function searchList() {
		var f = document.searchForm;
		f.submit();
	}

	function revive(userId){
		if(confirm(userId+"님을 활성화시키겠습니까?")){
			 var f = document.reviveForm;
			 f.userId.value = userId;
			 f.action = "<%=cp%>/admin/memberRevive";
			 f.submit();
		}
	}	
	
	function ban(userId){
		if(confirm(userId+"님을 추방하겠습니까?")){
			 var f = document.reviveForm;
			 f.userId.value = userId;
			 f.action = "<%=cp%>/admin/memberBan";
			 f.submit();
		}
	}
	
	
	
</script>


<div class="body-container" style="width: 1100px; margin: 0px auto;">
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
				style="border-top: 2px solid #cccccc; border-bottom: 1px solid #cccccc;">
				<th width="100" style="color: #787878;">주문번호</th>
				<th width="150" style="color: #787878;">주문인</th>
				<th width="150" style="color: #787878;">이메일</th>
				<th width="150" style="color: #787878;">전화번호</th>
				<th width="90" style="color: #787878;">총주문액수</th>
				<th width="90" style="color: #787878;">진행상태</th>
				<th width="90" style="color: #787878;">배송정보입력</th>
				<th width="90" style="color: #787878;">환불/취소</th>
				<th width="90" style="color: #787878;">상세정보</th>
				
			</tr>


			<!-- <c:forEach var="dto" items="${list}"> -->
				<tr align="center" bgcolor="#eeeeee" height="35"
				style="border-top: 2px solid #cccccc; border-bottom: 1px solid #cccccc;">
				<td>4</td>
				<td>결명자(kmjdhei14)</td>
				<td>askldfhasd@gmail.com</td>
				<td>010-9598-2938</td>
				<td>58,039원</td>
				<td>입금대기</td>
				<td>(버튼)</td>
				<td>(버튼)</td>
				<td>(버튼)</td>
			</tr>
			<!-- </c:forEach> -->
		</table>

		<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			<tr height="35">
				<td align="center">${dataCount==0?"해당되는 회원이 없습니다.":paging}</td>
			</tr>
		</table>
	
		<table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
			<tr height="40">
				<td align="left">
					<button type="button" class="btnConfirm"
						onclick="javascript:location.href='<%=cp%>/admin/member';">초기화</button>
				</td>
				<td align="left" style="width:65%;">
					<form name="searchForm" action="<%=cp%>/admin/member" method="post">
						<select name="condition" class="selectField">
							<option value="all" ${condition=="all"?"selected='selected'":""}>모두</option>
							<option value="userId"
								${condition=="userId"?"selected='selected'":""}>ID</option>
							<option value="nickName"
								${condition=="nickName"?"selected='selected'":""}>닉네임</option>
							<option value="reportCount"
								${condition=="reportCount"?"selected='selected'":""}>신고횟수</option>
						</select> <input type="text" name="keyword" value="${keyword}"
							class="boxTF">
							
						
							
						<button type="button" class="btnConfirm" onclick="searchList()">검색</button>
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