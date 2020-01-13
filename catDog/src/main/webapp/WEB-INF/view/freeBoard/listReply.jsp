<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<style type="text/css">
.bts {
width: 70px;
background-color: #51321b;
border: none;
color: #ffffff;
padding: 6px 0;
text-align: center;
display: inline-block;
font-size: 15px;
margin: 4px;
border-radius: 5px;
}

.bts2 {
  background-color: white;
  border: 1px solid;
  border-color: #a9a9a9;
  color: #black;
  text-align: center;
  text-decoration: none;
  display: inline-block;
}

.bts3 {
width: 65px;
background-color: white;
border: 1px solid #d96262;
color: black;
padding: 6px 0;
text-align: center;
display: inline-block;
font-size: 15px;
margin: 4px;
border-radius: 5px;
}

</style>


<table style='width: 100%; margin: 10px auto 30px; border-spacing: 0px;'>
	<thead id='listReplyHeader'>
		<tr height='35'>
			<td colspan='2'>
				<div style='clear: both;'>
					<br><div style='float: left;'><span style='color: #D96262; font-weight: bold;'>댓글 ${replyCount}개</span></div>
					<div style='float: right; text-align: right;'><button type="button" onclick="report();" class='bts2'>신고</button></div>
				</div>
			</td>
		</tr>
	</thead>

	<tbody id='listReplyBody' style="background-color: #f9f9f9">
		<c:forEach var="vo" items="${listReply}">
			<tr height='35' style="background-color: #f9f9f9;">
				<td width='50%' style='padding:5px 5px; color: #a66242; font-weight: bold;' align="left">
					<span>${vo.nickName}</span>
				</td>
				<td width='50%' style='padding:5px 5px; color: #a66242;' align='right'>
					<span>${vo.created}</span> |
					<c:if test="${vo.userId == sessionScope.member.userId ||  sessionScope.member.userId == 'admin' }">
						<span class="deleteReply" style="cursor: pointer;" data-bbsReplyNum='${vo.bbsReplyNum}' data-pageNo='${pageNo}'>삭제</span>
					</c:if>
					<c:if test="${vo.userId != sessionScope.member.userId && sessionScope.member.userId != 'admin' }">
						<span class="notifyReply">삭제</span>
					</c:if>
				</td>
			</tr>
			<tr>
				<td colspan='2' valign='top' style='padding:0px 5px;' align="left">
					${vo.content}
				<p><button type='button' class='bts3 btnReplyParentLayout' data-bbsReplyNum='${vo.bbsReplyNum}'>답글 <span id="parentCount${vo.bbsReplyNum}">${vo.parentCount}</span></button><p>
				</td>
			</tr>
			
			<tr class='replyParent' style='display: none;'>
				<td colspan='2'>
					<div id='listReplyParent${vo.bbsReplyNum}' class='parentList'></div>
						<div style='clear: both; padding: 10px 10px;'>
							<div style='float: left; width: 5%;'>└</div>
							<div style='float: left; width:95%'>
							<textarea cols='72' rows='12' class='boxTA' style='width:98%; height: 70px;'></textarea>
						</div>
					</div>
					
					<div style='padding: 0px 13px 10px 10px; text-align: right; font-weight: bold;'>
						<button type='button' class='bts3 btnSendReplyParent' data-bbsReplyNum='${vo.bbsReplyNum}'>답글 등록</button>
					</div>
			</tr>
		</c:forEach>
	</tbody>
	<tfoot id='listReplyFooter'>
		<tr height='40' align="center">
            <td colspan='2' >
              ${paging}
            </td>
           </tr>
	</tfoot>
</table>