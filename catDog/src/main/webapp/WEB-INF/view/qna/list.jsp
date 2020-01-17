<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String cp=request.getContextPath();
%>
<style type="text/css">
.selectField {
width: 70px;
background-color: white;
border: 2px solid #51321b;
color: black;
padding: 3px 0;
text-align: center;
display: inline-block;
font-size: 15px;
margin: 2px;
}

.boxTF {
width: 300px;
background-color: white;
border: 2px solid #51321b;
color: black;
padding: 3px 0;
text-align: center;
display: inline-block;
font-size: 15px;
margin: 2px;
}
</style>
<link rel="stylesheet" href="<%=cp%>/resource/css/cs.css">
<link rel="stylesheet" href="<%=cp%>/resource/css/tabs.css" type="text/css">
<script type="text/javascript">
function searchList() {
	var f=document.searchForm;
	f.submit();
}

$(function(){
	
	$("#tab-${qnaCategoryNum}").addClass("active");
	
	$("ul.tabs li").click(function(){
		tab = $(this).attr("data-tab");
		
		$("ul.tabs li").each(function(){
			$(this).removeClass("active");
		});
	
		$("#tab-"+tab).addClass("active");
	
		var url = "<%=cp%>/qna/list?qnaCategoryNum="+tab;
		location.href=url
		
	});

});
</script>

<div class="container-board">

<div class="body-title">
		<span><i class="fas fa-question-circle"></i>&nbsp;질문과 답변</span>
</div>

<table style="width: 100%;  border-spacing: 0px;">
   <tr height="35">
      <td align="left" width="50%">
          <span style="color: #D96262;">${dataCount}</span>개(<span style="color: #D96262;">${page}</span>/${total_page} 페이지)
      </td>
      <td align="right">
          &nbsp;
      </td>
   </tr>
</table>

<div style="clear: both;">
			<ul class="tabs">
				<c:forEach var="vo" items="${categoryList}">
					<li style="text-align:center; color: #f3a34e; font-weight: bold; background-color: #ffffff;" id="tab-${vo.qnaCategoryNum}" data-tab="${vo.qnaCategoryNum}">
					${vo.qnaCategory}</li>
				</c:forEach>
			</ul>
		</div>

<table style="width: 100%; margin: 0px auto; border-spacing: 0px; border-collapse: collapse;">
  <tr align="center" bgcolor="#51321b" height="35" style="border-top: 2px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
      <th width="60" style="color: white;">번호</th>
      <th width="100" style="color: white;">유형</th>
      <th style="color: white;">제목</th>
      <th width="100" style="color: white;">작성자</th>
      <th width="100" style="color: white;">문의일자</th>
      <th width="80" style="color: white;">처리결과</th>
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
      				<a href="${articleUrl}&qnaNum=${dto.qnaNum}" style="color: black;">${dto.subject}</a>
      			</c:if>
      			<c:if test="${sessionScope.member.userId!=dto.userId && fn:indexOf(sessionScope.member.userId,'admin') != 0}">
      				${dto.subject}
      			</c:if>
      		</c:when>
      		<c:otherwise>
      			<a href="${articleUrl}&qnaNum=${dto.qnaNum}" style="color: black;">${dto.subject}</a>
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
          <button type="button" class="bts" onclick="javascript:location.href='<%=cp%>/qna/list';">새로고침</button>
      </td>
      <td align="center">
          <form name="searchForm" action="<%=cp%>/qna/list" method="post">
              <select id="condition" name="condition" class="selectField">
                  <option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
                  <option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
                  <option value="nickName" ${condition=="nickName"?"selected='selected'":""}>작성자</option>
                  <option value="created" ${condition=="created"?"selected='selected'":""}>작성일</option>
            </select>
            <input type="text" id="keyword" name="keyword" class="boxTF" value="${keyword}" size="30;">
            <button type="button" class="bts" onclick="searchList();"><i class="fas fa-search"></i></button>
        </form>
      </td>
      <td align="right" width="100">
          <button type="button" class="bts" onclick="javascript:location.href='<%=cp%>/qna/created';">질문하기</button>
      </td>
   </tr>
</table>
</div>