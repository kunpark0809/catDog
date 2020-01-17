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

</style>

<script type="text/javascript">
function searchList() {
	var f=document.searchForm;
	f.submit();
}

function article(myPetNum) {
	var url="${articleUrl}&myPetNum="+myPetNum;
	location.href=url;
}

</script>

<div class="wide-container">
	 <div class="body-title">
		<span style="font-family: Webdings"><i class="fas fa-paw"></i> 멍냥 자랑</span>
	</div>
	<br>
	<table style="border-spacing: 0px; border-collapse: collapse; margin: 0px auto;">
			<c:forEach var="dto" items="${list}" varStatus="status">
				     <c:if test="${status.index==0}">
                    		  <tr>
	                 </c:if>
	                 <c:if test="${status.index!=0 && status.index%4==0}">
	                       <c:out value="</tr><tr>" escapeXml="false"/>
	                 </c:if>
					
						<td width="20%" style="text-align: center;">
							<div class="link" onclick="javascript:location.href='${articleUrl}&myPetNum=${dto.myPetNum}'">
									<img alt="" src="<%=cp%>/uploads/pet/${dto.imageFileName}" width="280" height="320" style="margin: 5px;">
									
						<p style="border-bottom: 2px solid #cccccc; margin: 5px; font-weight: bold;">
						<span>${dto.subject}&nbsp;&nbsp;&nbsp;</span><i class="fas fa-heart" style="color: #d96262;"></i>&nbsp;&nbsp;&nbsp;<span>${dto.nickName}</span>
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
		 <br>
		<table style=" border-spacing: 0px;  margin: 0px auto;">
		   <tr height="40">
		      <td align="left" width="100">
		          <button type="button" class="bts" onclick="javascript:location.href='<%=cp%>/pet/list';">새로고침</button>
		      </td>
		     
		      <td align="center">
		          <form name="searchForm" action="<%=cp%>/pet/list" method="post">
		              <select name="condition" class="selectField" style="border-radius: 5px;">
		                  <option value="all" ${condition=="all"?"selected='selected'":""}>모두</option>
		                  <option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
		                  <option value="nickName" ${condition=="nickName"?"selected='selected'":""}>닉네임</option>
		                  <option value="created" ${condition=="created"?"selected='selected'":""}>등록일</option>
		            </select>
		            <input type="text" name="keyword" value="${keyword}" class="boxTF" style="border-radius: 5px;">
		            <button type="button" class="bts" onclick="searchList();">검색</button>
		        </form>
		      </td>
		      <td align="right" width="100">
		       <c:if test="${not empty sessionScope}">
		          <button type="button" class="bts" onclick="javascript:location.href='<%=cp%>/pet/created'">글올리기</button>
		       </c:if>
		      </td>
		   </tr>
		</table>
    </div>
