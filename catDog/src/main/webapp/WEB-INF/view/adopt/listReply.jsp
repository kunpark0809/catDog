<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String cp=request.getContextPath();
%>

<table style='width: 100%; margin: 10px auto 30px; border-spacing: 0px;'>
	<thead id='listReplyHeader'>
		<tr height='35'>
		    <td colspan='2'>
			    <div style="float: left;">
			    	<span style="color: #d96363;font-weight: bold;">댓글 ${replyCount}개</span> 
			    </div>
		    </td>
		</tr>
	</thead>
	
	<tbody id='listReplyBody'>
	<c:forEach var="vo" items="${replyList}">
	     <tr height='35' style="background-color: #f9f9f9;">
	       <td width='50%' style='padding:5px 5px; color: #a66242; font-weight: bold;'>
	           <span><b>${vo.nickName}</b></span>
	        </td>
	       <td width='50%' style="padding:5px 5px; color: #a66242;" align='right'>
	           <span>${vo.created}</span> |
	           <c:if test="${vo.num == sessionScope.member.memberIdx ||  fn:indexOf(sessionScope.member.userId,'admin') == 0 }">
	                <span class="deleteReply" style="cursor: pointer;" data-replyNum='${vo.adoptionReplyNum}' data-pageNo='${pageNo}'>삭제</span>
	           	</c:if>
	           <c:if test="${vo.num != sessionScope.member.memberIdx &&  fn:indexOf(sessionScope.member.userId,'admin') != 0}">
	           		<span class="notifyReply">신고</span>
	           	</c:if>
	        </td>
	    </tr>
	    <tr>
	        <td colspan='2' valign='top' style='padding:5px 5px;'>
	              ${vo.content}
	        </td>
	    </tr>
	    
	    <tr>
	        <td style='padding:7px 5px;'>
	            <button type='button' class='smallWhiteBtn btnReplyAnswerLayout' data-replyNum='${vo.adoptionReplyNum}'>답글 <span id="answerCount${vo.adoptionReplyNum}">${vo.answerCount}</span></button>
	        </td>
	    </tr>
	
	    <tr class='replyAnswer' style='display: none;'>
	        <td colspan='2'>
	            <div id='listReplyAnswer${vo.adoptionReplyNum}' class='answerList' style='border-top: 1px solid #cccccc;'></div>
	            <div style='clear: both; padding: 10px 10px;'>
	                <div style='float: left; width: 5%;'>└</div>
	                <div style='float: left; width:95%'>
	                    <textarea cols='72' rows='12' class='boxTA' style='width:99%; height: 70px;'></textarea>
	                 </div>
	            </div>
	             <div style='padding: 0px 13px 10px 10px; text-align: right;'>
	                <button type='button' class='smallWhiteBtn btnSendReplyAnswer' data-replyNum='${vo.adoptionReplyNum}' style="width: 80px;">답글 등록</button>
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
