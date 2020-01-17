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
function deleteNotice(noticeNum) {
	<c:if test="${fn:indexOf(sessionScope.member.userId,'admin') == 0}">
		var q = "noticeNum=${dto.noticeNum}&${query}";
		var url = "<%=cp%>/notice/delete?"+q;
		
	if(confirm("게시물을 삭제 하시겠습니까 ?")) {
		location.href=url;
	}
	</c:if>
	<c:if test="${fn:indexOf(sessionScope.member.userId,'admin') != 0}">
		alert("게시물을 삭제할 수 없습니다.");
	</c:if>
}

function updateNotice(noticeNum) {
	<c:if test="${fn:indexOf(sessionScope.member.userId,'admin') == 0}">
		var q = "noticeNum=${dto.noticeNum}&page=${page}";
		var url = "<%=cp%>/notice/update?"+q;
		
		location.href=url;
	</c:if>
	
	<c:if test="${fn:indexOf(sessionScope.member.userId,'admin') != 0}">
		alert("게시물을 수정할 수 없습니다.");
	</c:if>
}
</script>

<div class="container-board">
	<div class="body-title">
		<span><i class="fas fa-exclamation-triangle"></i>&nbsp;공지사항</span>
	</div>
	
	

	<div>
		<table style="width: 100%; margin: 10px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			<tr height="35" style="border-top: 2px solid #D96262; padding-top:20px; padding-bottom:20px; border-bottom: 1px solid #cccccc;">
				<td width="50%" align="left" style="padding-left: 5px; font-size: 20px; padding-top:20px; padding-bottom:20px; border-bottom: 1px solid #cccccc;">
					${dto.subject}
				</td>
				<td width="50%" align="right" style="font-size: 15px; font-weight: bold;">
			         날짜&nbsp;&nbsp;${dto.created}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;조회수&nbsp;&nbsp;${dto.hitCount}
			    </td> 
			</tr>

			<tr height="35" style="border-top: 1px solid #cccccc;">
				<td align="left" style="padding-left: 5px; font-size: 17px;">
					작성자 : ${dto.nickName}
				</td>
			</tr>
			
			<tr>
				<td colspan="2" align="center" style="padding: 10px 5px;" valign="top" height="200">
					${dto.content}
				</td>
			</tr>
			
			<c:forEach var="file" items="${listFile}">
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td colspan="2" align="left" style="padding-left: 5px;">
					첨부 :
    					 <a href="<%=cp%>/notice/download?noticeFileNum=${file.noticeFileNum}" style="color: black;">${file.originalFileName}</a>
    					 (<fmt:formatNumber value="${file.fileSize/1024}" pattern="0.00"/>KByte)
				</td>
			</tr>
			</c:forEach>

			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td colspan="2" align="left" style="padding-left: 5px;">
					이전글 :
						<c:if test="${not empty preReadDto}">
              				<a href="<%=cp%>/notice/article?${query}&noticeNum=${preReadDto.noticeNum}" style="color: black;">${preReadDto.subject}</a>
       					 </c:if>
				</td>
			</tr>

			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td colspan="2" align="left" style="padding-left: 5px;">
					다음글 :
					<c:if test="${not empty nextReadDto}">
             		 <a href="<%=cp%>/notice/article?${query}&noticeNum=${nextReadDto.noticeNum}" style="color: black;">${nextReadDto.subject}</a>
       				 </c:if>
				</td>
			</tr>
		</table>

		<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
			<tr height="45">
			<c:if test="${fn:indexOf(sessionScope.member.userId,'admin') == 0}">
				<td width="300" align="left">
					<button type="button" class="bts" onclick="updateNotice();" ${fn:indexOf(sessionScope.member.userId,'admin') != 0 ? "style='pointer-events:none;'":""}>수정</button>
					<button type="button" class="bts" onclick="deleteNotice();" ${fn:indexOf(sessionScope.member.userId,'admin') != 0 ? "style='pointer-events:none;'":""}>삭제</button>
				</td>
			</c:if>
				<td align="right">
					<button type="button" class="bts" onclick="javascript:location.href='<%=cp%>/notice/list?${query}';">리스트</button>
				</td>
			</tr>
		</table>
	</div>

</div>