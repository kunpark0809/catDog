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
    padding: 10px 0;
    text-align: center;
    display: inline-block;
    font-size: 15px;
    margin: 4px;
    border-radius:10px;
}
.imgLayout{
	width: 190px;
	height: 205px;
	padding: 10px 5px 10px;
	margin: 5px;
	border: 1px solid #DAD9FF;
	cursor: pointer;
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
					<p class="section-heading text-uppercase" style="font-size: 40px; border-bottom: 2px solid;">공원/산책</p>
				</div>
			</div>
			
			
			<table style="width: 100%; margin: 10px auto; border-spacing: 0px; background-color: #F5F5F5;">
		   <tr height="40">
		      <td align="center">
		          <form name="searchForm" action="<%=cp%>/park/list" method="post" style="width: 100%">
		              	<select name="condition" class="selectField">
		                  <option value="placeName" ${condition=="placeName"?"selected='selected'":""}>제목</option>
		                  <option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
		            	</select>
		            <input type="text" name="keyword" value="${keyword}" class="boxTF" size="50;">
		            <button type="button" class="btn" onclick="searchList()">검색</button>
		         </form>
		      </td>
		      <tr>
		      <td align="left">
		          <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/park/list';">새로고침</button>
		      </td>
		      <td align="right">
		          <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/park/created';">등록하기</button>
		      </td>	      
		  	 </tr>
		</table>
    

		<div class="parklist">	
			<c:forEach var="dto" items="${list}">
				<img alt="" src="<%=cp%>/uploads/park/${dto.imageFileName}" width="400">
					<p>${dto.placeName}</p>
					<p>${dto.content}</p>	
					<p><i class="fas fa-eye"></i>&nbsp;&nbsp;${dto.hitCount}</p>	
			</c:forEach>
		</div>

		
	</div>
</section>