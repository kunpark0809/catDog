<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/tabs.css" type="text/css">

<script type="text/javascript">

$(function(){
	
	$("#tab-${group}").addClass("active");
	
	$("ul.tabs li").click(function(){
		tab = $(this).attr("data-tab");
		
		$("ul.tabs li").each(function(){
			$(this).removeClass("active");
		});
	
		$("#tab-"+tab).addClass("active");
	
		var url = "<%=cp%>/admin/bbs?group="+tab;
		location.href=url
		
	});

});

</script>


<div class="body-container" style="width: 1100px; margin: 0px auto;">
	<div class="body-title">
		<h3><i class="fas fa-comments"></i> 수다방 관리</h3>
	</div>

	<div>
<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
		   <tr height="35">
		      <td align="left" width="50%">
		          ${dataCount}개(${page}/${total_page} 페이지)
		      </td>
		      <td align="right">
		          &nbsp;
		      </td>
		   </tr>
		</table>
		
		<div style="clear: both;">
			<ul class="tabs">
				<li id="tab-0" data-tab="0">전체</li>
				<li id="tab-1" data-tab="1">
					꿀팁</li>
				<li id="tab-2" data-tab="2">
					내새끼자랑</li>
				<li id="tab-3" data-tab="3">
					멍냥수다방</li>
				
				
			</ul>
		</div>
		
		
		<table style="width: 100%; margin: 0px auto; border-spacing: 0px; border-collapse: collapse;">
		  <tr align="center" bgcolor="#eeeeee" height="35" style="border-top: 2px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
		      <th width="90" style="color: #787878;">신고번호</th>
		      <th width="150" style="color: #787878;">게시판</th>
		      <th style="color: #787878;">신고분류</th>
		      <th width="190" style="color: #787878;">신고자</th>
		      <th width="190" style="color: #787878;">피신고자</th>
		      <th width="120" style="color: #787878;">신고일</th>
		  </tr>
		 
		<c:forEach var="dto" items="${list}">
		  <tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;"> 
		      <td>${dto.reportNum }</td>
		      <td>${dto.boardSort==1?'꿀팁':dto.boardSort==2?'내새끼자랑':'멍냥수다방' }</td>
		      <td>
		           ${dto.reasonName }
		      </td>
		      <td>${dto.reporterNickName}(${dto.reporterId})</td>
		      <td>${dto.reportedNickName}(${dto.reportedId})</td>
		      <td>${dto.reportDate }</td>
		  </tr>
		  </c:forEach>

		</table>
		 
		<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
		   <tr height="35">
			<td align="center">
			       ${dataCount==0?"신고글이 없습니다.":paging}
			 </td>
		   </tr>
		</table>
		
		<table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
		   <tr height="40">
		      <td align="left" width="70" style="padding-left: 20px;">
		          <button type="button" class="btnConfirm" onclick="javascript:location.href='<%=cp%>/admin/bbs';">초기화</button>
		      </td>
		      <td align="left" width="200" style="padding-left: 150px;">
		          <form name="searchForm" action="<%=cp%>/admin/bbs" method="post">
		              <select name="condition" class="selectField">
		                  <option value="all" ${condition=="all"?"selected='selected'":""}>모두</option>
		                  <option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
		                  <option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
		                  <option value="userName" ${condition=="userName"?"selected='selected'":""}>작성자</option>
		                  <option value="created" ${condition=="created"?"selected='selected'":""}>등록일</option>
		            </select>
		            <input type="text" name="keyword" value="${keyword}" class="boxTF">
		            <button type="button" class="btnconFirm" onclick="searchList()">검색</button>
		        </form>
		      </td>
		      
		   </tr>
		</table>

		
	</div>

</div>