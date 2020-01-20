<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/tabs.css"
	type="text/css">

<style type="text/css">
ul.tabs li.active{
	    font-weight: 700;
		border: 0px;
	    border-bottom-color:  transparent;
}

td {
	white-space: nowrap; 
	text-overflow: ellipsis; 
	overflow: hidden;
}

.selectField {
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
	var f = document.searchForm;
	f.submit();
}

function judgement(reportNum, reportedId){
	var judgement = document.getElementById("judgement").value;
	
	if(!judgement){
		return;
	}
	
	location.href = "<%=cp%>/admin/bbs/judgement?reportNum="+reportNum+"&judgement="+judgement+"&reportedId="+reportedId;

}


$(function(){
	
	$("#tab-${group}").addClass("active");
	
	$("ul.tabs li").click(function(){
		tab = $(this).attr("data-tab");
		
		$("ul.tabs li").each(function(){
			$(this).removeClass("active");
		});
	
		$("#tab-"+tab).addClass("active");
	
		var url = "<%=cp%>/admin/bbs?group=" + tab;
			location.href = url
		});

	});
</script>


<div class="body-container" style="width: 1250px; min-height:490px; padding-top:60px; margin: 0px auto;">
	<div class="body-title">
		<h3>
			<i class="fas fa-comments"></i> 신고 관리
		</h3>
	</div>

	<div>
		<table
			style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
			<tr height="35">
				<td align="left" width="50%">
					${dataCount}개(${page}/${total_page} 페이지)</td>
				<td align="right">&nbsp;</td>
			</tr>
		</table>

		<div style="clear: both;">
			<ul class="tabs">
				<li id="tab-0" data-tab="0">전체</li>
				<li id="tab-1" data-tab="1">꿀팁</li>
				<li id="tab-2" data-tab="2">멍냥 자랑</li>
				<li id="tab-3" data-tab="3">자유게시판</li>


			</ul>
		</div>


		<table
			style="width: 100%; margin: 0px auto; border-spacing: 0px; border-collapse: collapse;">
			<tr align="center" bgcolor="#eeeeee" height="35"
				style="color:white; background-color:#51321b;">
				<th width="130" style="padding-left: 5px;">신고번호</th>
				<th width="100">게시판</th>
				<th width="150">신고분류</th>
				<th width="190">신고자</th>
				<th width="190">피신고자</th>
				<th width="190">신고일</th>
				<th>글 보기</th>
				<th width="100">처리여부</th>
			</tr>

			<c:forEach var="dto" items="${list}">
				<tr align="center" bgcolor="#ffffff" height="35"
					style="border-bottom: 1px solid #cccccc;">
					<td>${dto.reportNum }</td>
					<td>${dto.boardSort==1?'꿀팁':dto.boardSort==2?'멍냥 자랑':'자유게시판' }</td>
					<td>${dto.reasonName }</td>
					<td>${dto.reporterNickName}(${dto.reporterId})</td>
					<td>${dto.reportedNickName}(${dto.reportedId})</td>
					<td>${dto.reportDate }</td>
					<td>
						<c:choose>
							<c:when test="${dto.boardSort==1}">
								<button class="yellowBts" style="width: 130px; padding: 0px;"
								onclick="window.open('<%=cp%>/tip/article?tipNum=${dto.reportedPostNum}')">꿀팁(${dto.reportedPostNum})</button>
							</c:when>
							<c:when test="${dto.boardSort==2}">
								<button class="yellowBts" style="width: 130px; padding: 0px;"
									onclick="window.open('<%=cp%>/pet/article?myPetNum=${dto.reportedPostNum}')">멍냥 자랑(${dto.reportedPostNum})</button>
							</c:when>
							<c:when test="${dto.boardSort==3}">
								<button class="yellowBts" style="width: 130px; padding: 0px;"
								onclick="window.open('<%=cp%>/freeBoard/article?bbsNum=${dto.reportedPostNum}')">자유게시판(${dto.reportedPostNum})</button>
							</c:when>
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${dto.judgement==0}">
								<select id="judgement"
								onchange="judgement('${dto.reportNum }', '${dto.reportedId}')">
									<option value="">처리 중</option>
									<option value="innocent">무혐의</option>
									<option value="guilty">경고</option>
								</select>
							</c:when>
							<c:when test="${dto.judgement!=0}">
								<c:choose>
									<c:when test="${dto.judgement==1}">
									무혐의
									</c:when>
									<c:otherwise>
									경고
									</c:otherwise>
								</c:choose>
							</c:when>
						</c:choose>
					</td>
				</tr>
			</c:forEach>

		</table>

		<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			<tr height="35">
				<td align="center">${dataCount==0?"신고글이 없습니다.":paging}</td>
			</tr>
		</table>

		<table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
			<tr height="40">
				<td align="left" width="70" style="padding-left: 20px;">
					<button type="button" class="bts"
						onclick="javascript:location.href='<%=cp%>/admin/bbs';">새로고침</button>
				</td>
				<td align="left" width="200" style="padding-left: 250px;">
					<form name="searchForm" action="<%=cp%>/admin/bbs" method="post">
						<select name="condition" class="selectField">
							<option value="all" ${condition=="all"?"selected='selected'":""}>모두</option>
							<option value="userId"
								${condition=="userId"?"selected='selected'":""}>ID</option>
							<option value="nickName"
								${condition=="nickName"?"selected='selected'":""}>닉네임</option>
							<option value="reasonName"
								${condition=="reasonName"?"selected='selected'":""}>신고분류</option>
						</select> <input type="text" name="keyword" value="${keyword}"
							class="boxTF">
						<button type="button" class="bts" onclick="searchList()" style="width: 5%;"><i class="fas fa-search"></i></button>
						<input type="hidden" name="group" value="${group }"> <input
							type="hidden" name="page" value="${page }">

					</form>
				</td>

			</tr>
		</table>


	</div>

</div>