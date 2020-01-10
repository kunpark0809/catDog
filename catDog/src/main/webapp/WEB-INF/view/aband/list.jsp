<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%> 
<link rel="stylesheet" href="<%=cp%>/resource/css/tabs.css" type="text/css">
<script type="text/javascript">
	function searchList() {
		var f=document.searchForm;
		f.submit();
	}
	
	$(function(){
		$("#tab-lose").addClass("active");
		// listPage(1);

		$("ul.tabs li").click(function() {
			tab = $(this).attr("data-tab");
			
			$("ul.tabs li").each(function(){
				$(this).removeClass("active");
			});
			
			$("#tab-"+tab).addClass("active");
			
			var url = "<%=cp%>/aband/list?sort="+tab;
			location.href=url;
		});
	});
</script>
<link rel="stylesheet" href="<%=cp%>/resource/css/dogshop.css">
<div class="shin_body">
<div class="body-title">
        <h3 style="float:left;"><i class="fas fa-chalkboard"></i>유기동물 게시판 </h3>
        <button style="float:left;" type="button" class="btn" onclick="javascript:location.href='<%=cp%>/aband/created'">글올리기</button>
         <form name="searchForm" action="/catDog/aband/list" method="post" style="float:right;">
  

				<select name="species">
					<option value="all">애견동물전체</option>
					<option value="1">강아지</option>
					<option value="0">고양이</option>
				</select>
				<select name="area">
					<option value="all">지역전체</option>
					<option value="서울">서울시</option>
					<option value="인천">인천시</option>
					<option value="대전">대전시</option>
					<option value="광주">광주시</option>
					<option value="대구">대구시</option>
					<option value="울산">울산시</option>
					<option value="부산">부산시</option>
					<option value="경기">경기도</option>
					<option value="강원">강원도</option>
					<option value="세종">세종시</option>
					<option value="충남">충청남도</option>
					<option value="충북">충청북도</option>
					<option value="전남">전라남도</option>
					<option value="전북">전라북도</option>
					<option value="경남">경상남도</option>
					<option value="경북">경상북도</option>
					<option value="제주">제주도</option>
				</select>


           <button type="button" class="btn" onclick="searchList();">검색</button>
       </form>
    </div>
    
    <div>

			<div>
		            <div style="clear: both;">
			           <ul class="tabs">
					       <li id="tab-lose"  data-tab="0">잃어버렸어요</li>
					       <li id="tab-protect" data-tab="1"> 보호하고있어요 </li>
					   </ul>
				   </div>
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
							<div class="link" onclick="javascript:location.href='${articleUrl}&lostPetNum=${dto.lostPetNum}'">
									<img alt="" src="<%=cp%>/uploads/aband/${dto.imageFileName}" width="200" height="200">
								
								<p><b>${dto.subject}</b></p>	
								<p>지역: ${dto.addr}</p>
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
    </div>

</div>