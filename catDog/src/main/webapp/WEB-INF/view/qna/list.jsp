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
function searchList() {
	var f=document.searchForm;
	f.submit();
}
</script>

<div class="body-container" style="width: 830px; margin: 20px auto 0px; border-spacing: 0px;">

<div class="body-title">
		<h3><span style="font-family: Webdings"></span> QnA </h3>
</div>

<div class="alert-info">
  <i class="fas fa-info-circle"></i>
    궁금하신 질문을 해달라냥!
</div>

<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
   <tr height="35">
      <td align="left" width="50%">
          ${dataCount}개(${pageNo}/${total_page} 페이지)
      </td>
      <td align="right">
          &nbsp;
      </td>
   </tr>
</table>

<table style="width: 100%; margin: 0px auto; border-spacing: 0px; border-collapse: collapse;">
  <tr align="center" bgcolor="#eeeeee" height="35" style="border-top: 2px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
      <th width="60" style="color: #787878;">번호</th>
      <th width="100" style="color: #787878;">유형</th>
      <th style="color: #787878;">제목</th>
      <th width="100" style="color: #787878;">작성자</th>
      <th width="80" style="color: #787878;">문의일자</th>
      <th width="80" style="color: #787878;">처리결과</th>
  </tr>
 
<c:forEach var="dto" items="${list}">
  <tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;"> 
      <td>${dto.listNum}</td>
      <td>${dto.qnaCategory}</td>
      <td align="left" style="padding-left: 10px;">
      	<c:choose>
      		<c:when test="${dto.questionPrivate==1}">
      			<i class="fa fa-lock" title="공개여부" style="color: #333333;"></i>
      			<c:if test="${sessionScope.member.userId==dto.userId || fn:indexOf(sessionScope.member.userId,'admin') == 0}">
      				<a href="${articleUrl}&qnaNum=${dto.qnaNum}">${dto.subject}</a>
      			</c:if>
      			<c:if test="${sessionScope.member.userId!=dto.userId && fn:indexOf(sessionScope.member.userId,'admin') != 0}">
      				${dto.subject}
      			</c:if>
      		</c:when>
      		<c:otherwise>
      			<a href="${articleUrl}&qnaNum=${dto.qnaNum}">${dto.subject}</a>
      		</c:otherwise>
      	</c:choose>
      </td>
      <td>${dto.nickName}</td>
      <td>${dto.created}</td>
      <td>${dto.isAnswer==1?"답변완료":"답변대기"}</td>
  </tr>
  </c:forEach>

</table>
 
<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
   <tr height="35">
	<td align="center">
       ${dataCount==0?"등록된 게시물이 없습니다.":paging}
	</td>
   </tr>
</table>

<table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
   <tr height="40">
      <td align="left" width="100">
          <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/qna/list';">새로고침</button>
      </td>
      <td align="center">
          <form name="searchForm" action="<%=cp%>/qna/list" method="post">
              <select id="condition" name="condition" class="selectField">
                  <option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
                  <option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
                  <option value="nickName" ${condition=="nickName"?"selected='selected'":""}>작성자</option>
                  <option value="created" ${condition=="created"?"selected='selected'":""}>작성일</option>
            </select>
            <input type="text" id="keyword" name="keyword" class="boxTF" value="${keyword}">
            <button type="button" class="btn" onclick="searchList();">검색</button>
        </form>
      </td>
      <td align="right" width="100">
          <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/qna/created';">질문하기</button>
      </td>
   </tr>
</table>
</div>