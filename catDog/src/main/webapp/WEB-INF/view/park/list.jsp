<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<style type="text/css">
.btn {
	width:70px;
    background-color: #262626;
    border: none;
    color:#ffffff;
    padding: 6px 0;
    text-align: center;
    display: inline-block;
    font-size: 15px;
    margin: 4px;
    border-radius:10px;
}

</style>

<script type="text/javascript">
function searchList() {
	var f=document.searchForm;
	f.submit();
}



</script>

	<section class="page-section" id="command" style="text-align: center;">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<p class="section-heading text-uppercase" style="font-size: 45px; font-weight: bold;">공원/산책</p>
				</div>
			</div>
			
			<table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
		   <tr height="40">
		      <td align="right">
		          <form name="searchForm" action="<%=cp%>/park/list" method="post" style="width: 100%;  border-bottom: 3px solid; border-bottom-width: 100%; padding-bottom: 10px;">
		              	<select name="condition" class="selectField" style="border-radius:5px;">
		                  <option value="placeName" ${condition=="placeName"?"selected='selected'":""}>제목</option>
		                  <option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
		            	</select>
		            <input type="text" name="keyword" value="${keyword}" class="boxTF" size="30;" style="border-radius:5px;">
		            <button type="button" class="btn" onclick="searchList()">검색</button>
		         </form>
		      </td>
		      </tr>
		      </table>
		      
		      <table>
		      <tr>
		      <td align="left">
		      <c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId=='admin2' || sessionScope.member.userId=='admin3'}">
		          <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/park/list';">새로고침</button>
		      </c:if>
		      </td>
		      <td align="left">
		      <c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId=='admin2' || sessionScope.member.userId=='admin3'}">
		          <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/park/created';">등록하기</button>
		      </c:if>
		      </td>	      
		  	 </tr>
			</table>
  
	<div class="parklist">	
			<c:forEach var="dto" items="${list}">
				<a onclick="javascript:location.href='${articleUrl}&recommendNum=${dto.recommendNum}'" style="color: #262626;">
					<input type="hidden" value="${dto.recommendNum}">
					<img alt="" src="<%=cp%>/uploads/park/${dto.imageFileName}" width="400" style="padding-top: 15px;"><br>
					<span class="placeName" onclick="javascript:article('${dto.recommendNum}');" style="font-weight: bold; font-size: 24px;">${dto.placeName}</span><br>
				</a>
					<p><i class="fas fa-eye"></i>&nbsp;&nbsp;${dto.hitCount}</p>
				
			</c:forEach>
		</div>
		
		<div class="paging">
			${dataCount==0?"게시판에 등록된 글이 없습니다.":paging}
		</div>
		</div>

		
	
</section>