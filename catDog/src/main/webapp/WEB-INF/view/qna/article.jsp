<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript">
function deleteQuestion(qnaNum) {
	<c:if test="${sessionScope.member.userId==questionDto.userId || fn:indexOf(sessionScope.member.userId,'admin') == 0}">
		var q = "qnaNum=${questionDto.qnaNum}&${query}";
		var url = "<%=cp%>/qna/deleteQuestion?"+q;
		
	if(confirm("질문을 삭제 하시겠습니까 ?")) {
		location.href=url;
	}
	</c:if>
	<c:if test="${sessionScope.member.userId!=questionDto.userId && fn:indexOf(sessionScope.member.userId,'admin') != 0}">
		alert("게시물을 삭제할 수 없습니다.");
	</c:if>
}

function updateQuestion(qnaNum) {
	<c:if test="${sessionScope.member.userId==questionDto.userId}">
		var q = "qnaNum=${questionDto.qnaNum}&pageNo=${dto.pageNo}";
		var url = "<%=cp%>/qna/updateQuestion?"+q;
		
		location.href=url;
	</c:if>
	
	<c:if test="${sessionScope.member.userId!=questionDto.userId}">
		alert("질문을 수정할 수 없습니다.");
	</c:if>
}

function insertAnswer(qnaNum) {
	<c:if test="${fn:indexOf(sessionScope.member.userId,'admin') == 0}">
		var q = "qnaNum=${questionDto.qnaNum}&pageNo=${pageNo}";
		var url = "<%=cp%>/qna/insertAnswer?"+q;
		
		location.href=url;
	</c:if>
	
	<c:if test="${fn:indexOf(sessionScope.member.userId,'admin') != 0}">
		alert("답변을 게시할 수 없습니다.");
	</c:if>
}

function deleteAnswer(qnaNum) {
	<c:if test="${fn:indexOf(sessionScope.member.userId,'admin') == 0}">
		var q = "qnaNum=${answerDto.qnaNum}&${query}";
		var url = "<%=cp%>/qna/deleteAnswer?"+q;
		
	if(confirm("답변을 삭제 하시겠습니까 ?")) {
		location.href=url;
	}
	</c:if>
	<c:if test="${fn:indexOf(sessionScope.member.userId,'admin') != 0}">
		alert("답변을 삭제할 수 없습니다.");
	</c:if>
}

function updateAnswer(qnaNum) {
	<c:if test="${fn:indexOf(sessionScope.member.userId,'admin') == 0}">
		var q = "qnaNum=${dto.qnaNum}&pageNo=${pageNo}";
		var url = "<%=cp%>/qna/updateAnswer?"+q;
		
		location.href=url;
	</c:if>
	
	<c:if test="${fn:indexOf(sessionScope.member.userId,'admin') != 0}">
		alert("답변을 수정할 수 없습니다.");
	</c:if>
}


</script>

<div class="body-container" style="width: 830px; margin: 20px auto 0px; border-spacing: 0px;">
<div class="alert-info">
    <i class="fas fa-info-circle"></i>
         궁금하신 질문을 해달라냥!
</div>

<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
<tr height="35">
    <td colspan="2" align="left">
    	<span class="questionQ">질문이다냥!</span><span class="questionSubject">&nbsp;♣ ${questionDto.qnaCategory} ♣ ${questionDto.subject}</span>
    </td>
</tr>

<tr height="35" style="border-bottom: 1px solid #cccccc;">
    <td width="50%" align="left" style="padding-left: 5px;">
       작성자 : ${questionDto.nickName}
    </td>
    <td width="50%" align="right" style="padding-right: 5px;">
     문의일자 : ${questionDto.created}
    </td>
</tr>

<tr>
  <td colspan="2" align="left" style="padding: 10px 5px;" valign="top" height="200">
      ${questionDto.content}
   </td>
</tr>
</table>

<c:if test="${not empty answerDto}">
	<table style="width: 100%; margin: 10px auto 0px; border-spacing: 0px; border-collapse: collapse;">
	<tr height="35">
	    <td colspan="2" align="left">
    	<span class="answerA"></span><span class="answerSubject">${answerDto.subject} 에 대한 답변이다냥!</span>
	    </td>
	</tr>
	
	<tr height="35" style="border-bottom: 1px solid #cccccc;">
	    <td width="50%" align="left" style="padding-left: 5px;">
	       담당자 : ${answerDto.nickName}
	    </td>
	    <td width="50%" align="right" style="padding-right: 5px;">
	     답변일자 :  ${answerDto.created}
	    </td>
	</tr>
	
	<tr>
	  <td colspan="2" align="left" style="padding: 10px 5px;" valign="top" height="200">
	      ${answerDto.content}
	   </td>
	</tr>
	</table>

