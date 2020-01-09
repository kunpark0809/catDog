<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%> 
<script type="text/javascript">
	function searchList() {
		var f=document.searchForm;
		f.submit();
	}
</script>
<link rel="stylesheet" href="<%=cp%>/resource/css/dogshop.css">
<div class="shin_body">
    <div class="body-title">
        <h3><i class="fas fa-chalkboard"></i>입양 게시판 </h3>
        
    </div>
    
    <div>

		
		<table style="border-spacing: 0px; border-collapse: collapse; margin: 0px auto;">

			<c:forEach var="dto" items="${list}" varStatus="status">
				     <c:if test="${status.index==0}">
                    		  <tr>
	                 </c:if>
	                 <c:if test="${status.index!=0 && status.index%4==0}">
	                       <c:out value="</tr><tr>" escapeXml="false"/>
	                 </c:if>
					
						<td width="20%" style="text-align: center;">
							<div class="link" onclick="javascript:location.href='${articleUrl}&adoptionNum=${dto.adoptionNum}'">
									<img alt="" src="<%=cp%>/uploads/adopt/${dto.imageFileName}" width="200" height="200">
									
								<p>
									<c:if test="${dto.status=='0'}">
										<span style="display: inline-block;padding: 2px 8px;background: #d96262;border-radius: 3px; color: #FFFFFF;">입양완료</span>
									</c:if>
									&nbsp;<span style="margin: 0px;">${dto.subject}</span>
								</p>
							</div>
						</td>
			</c:forEach>
		</table>
		 
		<table style="border-spacing: 0px;  margin: 0px auto;" >
		   <tr height="35">
			<td align="center">
			       ${dataCount==0?"등록된 게시물이 없습니다.":paging}
			 </td>
		   </tr>
		</table>
		
		<table style=" border-spacing: 0px;  margin: 0px auto;">
		   <tr height="40">
		      <td align="left" width="100">
		          <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/adopt/list';">새로고침</button>
		      </td>
		      <td align="center">
		          <form name="searchForm" action="<%=cp%>/adopt/list" method="post">
		              <select name="condition" class="selectField">
		                  <option value="all" ${condition=="all"?"selected='selected'":""}>모두</option>
		                  <option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
		                  <option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
		                  <option value="nickName" ${condition=="nickName"?"selected='selected'":""}>닉네임</option>
		                  <option value="created" ${condition=="created"?"selected='selected'":""}>등록일</option>
		            </select>
		            <input type="text" name="keyword" value="${keyword}" class="boxTF">
		            <button type="button" class="btn" onclick="searchList();">검색</button>
		        </form>
		      </td>
		      <td align="right" width="100">
		          <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/adopt/created'">글올리기</button>
		      </td>
		   </tr>
		</table>
    </div>

</div>