<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<c:forEach var="vo" items="${listReplyParent}">
	<div class='parent' style='padding: 0px 10px;'>
		<div style='clear:both; padding: 10px 0px;'>
			<div style='float: left; width: 5%;'>└</div>
			<div style='float: left; width:95%;'>
				<div style='float: left;'><b>${vo.nickName}</b></div>
				<div style='float: right;'>
					<span>${vo.created}</span> |
					<c:if test="${sessionScope.member.userId==vo.userId || sessionScope.member.userId=='admin'}">
						<span class='deleteReplyParent' style='cursor: pointer;' data-tipReplyNum='${vo.tipReplyNum}' data-parent='${vo.parent}'>삭제</span>
					</c:if>
					<c:if test="${sessionScope.member.userId!=vo.userId && sessionScope.member.userId!='admin'}">
						<span class="notifyReply">삭제</span>
					</c:if>
				</div>
			</div>
		</div>
		<div style='clear:both; padding: 5px 5px 5px 5%; border-bottom: 1px solid #ccc;' align="left">
			${vo.content}
		</div>
	</div>
</c:forEach>