<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String cp=request.getContextPath();
%>
<style type="text/css">
.selectField {
width: 70px;
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
width: 300px;
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

<link rel="stylesheet" href="<%=cp%>/resource/css/cs.css">
<script type="text/javascript">
function searchList() {
	var f=document.searchForm;
	f.submit();
}
</script>

<div class="container-board">

	<div class="body-title">
		<span><i class="fas fa-exclamation-triangle"></i>&nbsp;공지사항</span>
	</div>
	
	<div>
		<table style="width: 100%; border-spacing: 0px;">
			<tr height="35">
				<td align="left" width="50%">
					 <span style="color: #D96262;">${dataCount}</span>개(<span style="color: #D96262;">${page}</span>/${total_page} 페이지)
				</td>
				<td align="right">
					&nbsp;
				</td>
			</tr>
		</table>
		
		<table style="width: 100%; border-spacing: 0px; border-collapse: collapse;">
			<tr align="center" bgcolor="#51321b" height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				<th width="60" style="color: white;">번호</th>
				<th style="color: white;">제목</th>
				<th width="100" style="color: white;">작성자</th>
				<th width="100" style="color: white;">작성일</th>
				<th width="60" style="color: white;">조회수</th>
				<th width="50" style="color: white;">파일</th>
			</tr>
		 
		 <c:forEach var="vo" items="${listNoticeTop}">
			<tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;"> 
				<td><span style="display: inline-block;padding: 1px 3px; background: #f3a34e; color: #FFFFFF; border-radius: 5px 5px;"><i class="fas fa-exclamation-circle" style="color: red;"></i>&nbsp;공지</span></td>
				<td align="left" style="padding-left: 10px;">
					<a href="${articleUrl}&noticeNum=${vo.noticeNum}" style="color: #f3a34e; font-weight: bold;">${vo.subject}</a>
				</td>
				<td>${vo.nickName}</td>
				<td>${vo.created}</td>
				<td>${vo.hitCount}</td>
				<td>
					<c:if test="${vo.fileCount != 0}">
						<a href="<%=cp%>/notice/zipdownload?noticeNum=${vo.noticeNum}" style="color: black;"><i class="far fa-file"></i></a>
					</c:if>
				</td>
			</tr>
			</c:forEach>
			
			<c:forEach var="dto" items="${list}">
			<tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;"> 
				<td>${dto.listNum}</td>
				<td align="left" style="padding-left: 10px;">
					<a href="${articleUrl}&noticeNum=${dto.noticeNum}" style="color: black;">${dto.subject}</a>
					<c:if test="${dto.gap < 1}">
						<img src="<%=cp%>/resource/img/new.gif">
					</c:if>
				</td>
				<td>${dto.nickName}</td>
				<td>${dto.created}</td>
				<td>${dto.hitCount}</td>
				<td>
					<c:if test="${dto.fileCount != 0}">
						<a href="<%=cp%>/notice/zipdownload?noticeNum=${dto.noticeNum}" style="color: black;"><i class="far fa-file"></i></a>
					</c:if>
				</td>
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

		<table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
			<tr height="40">
				<td align="left" width="100">
					<button type="button" class="bts" onclick="javascript:location.href='<%=cp%>/notice/list';">새로고침</button>
				</td>
				<td align="center">
					<form name="searchForm" action="<%=cp%>/notice/list" method="post">
						<select name="condition" class="selectField">
							<option value="all" ${condition=="all"?"selected='selected'":""}>전체</option>
							<option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
							<option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
							<option value="nickName" ${condition=="nickName"?"selected='selected'":""}>작성자</option>
							<option value="created" ${condition=="created"?"selected='selected'":""}>등록일</option>
						</select>
						<input type="text" name="keyword" value="${keyword}" class="boxTF" size="30;">
						<button type="button" class="bts" onclick="searchList()"><i class="fas fa-search"></i></button>
					</form>
				</td>
				<td align="right" width="100">
				<c:if test="${fn:indexOf(sessionScope.member.userId,'admin') == 0}">
					<button type="button" class="bts" onclick="javascript:location.href='<%=cp%>/notice/created';">글올리기</button>
				</c:if>
				</td>
			</tr>
		</table>
	</div>
	
</div>
