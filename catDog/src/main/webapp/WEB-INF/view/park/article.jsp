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
</style>

<script type="text/javascript">
function deletePark() {
<c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId==dto.userId}">
	var q = "recommendNum=${dto.recommendNum}&${query}";
    var url = "<%=cp%>/park/delete?" + q;

    if(confirm("해당 게시물을 삭제하시겠습니까?"))
  	  location.href=url;
</c:if>

<c:if test="${sessionScope.member.userId!='admin' && sessionScope.member.userId!=dto.userId}">
  alert("해당 게시물을 삭제할 수 없습니다.");
</c:if>
}

function updatePark() {
<c:if test="${sessionScope.member.userId==dto.userId}">
	var q = "recommendNum=${dto.recommendNum}&page=${page}";
    var url = "<%=cp%>/park/update?" + q;

    location.href=url;
</c:if>

<c:if test="${sessionScope.member.userId!=dto.userId}">
   alert("게시물을 수정할 수  없습니다.");
</c:if>
}
</script>


<div class="page-section" id="command" style="text-align: center;">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<p class="section-heading text-uppercase" style="font-size: 40px; border-bottom: 2px solid;">공원/산책</p>
				</div>
				
		<table style="width: 98%; margin: 10px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td width="50%" align="left" style="padding-bottom: 20px; padding-left: 20px; font-size: 20px;">
			        ${list.get(0).placeName}
			    </td>
			    <td width="50%" align="right" style="padding-bottom: 20px; font-size: 15px;">
			         날짜&nbsp;&nbsp;${list.get(0).created}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;조회수&nbsp;&nbsp;${list.get(0).hitCount}
			    </td>
			</tr>
			
			<tr>
			<td colspan="2" align="center" style="padding: 10px 5px;">
			<br><br>
			     <c:forEach var="dto" items="${list}">
				<img alt="" src="<%=cp%>/uploads/park/${dto.imageFileName}">
				</c:forEach> 
			  </td>
			</tr>
						
			<tr style="border-bottom: 1px solid #cccccc;">
			  <td colspan="2" align="center" style="padding: 10px 5px;" valign="top" height="50">
			       ${list.get(0).content}
			       <br><br>
			   </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
			       <i class="fas fa-chevron-up"></i>&nbsp;&nbsp;
			         <c:if test="${not empty preReadPark}">
			              <a href="<%=cp%>/park/article?${query}&recommendNum=${preReadPark.recommendNum}">${preReadPark.placeName}</a>
			        </c:if>
			    </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
			       <i class="fas fa-chevron-down"></i>&nbsp;&nbsp;
			         <c:if test="${not empty nextReadPark}">
			              <a href="<%=cp%>/park/article?${query}&recommendNum=${nextReadPark.recommendNum}">${nextReadPark.placeName}</a>
			        </c:if>
			    </td>
			</tr>
			</table>
			
			<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
			<tr height="45">
			    <td width="300" align="left">
			    <br>
			        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/park/list?${query}';">리스트</button>
			    </td>
			    
			    <td align="right">
			       <c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">				    
			          <button type="button" class="btn" onclick="updatepark();">수정</button>
			       </c:if>
			       <c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">				    
			          <button type="button" class="btn" onclick="deletepark();">삭제</button>
			       </c:if>
			    </td>
			</tr>
			</table>
    	</div>
    </div>
</div>