<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String cp=request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/cs.css">
<script type="text/javascript">
function searchList() {
	var f=document.searchForm;
	f.submit();
}
</script>

<div class="container-board" style="padding: 60px;">

	<div class="body-title">
		<h3><span style="font-family: Webdings"><i class="fab fa-pinterest"></i></span> 포인트 조회 </h3>
	</div>
	
	<div>
		<table style="width: 100%; border-spacing: 0px;">
			<tr height="35">
				<td align="left" width="50%">
					전체 <span style="color: #D96262;">${dataCount}</span>건 / 총 <span style="color: #D96262;">${total_page}</span> 페이지
				</td>
				<td align="right" width="50%">
					잔여포인트 : ${empty list? 0:list.get(0).mileage}
				</td>
				<td align="right">
					&nbsp;
				</td>
			</tr>
		</table>
		
		<table style="width: 100%; border-spacing: 0px; border-collapse: collapse;">
			<tr align="center" bgcolor="#51321b" height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				<th width="100" style="color: white;">날짜</th>
				<th style="color: white;">내용</th>
				<th width="100" style="color: white;"> 포인트 </th>
			</tr>
		 
		<c:forEach var="dto" items="${list}">
			<tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;"> 
				<td align="left" style="padding-left: 10px;">${dto.created}</td>
				<td>${dto.content}</td>
				<td>${dto.checked!=0?'+':'-'}${dto.point}</td>
			</tr>
		</c:forEach>

		</table>

		<table style="width: 100%; border-spacing: 0px;">
			<tr height="35">
				<td align="center">
					${dataCount==0 ? "등록된 자료가 없습니다." : paging}
				</td>
			</tr>
		</table>

		<%-- <table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
			<tr height="40">
				<td align="left" width="100">
					<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/mypage/point';">새로고침</button>
				</td>
				<td align="center">
					<form name="searchForm" action="<%=cp%>/notice/list" method="post">
						<select name="condition" class="selectField">
							<option value="all" ${condition=="all"?"selected='selected'":""}>제목+내용</option>
							<option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
							<option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
							<option value="nickName" ${condition=="nickName"?"selected='selected'":""}>작성자</option>
							<option value="created" ${condition=="created"?"selected='selected'":""}>등록일</option>
						</select>
						<input type="text" name="keyword" value="${keyword}" class="boxTF">
						<button type="button" class="btn" onclick="searchList()">검색</button>
					</form>
				</td>
			</tr>
		</table> --%>
	</div>
	
</div>
