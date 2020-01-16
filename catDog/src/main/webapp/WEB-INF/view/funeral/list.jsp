<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<style type="text/css">
.bts {
width: 70px;
background-color: #51321b;
border: none;
color: #ffffff;
padding: 6px 0;
text-align: center;
display: inline-block;
font-size: 15px;
margin: 4px;
border-radius: 5px;
}

.selectField {
width: 60px;
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

.place_image {
   width:400px;
   height:450px;
   border: none;
   margin-right: 3px;
   border-radius: 40px;
   overflow:hidden;

}

.place_image  img {
	-webkit-transform:scale(1);
	transform:scale(1);
	-webkit-transition:.3s;
	transition:.3s;
}
.place_image:hover img {
	-webkit-transform:scale(1.1);
	transform:scale(1.1);
}

</style>

<script type="text/javascript">
function searchList() {
	var f=document.searchForm;
	f.submit();
}



</script>

<div class="wide-container">
	 <div class="body-title">
		<span><i class="fas fa-feather-alt"></i> 장례식장 </span>
	</div>
			
			<table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
		   <tr height="40">
		      <td align="right">
		          <form name="searchForm" action="<%=cp%>/funeral/list" method="post" style="width: 100%;  border-bottom: 3px solid; border-bottom-width: 100%; padding-bottom: 10px; color: #d96262;">
		              	<select name="condition" class="selectField" style="border-radius:5px;">
		                  <option value="placeName" ${condition=="placeName"?"selected='selected'":""}>제목</option>
		                  <option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
		            	</select>
		            <input type="text" name="keyword" value="${keyword}" class="boxTF" size="30;" style="border-radius:5px;">
		            <button type="button" class="bts" onclick="searchList()" style="width: 5%"><i class="fas fa-search"></i></button>
		         </form>
		      </td>
		      </tr>
		     </table>
		      
		      <table>
		      <tr>
		      <td align="left">
		      <c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId=='admin2' || sessionScope.member.userId=='admin3'}">
		          <button type="button" class="bts" onclick="javascript:location.href='<%=cp%>/funeral/list';">새로고침</button>
		      </c:if>
		      </td>
		      <td align="left">
		      <c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId=='admin2' || sessionScope.member.userId=='admin3'}">
		          <button type="button" class="bts" onclick="javascript:location.href='<%=cp%>/funeral/created';">등록하기</button>
		      </c:if>
		      </td>	      
		  	 </tr>
			</table>
  

	<table style="border-spacing: 0px; border-collapse: collapse; margin: 0px auto;">
			<c:forEach var="dto" items="${list}" varStatus="status">
				     <c:if test="${status.index==0}">
                    		  <tr>
	                 </c:if>
	                 <c:if test="${status.index!=0 && status.index%3==0}">
	                       <c:out value="</tr><tr>" escapeXml="false"/>
	                 </c:if>
					
						<td width="20%" style="text-align: center;">
							<div class="place_image" onclick="javascript:location.href='${articleUrl}&recommendNum=${dto.recommendNum}'">
								<input type="hidden" value="${dto.recommendNum}">
									<img alt="" src="<%=cp%>/uploads/funeral/${dto.imageFileName}" style="padding-top: 15px; cursor:pointer; width: 380px; height: 380px; border-radius: 50px;"><br>
								<p class="placeName" onclick="javascript:article('${dto.recommendNum}');" style="font-size: 22px; font-weight:bold; margin-top: 15px; border-bottom: 2px dashed #cccccc;"><i class="fas fa-map-marker-alt" style="color: #0b9c4c">&nbsp;</i>${dto.placeName}</p>
							</div>
			</c:forEach>
		
	</table>
		
		<div class="paging">
			${dataCount==0?"게시판에 등록된 글이 없습니다.":paging}
		</div>
	</div>
