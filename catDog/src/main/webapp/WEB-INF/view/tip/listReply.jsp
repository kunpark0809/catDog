<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<style type="text/css">
.btn2 {
	width:70px;
    background-color: #51321b;
    border: none;
    color:#ffffff;
    padding: 10px 0;
    text-align: center;
    display: inline-block;
    font-size: 15px;
    margin: 4px;
    border-radius:10px;
}
</style>


<table style='width: 100%; margin: 10px auto 30px; border-spacing: 0px;'>
	<thead id='listReplyHeader'>
		<tr height='35'>
			<td colspan='2'>
				<div style='clear: both;'>
					<div style='float: left;'><span style='color: #D96262; font-weight: bold;'>댓글 ${replyCount}개</span></div>
					<div style='float: right; text-align: right;'></div>
				</div>
			</td>
		</tr>
	</thead>

	<tbody id='listReplyBody'>
		<c:forEach var="vo" items="${listReply}">
			<tr height='35' style='background: #51321b;'>
				<td width='50%' style='padding:5px 5px; border:1px solid #cccccc; border-right:none; color: white;' align="left">
					<span>${vo.nickName}</span>
				</td>
				<td width='50%' style='padding:5px 5px; border:1px solid #cccccc; border-left:none; color: white;' align='right'>
					<span>${vo.created}</span> |
					<c:if test="${vo.userId == sessionScope.member.userId ||  sessionScope.member.userId == 'admin' }">
						<span class="deleteReply" style="cursor: pointer;" data-tipReplyNum='${vo.tipReplyNum}' data-pageNo='${pageNo}'>삭제</span>
					</c:if>
					<c:if test="${vo.userId != sessionScope.member.userId && sessionScope.member.userId != 'admin' }">
						<span class="notifyReply">삭제</span>
					</c:if>
				</td>
			</tr>
			<tr>
				<td colspan='2' valign='top' style='padding:5px 5px;' align="left">
					${vo.content}
				</td>
			</tr>
			
			<tr>
				<td style='padding:7px 5px;' align="left">
					<button type='button' class='btn2 btnReplyParentLayout' data-tipReplyNum='${vo.tipReplyNum}'>답글 <span id="parentCount${vo.tipReplyNum}">${vo.parentCount}</span></button>
				</td>
			</tr>
			<tr class='replyParent' style='display: none;'>
				<td colspan='2'>
					<div id='listReplyParent${vo.tipReplyNum}' class='parentList' style='border-top: 1px solid #cccccc;'></div>
					<div style='clear: both; padding: 10px 10px;'>
						<div style='float: left; width: 5%;'>└</div>
						<div style='float: left; width:95%'>
							<textarea cols='72' rows='12' class='boxTA' style='width:98%; height: 70px;'></textarea>
						</div>
					</div>
					<div style='padding: 0px 13px 10px 10px; text-align: right; font-weight: bold;'>
						<button type='button' class='btn2 btnSendReplyParent' data-tipReplyNum='${vo.tipReplyNum}'>답글 등록</button>
					</div>
				</td>
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