<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>


<table style='width: 100%; margin: 10px auto 30px; border-spacing: 0px;'>
	<thead id='listRateHeader'>
		<tr height='35'>
		    <td colspan='2'>
		       <div style='clear: both;'>
		           <div style='float: left;'><span style='color: #D96262; font-weight: bold;'>한줄평 ${rateCount}개</span></div>
		           <div style='float: right; text-align: right;'></div>
		       </div>
		    </td>
		</tr>
	</thead>

	<tbody id='listRateBody'>
	<c:forEach var="vo" items="${listRate}">
	    <tr height='35' style='background: white;'>
	       <td style='width: 50%; padding:5px 5px; border-right:none;'>
	       	
	       	<span><b>${vo.userId}</b></span>
	       	
			<c:forEach  var="i" begin="1" end="5" step="1">
				<c:if test="${i<=vo.rate}">
					<span><img src="<%=cp%>/resource/img/starred.png" width="50px;"></span>
				</c:if>
				<c:if test="${i>vo.rate}">
					<span><img src="<%=cp%>/resource/img/stargray.png" width="50px;"></span>
				</c:if>
			</c:forEach>
	          
	        </td>
	       <td style='width: 50%; padding:5px 5px; border-left:none;' align='right'>
	           <span>${vo.created}</span> |
	           <c:if test="${vo.userId == sessionScope.member.userId ||  sessionScope.member.userId == 'admin' || sessionScope.member.userId == 'admin2' || sessionScope.member.userId == 'admin3'}">
	                <span class="deleteRate" style="cursor: pointer;" data-rateNum='${vo.rateNum}' data-pageNo='${pageNo}'>삭제</span>
	           	</c:if>
	        </td>
	    </tr>
	    <tr>
	        <td colspan='2' valign='top' style='padding:5px 5px; width: 100%; border-bottom: 1px solid;' align="left">
	              ${vo.content}
	        </td>
	    </tr>
	    
	</c:forEach>
	</tbody>
	
	<tfoot id='listRateFooter'>
		<tr height='40' align="center">
            <td colspan='2' >
              ${rateCount==0?"등록된 한줄평이 없습니다.":paging}
            </td>
           </tr>
	</tfoot>
</table>