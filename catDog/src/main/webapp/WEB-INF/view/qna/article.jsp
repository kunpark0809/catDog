<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<div class="body-container" style="width: 830px; margin: 20px auto 0px; border-spacing: 0px;">
<div class="alert-info">
    <i class="fas fa-info-circle"></i>
         궁금하신 질문을 해달라냥!
</div>

<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
<tr height="35">
    <td colspan="2" align="left">
    	<span class="questionQ">질문이다냥!</span><span class="questionSubject">[${questionDto.qnaCategory}] ${questionDto.subject}</span>
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
    	<span class="answerA">A</span><span class="answerSubject">[RE] ${answerDto.subject}</span>
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
	      			<c:if test="${sessionScope.member.userId==preReadDto.userId || sessionScope.member.userId=='admin'}">
	      				<a href="<%=cp%>/qna/article?${query}&qnaNum=${preReadDto.qnaNum}">${preReadDto.subject}</a>
	      			</c:if>
	      			<c:if test="${sessionScope.member.userId!=preReadDto.userId && sessionScope.member.userId!='admin'}">
	      				${preReadDto.subject}
	      			</c:if>
	      		</c:when>
	      		<c:otherwise>
	      			<a href="<%=cp%>/qna/article?${query}&qnaNum=${preReadDto.qnaNum}">${preReadDto.subject}</a>
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
	      			<c:if test="${sessionScope.member.userId==nextReadDto.userId || sessionScope.member.userId=='admin'}">
	      				<a href="javascript:articleBoard('${nextReadDto.num}', '${pageNo}');">${nextReadDto.subject}</a>
	      			</c:if>
	      			<c:if test="${sessionScope.member.userId!=nextReadDto.userId && sessionScope.member.userId!='admin'}">
	      				${nextReadDto.subject}
	      			</c:if>
	      		</c:when>
	      		<c:otherwise>
	      			<a href="javascript:articleBoard('${nextReadDto.num}', '${pageNo}');">${nextReadDto.subject}</a>
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
            <button type="button" class="btn" onclick="updateForm('${questionDto.num}', '${pageNo}');">질문수정</button>
        </c:if>
        <c:if test="${sessionScope.member.userId==questionDto.userId || sessionScope.member.userId=='admin'}">
            <button type="button" class="btn" onclick="deleteBoard('${questionDto.num}', '${pageNo}', 'question');">질문삭제</button>
        </c:if>
        <c:if test="${sessionScope.member.userId=='admin' && empty answerDto}">
            <button type="button" class="btn" onclick="replyForm('${questionDto.num}', '${pageNo}');">답변</button>
        </c:if>
        <c:if test="${not empty answerDto and sessionScope.member.userId=='admin'}">
            <button type="button" class="btn" onclick="updateForm('${answerDto.num}', '${pageNo}');">답변수정</button>
        </c:if>
        <c:if test="${not empty answerDto && sessionScope.member.userId=='admin'}">
            <button type="button" class="btn" onclick="deleteBoard('${answerDto.num}', '${pageNo}', 'answer');">답변삭제</button>
        </c:if>
    </td>

    <td align="right">
        <button type="button" class="btn" onclick="listPage('${pageNo}')">리스트</button>
    </td>
</tr>
</table>
</div>