<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String cp=request.getContextPath();
%>
<style type="text/css">
.btn {
	width:70px;
    background-color: #262626;
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

<script type="text/javascript">
function searchList() {
	var f=document.searchForm;
	f.submit();
}
</script>

<div class="body-container" style="width: 60%; margin: 20px auto 0px; border-spacing: 0px;">

	<div class="body-title">
		<h3><span style="font-family: Webdings"></span>꿀팁</h3>
	</div>
	
	<div>
	
	<table style="width: 100%;  border-spacing: 0px;">
		   <tr height="40">
		      <td align="right">
		          <form name="searchForm" action="<%=cp%>/tip/list" method="post" style="width: 100%;">
		              	<select name="condition" class="selectField" style="border-radius:5px;">
		                  	<option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
							<option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
							<option value="nickName" ${condition=="nickName"?"selected='selected'":""}>작성자</option>
							<option value="created" ${condition=="created"?"selected='selected'":""}>등록일</option>
		            	</select>
		            <input type="text" name="keyword" value="${keyword}" class="boxTF" size="30;" style="border-radius:5px;">
		            <button type="button" class="btn" onclick="searchList()" style="width: 2%"><i class="fas fa-search"></i></button>
		         </form>
		      </td>
		      </tr>
	</table>
	
		<table style="width: 100%;  border-spacing: 0px;">
			<tr height="35">
				<td align="left" width="50%">
					전체 <span style="color: red;">${dataCount}</span>건 <span style="color: red;">${total_page}</span> 페이지
				</td>
				<td align="right">
					&nbsp;
				</td>
			</tr>
		</table>
		
		<table style="width: 100%; border-spacing: 0px; border-collapse: collapse;">
			<tr align="center" bgcolor="#D96262" height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				<th width="60" style="color: white;">번호</th>
				<th width="100" style="color: white;">말머리</th>
				<th style="color: white;">제목</th>
				<th width="100" style="color: white;">작성자</th>
				<th width="100" style="color: white;">작성일</th>
				<th width="60" style="color: white;">조회수</th>
	
			</tr>

 		<c:forEach var="dto" items="${listTipTop}">
			<tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;"> 
				<td><span style="display: inline-block;padding: 1px 3px; background: #A66242; color: #FFFFFF">공지</span></td>
				<td>${dto.tipCategory}</td>
				<td align="left" style="padding-left: 10px;">
					<a href="${articleUrl}&tipNum=${dto.tipNum}">${dto.subject}</a>
				</td>
				<td>${dto.nickName}</td>
				<td>${dto.created}</td>
				<td>${dto.hitCount}</td>
			</tr>
		</c:forEach>
			
			<c:forEach var="dto" items="${list}">
			<tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;"> 
				<td>${dto.listNum}</td>
				<td>${dto.tipCategory}</td>
				<td align="left" style="padding-left: 10px;">
					<a href="${articleUrl}&tipNum=${dto.tipNum}">${dto.subject}</a>
				</td>
				<td>${dto.nickName}</td>
				<td>${dto.created}</td>
				<td>${dto.hitCount}</td>

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
					<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/tip/list';">새로고침</button>
				</td>
				<td align="right" width="100">
					<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/tip/created';">글올리기</button>
				</td>
			</tr>
		</table>
	</div>
	
</div>
