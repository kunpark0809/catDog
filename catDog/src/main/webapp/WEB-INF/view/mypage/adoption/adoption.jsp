<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String cp=request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/cs.css">

<div class="body-container" style="width: 1000px; margin: 20px auto 0px; border-spacing: 0px; min-height: 510px;">
	<div>
		<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
			<tr height="35">
				<td align="left" width="50%">
					${dataCount}개(${page}/${total_page} 페이지)
				</td>
				<td align="right">
					&nbsp;
				</td>
			</tr>
		</table>

		
		<table style="width: 100%; border-spacing: 0px; border-collapse: collapse;">
			<tr align="center" bgcolor="#eeeeee" height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				<th width="60" style="color: #787878;">&nbsp;번호&nbsp;</th>
      			<th style="color: #787878;">&nbsp;제목&nbsp;</th>
      			<th width="100" style="color: #787878;">&nbsp;작성자&nbsp;</th>
      			<th width="100" style="color: #787878;">&nbsp;작성자&nbsp;</th>
      			<th width="80" style="color: #787878;">&nbsp;조회수&nbsp;</th>
			</tr>
		 
		<c:forEach var="dto" items="${listMpAdoption}">
			<tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;"> 
				<td>${dto.adoptionListNum}</td>
				<td align="left" style="padding-left: 10px;">
					<a href="${articleUrl}&adoptionNum=${dto.adoptionNum}">${dto.adoptionSubject}</a>
      			</td>
				<td>${dto.nickName}</td>
				<td>${dto.adoptionCreted}</td>
				<td>${dto.adoptionHitCount}</td>
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
					<button type="button" class="btn" onclick="reloadBoard();">새로고침</button>
				</td>
				<td align="center">
					<form name="searchForm" action="" method="post">
						<select id="condition" name="condition" class="selectField">
							<option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
							<option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
							<option value="nickName" ${condition=="nickName"?"selected='selected'":""}>작성자</option>
							<option value="created" ${condition=="created"?"selected='selected'":""}>등록일</option>
						</select>
					    <input type="text" id="keyword" name="keyword" class="boxTF" value="${keyword}">
            			<button type="button" class="btn" onclick="searchList();">검색</button>
        			</form>
				</td>
			</tr>
		</table>
	</div>
	
</div>
