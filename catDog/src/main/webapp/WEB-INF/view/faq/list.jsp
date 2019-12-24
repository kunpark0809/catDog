<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String cp=request.getContextPath();
%>

<script src="<%=cp%>/resource/vendor/jquery/jquery.min.js"></script>

<script type="text/javascript">
function searchList() {
	var f=document.searchForm;
	f.submit();
}

$(function(){
    $("table").on('click', '.faqSub', function () {
    	
    	var num = $(this).attr("data-subjectNum");
    	
      	if( $("#contentNum"+num).is(":visible") ){
            $("#contentNum"+num).hide(300);
        }
      	else if(!$("#contentNum"+num).is(":visible")){
    		$("#contentNum"+num).show(300);
        } 
   });
 });

 
</script>



<div class="body-container" style="width: 830px; margin: 20px auto 0px; border-spacing: 0px;">

<div class="body-title">
		<h3><span style="font-family: Webdings"></span> FAQ </h3>
</div>

<div class="alert-info">
  <i class="fas fa-info-circle"></i>
     자주 묻는 질문을 모아놨다냥!
</div>

<table style="width: 100%; margin: 50px auto; border-spacing: 0px; border-collapse: collapse;">
  <tr align="center" bgcolor="#eeeeee" height="35" style="border-top: 2px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
      <th width="60" style="color: #787878;">번호</th>
      <th style="color: #787878;">제목</th>
      <th width="100" style="color: #787878;">작성자</th>
  </tr>
 
<c:forEach var="dto" items="${list}">
  <tr class="faqSub" align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;" data-subjectNum="${dto.faqNum}"> 
      <td>${dto.listNum}</td>
      <td align="left" style="padding-left: 10px;">
      	${dto.subject}     	
      </td>
      <td>멍냥개냥</td>
  </tr>
  <tr class="faqCon" align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc; display: none;" id="contentNum${dto.faqNum}" >  	
      <td colspan="3" align="center" style="padding-left: 10px;">
      	${dto.content}  
      	<button type="button" class="btn" onclick="updateFaq();" ${fn:indexOf(sessionScope.member.userId,'admin') == 0 ? "style='pointer-events:none;'":""}>수정</button>
		<button type="button" class="btn" onclick="deleteFaq();" ${fn:indexOf(sessionScope.member.userId,'admin') == 0 ? "style='pointer-events:none;'":""}>삭제</button> 	
      </td>     
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
          <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/faq/list';">새로고침</button>
      </td>
      <td align="center">
          <form name="searchForm" action="<%=cp%>/faq/list" method="post">
              <select id="condition" name="condition" class="selectField">
                  <option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
                  <option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
            </select>
            <input type="text" id="keyword" name="keyword" class="boxTF" value="${keyword}">
            <button type="button" class="btn" onclick="searchList();">검색</button>
        </form>
      </td>
      <td align="right" width="100">
      <c:if test="${fn:indexOf(sessionScope.member.userId,'admin') == 0}">
          <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/faq/created';">등록하기</button>
      </c:if>
      </td>
   </tr>
</table>

</div>