</c:if>

<table style="width: 100%; margin: 0px auto 0px; border-spacing: 0px; border-collapse: collapse;">
<tr height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
    <td colspan="2" align="left" style="padding-left: 5px;">
       이전글 :
        <c:if test="${not empty preReadDto}">
	      	<c:choose>
	      		<c:when test="${preReadDto.questionPrivate==1}">
	      			<i class="fa fa-lock" title="공개여부" style="color: #333333;"></i>
	      			<c:if test="${sessionScope.member.userId==preReadDto.userId || fn:indexOf(sessionScope.member.userId,'admin') == 0}">
	      				<a href="<%=cp%>/qna/article?${query}&pageNo=${pageNo}&qnaNum=${preReadDto.qnaNum}">${preReadDto.subject}</a>
	      			</c:if>
	      			<c:if test="${sessionScope.member.userId!=preReadDto.userId && fn:indexOf(sessionScope.member.userId,'admin') != 0}">
	      				${preReadDto.subject}
	      			</c:if>
	      		</c:when>
	      		<c:otherwise>
	      			<a href="<%=cp%>/qna/article?${query}&pageNo=${pageNo}&qnaNum=${preReadDto.qnaNum}">${preReadDto.subject}</a>
	      		</c:otherwise>
	      	</c:choose>
        </c:if>
    </td>
</tr>

<tr height="35" style="border-bottom: 1px solid #cccccc;">
    <td colspan="2" align="left" style="padding-left: 5px;">
       다음글 :
        <c:if test="${not empty nextReadDto}">
	      	<c:choose>
	      		<c:when test="${nextReadDto.questionPrivate==1}">
	      			<i class="fa fa-lock" title="공개여부" style="color: #333333;"></i>
	      			<c:if test="${sessionScope.member.userId==nextReadDto.userId || fn:indexOf(sessionScope.member.userId,'admin') == 0}">
	      				<a href="<%=cp%>/qna/article?${query}&pageNo=${pageNo}&qnaNum=${nextReadDto.qnaNum}">${nextReadDto.subject}</a>
	      			</c:if>
	      			<c:if test="${sessionScope.member.userId!=nextReadDto.userId && fn:indexOf(sessionScope.member.userId,'admin') != 0}">
	      				${nextReadDto.subject}
	      			</c:if>
	      		</c:when>
	      		<c:otherwise>
	      			<a href="<%=cp%>/qna/article?${query}&pageNo=${pageNo}&qnaNum=${nextReadDto.qnaNum}">${nextReadDto.subject}</a>
	      		</c:otherwise>
	      	</c:choose>
        </c:if>
    </td>
</tr>
</table>

<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
<tr height="45">
    <td width="400" align="left">
        <c:if test="${sessionScope.member.userId==questionDto.userId}">
            <button type="button" class="btn" onclick="updateQuestion();">질문수정</button>
        </c:if>
        <c:if test="${sessionScope.member.userId==questionDto.userId || fn:indexOf(sessionScope.member.userId,'admin') == 0}">
            <button type="button" class="btn" onclick="deleteQuestion();">질문삭제</button>
        </c:if>
        <c:if test="${fn:indexOf(sessionScope.member.userId,'admin') == 0 && empty answerDto}">
            <button type="button" class="btn" onclick="insertAnswer();">답변</button>
        </c:if>
        <c:if test="${not empty answerDto and fn:indexOf(sessionScope.member.userId,'admin') == 0}">
            <button type="button" class="btn" onclick="updateAnswer();">답변수정</button>
        </c:if>
        <c:if test="${not empty answerDto && fn:indexOf(sessionScope.member.userId,'admin') == 0}">
            <button type="button" class="btn" onclick="deleteAnswer();">답변삭제</button>
        </c:if>
    </td>

    <td align="right">
        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/qna/list?${query}&pageNo=${pageNo}';">리스트</button>
    </td>
</tr>
</table>
</div>