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
.subject {
     width:180px;
     height:25px;
     line-height:25px;
     margin:5px auto;
     border-top: 1px solid #DAD9FF;
     display: inline-block;
     white-space:nowrap;
     overflow:hidden;
     text-overflow:ellipsis;
     cursor: pointer;
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

<div class="body-container" style="width: 630px; margin: 20px auto 10px; text-align: center;">
	<div class="body-title">
		<h3>내새끼자랑</h3>
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
	
		<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			<c:forEach var="dto" items="${list}" varStatus="status">
				<c:if test="${status.index==0}">
					<tr>
				</c:if>
				<c:if test="${status.index!=0 && status.index%3==0}">
					<c:out value="</tr><tr>" escapeXml="false"/>
				</c:if>
				<td width="210" align="center">
					<div class="imgLayout">
						<img src="<%=cp%>/uploads/pet/${dto.imageFileName}" width="180" 
						height="180" border="0" onclick="article('${dto.myPetNum}');">
						<span class="subject" onclick="article('${dto.myPetNum}');" >
						${dto.subject}
						</span>
					</div>
				</td>
			</c:forEach>
			
			<c:set var="n" value="${list.size()}"/>
			<c:if test="${n>0&&n%3!=0}">
				<c:forEach var="i" begin="${n%3+1}" end="3" step="1">
					<td width="210">
						<div class="imgLayout">&nbsp;</div>
					</td>
				</c:forEach>
			</c:if>
			
			<c:if test="${n!=0 }">
				<c:out value="</tr>" escapeXml="false"/>
			</c:if>
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
					<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/pet/list';">새로고침</button>
				</td>
				<td align="center">
					<form name="searchForm" action="<%=cp%>/pet/list" method="post">
						<select name="condition" class="selectField">
							<option value="all" ${condition=="all"?"selected='selected'":""}>모두</option>
							<option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
							<option value="created" ${condition=="created"?"selected='selected'":""}>등록일</option>
						</select>
						<input type="text" name="keyword" value="${keyword}" class="boxTF">
						<button type="button" class="btn" onclick="searchList()">검색</button>
					</form>
				</td>
				<td align="right" width="100">
					<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/pet/created';">등록하기</button>
				</td>
			</tr>
		</table>
	</div>

</div>