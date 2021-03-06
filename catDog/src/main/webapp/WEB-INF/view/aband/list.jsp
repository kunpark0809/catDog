﻿<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%> 
<link rel="stylesheet" href="<%=cp%>/resource/css/tabs.css" type="text/css">
<script type="text/javascript">
	
	$(function(){
		$("#tab-"+${sort}).addClass("active");

		$("ul.tabs li").click(function() {
			var url = "<%=cp%>/aband/list?sort="+$(this).val();
			location.href=url;
		});
	});
</script>
<link rel="stylesheet" href="<%=cp%>/resource/css/dogshop.css">
<div class="wide-container">
	<div style="line-height: 40px;">
	<div class="body-title" style="float:left;">
        <i class="far fa-sad-tear"></i>&nbsp;유기동물 게시판    
     </div>
       
         <form name="searchForm" action="/catDog/aband/list?sort=${sort}" method="post" style="float:right;">
  

				<select name="species" class="shin_select" style="width: 120px;">
					<option value="all">애견동물전체</option>
					<option value="1" ${species=='1'?"selected='selected'":""}>강아지</option>
					<option value="0" ${species=='0'?"selected='selected'":""}>고양이</option>
				</select>
				<select name="area" class="shin_select" style="width: 100px;">
					<option value="all">지역전체</option>
					<option value="서울" ${area=='서울'?"selected='selected'":""}>서울시</option>
					<option value="인천" ${area=='인천'?"selected='selected'":""}>인천시</option>
					<option value="대전" ${area=='대전'?"selected='selected'":""}>대전시</option>
					<option value="광주" ${area=='광주'?"selected='selected'":""}>광주시</option>
					<option value="대구" ${area=='대구'?"selected='selected'":""}>대구시</option>
					<option value="울산" ${area=='울산'?"selected='selected'":""}>울산시</option>
					<option value="부산" ${area=='부산'?"selected='selected'":""}>부산시</option>
					<option value="경기" ${area=='경기'?"selected='selected'":""}>경기도</option>
					<option value="강원" ${area=='강원'?"selected='selected'":""}>강원도</option>
					<option value="세종" ${area=='세종'?"selected='selected'":""}>세종시</option>
					<option value="충남" ${area=='충남'?"selected='selected'":""}>충청남도</option>
					<option value="충북" ${area=='충북'?"selected='selected'":""}>충청북도</option>
					<option value="전남" ${area=='전남'?"selected='selected'":""}>전라남도</option>
					<option value="전북" ${area=='전북'?"selected='selected'":""}>전라북도</option>
					<option value="경남" ${area=='경남'?"selected='selected'":""}>경상남도</option>
					<option value="경북" ${area=='경북'?"selected='selected'":""}>경상북도</option>
					<option value="제주" ${area=='제주'?"selected='selected'":""}>제주도</option>
				</select>


           <button type="submit" class="bts" style="padding: 0px; margin: 0px;"><i class="fas fa-search"></i></button>
       </form>
    
	</div>

	            <div style="clear: both;">
		           <ul class="tabs" style="margin-top: 30px;  margin-bottom: 30px; ">
				       <li id="tab-0" value="0">잃어버렸어요</li>
				       <li id="tab-1" value="1"> 보호하고있어요 </li>
				   </ul>
			   </div>
		<table style="border-spacing: 0px; border-collapse: collapse; margin: 0px auto;">

			<c:forEach var="dto" items="${list}" varStatus="status">
				     <c:if test="${status.index==0}">
                    		  <tr>
	                 </c:if>
	                 <c:if test="${status.index!=0 && status.index%4==0}">
	                       <c:out value="</tr><tr>" escapeXml="false"/>
	                 </c:if>
					
						<td width="20%" style="text-align: center;">
							<div class="photoDiv" onclick="javascript:location.href='${articleUrl}&lostPetNum=${dto.lostPetNum}'">
									<img alt="" src="<%=cp%>/uploads/aband/${dto.imageFileName}" width="100%" height="350px">
								<div class="photoText">
									<c:if test="${dto.status=='0'}">
										<span style="display: inline-block;padding: 2px 8px;background: #f3a34e;border-radius: 3px; color: #FFFFFF;">해결</span>
									</c:if>
									<c:if test="${dto.status=='1'}">
									<span style="display: inline-block;padding: 2px 8px;background: #d96262;border-radius: 3px; color: #FFFFFF;">미해결</span>
										
									</c:if>
									<b class="cutText" style="width: 250px;font-weight: bold; color: white;">${dto.subject}</b>
									<p class="cutText" style="width: 250px;color: white;">지역: ${dto.addr}</p>
								</div>
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
		          <button type="button" class="bts" onclick="javascript:location.href='<%=cp%>/aband/list';">새로고침</button>
		      </td>
		      <td align="center">
		          <form name="searchForm" action="<%=cp%>/aband/list" method="post">
		              <select name="condition" class="shin_select">
		                  <option value="all" ${condition=="all"?"selected='selected'":""}>모두</option>
		                  <option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
		                  <option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
		                  <option value="nickName" ${condition=="nickName"?"selected='selected'":""}>닉네임</option>
		                  <option value="created" ${condition=="created"?"selected='selected'":""}>등록일</option>
		            </select>
		            <input type="text" name="keyword" value="${keyword}" class="shin_boxTF">
		            <button type="button" class="bts" onclick="searchList();"><i class="fas fa-search"></i></button>
		        </form>
		      </td>
		      <td align="right" width="100">
		          <button type="button" class="bts" onclick="javascript:location.href='<%=cp%>/aband/created'">글올리기</button>
		      </td>
		   </tr>
		</table>
    </div>