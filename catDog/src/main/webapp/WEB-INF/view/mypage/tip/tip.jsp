<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String cp=request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/cs.css">
<style type="text/css">
.bts {
	width:70px;
    background-color: #51321b;
    border: none;
    color:#ffffff;
    padding: 6px 0;
    text-align: center;
    display: inline-block;
    font-size: 15px;
    margin: 4px;
    border-radius:10px;
}

</style>
<div class="container-board">
	<div>
		<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
			<tr height="35">
				<td align="left" width="50%">
					${dataCountMpTip}개(${page}/${total_page} 페이지)
				</td>
				<td align="right">
					&nbsp;
				</td>
			</tr>
		</table>
		
		<table style="width: 100%; border-spacing: 0px; border-collapse: collapse;">
			<tr align="center" bgcolor="#51321b" height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				<th width="60" style="color: white;">&nbsp;번호&nbsp;</th>
				<th width="100" style="color: white;">&nbsp;말머리&nbsp;</th>
      			<th style="color: white;">&nbsp;제목&nbsp;</th>
      			<th width="100" style="color: white;">&nbsp;작성자&nbsp;</th>
      			<th width="100" style="color: white;">&nbsp;작성일&nbsp;</th>
      			<th width="80" style="color: white;">&nbsp;조회수&nbsp;</th>
			</tr>
		 
		<c:forEach var="dto" items="${listMpTip}">
			<tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;"> 
				<td>${dto.tipListNum}</td>
				<td>${dto.tipCategoryNum==1?"강아지":"고양이"}</td>
				<td align="left" style="padding-left: 10px;">
					<a href="${articleUrl}&tipNum=${dto.tipNum}">${dto.tipSubject}</a>
      			</td>
				<td>${dto.nickName}</td>
				<td>${dto.tipCreated}</td>
				<td>${dto.tipHitCount}</td>
			</tr>
		</c:forEach>

		</table>

		<table style="width: 100%; border-spacing: 0px;">
			<tr height="35">
				<td align="center">
					${dataCountMpTip==0 ? "등록된 자료가 없습니다." : paging}
				</td>
			</tr>
		</table>

		<table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
			<tr height="40">
				<td align="left" width="100">
					<button type="button" class="bts" onclick="reloadBoard();">새로고침</button>
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
            			<button type="button" class="bts" onclick="searchList();">검색</button>
        			</form>
				</td>
			</tr>
		</table>
	</div>
	
</div>
