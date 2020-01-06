<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String cp=request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/cs.css">
<script type="text/javascript">
function searchList() {
	var f=document.searchForm;
	f.submit();
}
</script>

<div class="body-container" style="width: 830px; margin: 20px auto 0px; border-spacing: 0px;">

	<div class="body-title">
		<h3><span style="font-family: Webdings"></span> 내가 쓴 글 </h3>
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
		
		<table style="width: 100%; border-spacing: 0px; border-collapse: collapse;">
			<tr align="center" bgcolor="#eeeeee" height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				<th width="60" style="color: #787878;">번호</th>
      			<th width="100" style="color: #787878;">유형</th>
      			<th style="color: #787878;">제목</th>
      			<th width="100" style="color: #787878;">작성자</th>
      			<th width="100" style="color: #787878;">문의일자</th>
      			<th width="80" style="color: #787878;">처리결과</th>
			</tr>
		 
		<c:forEach var="dto" items="${listMpQna}">
			<tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;"> 
				<td>${dto.qnaListNum}</td>
				<td>${dto.qnaCategory}</td>
				<td align="left" style="padding-left: 10px;">
					<a href="${articleUrl}&qnaNum=${dto.qnaNum}">${dto.qnaSubject}</a>
      			</td>
				<td>${dto.nickName}</td>
				<td>${dto.qnaCreated}</td>
				<td>${dto.qnaIsAnswer==1?"답변완료":"답변대기"}</td>
			</tr>
		</c:forEach>

		</table>

		<table style="width: 100%; border-spacing: 0px;">
			<tr height="35">
				<td align="center">
					${dataCount==0 ? "등록된 자료가 없습니다." : paging}
				</td>
			</tr>
		</table>

		<table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
			<tr height="40">
				<td align="left" width="100">
					<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/mypage/myply';">새로고침</button>
				</td>
				<td align="center">
					<form name="searchForm" action="<%=cp%>/mypage/myply" method="post">
						<select name="condition" class="selectField">
							<option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
							<option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
							<option value="nickName" ${condition=="nickName"?"selected='selected'":""}>작성자</option>
							<option value="created" ${condition=="created"?"selected='selected'":""}>등록일</option>
						</select>
					    <input type="text" id="keyword" name="keyword" class="boxTF" value="${keyword}">
            			<button type="button" class="btn" onclick="searchList();">검색</button>
        			</form>
				</td>
			</tr>
		</table>
	</div>
	
	<div class="body-title">
		<h3><span style="font-family: Webdings"></span> 내새끼 자랑 </h3>
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
		
		<table style="width: 100%; border-spacing: 0px; border-collapse: collapse;">
			<tr align="center" bgcolor="#eeeeee" height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				<th width="60" style="color: #787878;">번호</th>
      			<th style="color: #787878;">제목</th>
      			<th width="100" style="color: #787878;">작성자</th>
      			<th width="100" style="color: #787878;">작성일</th>
      			<th width="100" style="color: #787878;">조회수</th>
      		</tr>
		 
		<c:forEach var="dto" items="${listMpMyPet}">
			<tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;"> 
				<td>${dto.petListNum}</td>
				<td align="left" style="padding-left: 10px;">
					<a href="${articleUrl}&myPetNum=${dto.myPetNum}">${dto.myPetSubject}</a>
      			</td>
				<td>${dto.nickName}</td>
				<td>${dto.myPetCreated}</td>
				<td>${dto.myPetHitCount}</td>
			</tr>
		</c:forEach>

		</table>

		<table style="width: 100%; border-spacing: 0px;">
			<tr height="35">
				<td align="center">
					${dataCount==0 ? "등록된 자료가 없습니다." : paging}
				</td>
			</tr>
		</table>

		<table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
			<tr height="40">
				<td align="left" width="100">
					<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/mypage/myply1';">새로고침</button>
				</td>
				<td align="center">
					<form name="searchForm" action="<%=cp%>/mypage/myply1" method="post">
						<select name="condition" class="selectField">
							<option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
							<option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
							<option value="nickName" ${condition=="nickName"?"selected='selected'":""}>작성자</option>
							<option value="created" ${condition=="created"?"selected='selected'":""}>등록일</option>
						</select>
					    <input type="text" id="keyword" name="keyword" class="boxTF" value="${keyword}">
            			<button type="button" class="btn" onclick="searchList();">검색</button>
        			</form>
				</td>
			</tr>
		</table>
	</div>
	
</div>
