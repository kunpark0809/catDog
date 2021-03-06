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
			<span style="font-family: Wingdings">CD</span> 회원 관리
		</h3>

	</div>
	
	
	
	<div>
		<table
			style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
			<tr height="35">
				<td align="left" width="50%">
					총 회원 수 : ${dataCount}명 (${page}/${total_page} 페이지)</td>
				<td align="right">&nbsp;</td>
			</tr>
		</table>

		<table
			style="font-size: 15px; width: 100%; margin: 0px auto; border-spacing: 0px; border-collapse: collapse;">
			<tr align="center" bgcolor="#eeeeee" height="35"
				style="border-top: 2px solid #cccccc; border-bottom: 1px solid #cccccc;">
				<th width="100" style="color: #787878;">사용자번호</th>
				<th width="100" style="color: #787878;">ID</th>
				<th style="color: #787878;">닉네임</th>
				<th width="80" style="color: #787878;">성명</th>
				<th width="90" style="color: #787878;">마일리지</th>
				<th width="90" style="color: #787878;">주문횟수</th>
				<th width="90" style="color: #787878;">신고횟수</th>
				<th width="250" style="color: #787878;">최종접속시간</th>
				<th width="180" style="color: #787878;">로그인실패횟수</th>
				<th width="120" style="color: #787878;">활성화</th>
				<th width="90" style="color: #787878;">강퇴</th>
			</tr>


			<c:forEach var="dto" items="${list}">
				<tr align="center" height="30"
					style="border-bottom: 1px solid #cccccc;">
					<td>${dto.num }</td>
					<td>${dto.userId }</td>
					<td>${dto.nickName }</td>
					<td>${dto.name }</td>
					<td>${dto.mileage }</td>
					<td>${dto.requestCount }</td>
					<td>${dto.reportCount }</td>
					<td>${dto.lastLogin }</td>
					<td>${dto.failure_cnt }</td>
					<td>
						<c:if test="${dto.failure_cnt==5}">
							<button type='button' onclick='revive("${dto.userId}")'>활성화</button>
						</c:if>
					</td>
					<td>
						<c:choose>
							<c:when test="${dto.stateCode==2}">
								강퇴됨
							</c:when>
							<c:otherwise>
								<button type="button" onclick='ban("${dto.userId}")'>강퇴</button>
							</c:otherwise>
						</c:choose>
					</td>
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