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
		           <div style='float: left;'><span style='color: #D96262; font-weight: bold;'>한줄평 ${reivewCount}개</span></div>
		           <div style='float: right; text-align: right;'></div>
		       </div>
		    </td>
		</tr>
	</thead>

	<tbody id='listRateBody'>
	<c:forEach var="dto" items="${reviewList}">
	    <tr height='35' style='background: white;'>
	       <td style='width: 50%; padding:5px 5px; border-right:none; text-align: left;'>
	       	
			<c:forEach  var="i" begin="1" end="5" step="1">
				<c:if test="${i<=dto.rate}">
					<span><img src="<%=cp%>/resource/img/starred.png" width="25px;"></span>
				</c:if>
				<c:if test="${i>dto.rate}">
					<span><img src="<%=cp%>/resource/img/stargray.png" width="25px;"></span>
				</c:if>
			</c:forEach>
	          
	      
	       	
	        </td>
	       <td style='width: 50%; padding:5px 5px; border-left:none;' align='right'>
	            <span>${dto.created}</span>
	        </td>
	    </tr>
	    <tr>
	     	<td colspan='2' valign='top' style='padding:5px 5px; width: 100%; border-bottom: 1px solid;' align="left">
	     	<b>${dto.nickName}</b>
	        <br>
	           ${dto.content}
	        </td>
	    </tr>
	    
	</c:forEach>
	</tbody>
	
	<tfoot id='listRateFooter'>
		<tr height='40' align="center">
            <td colspan='2' >
              ${reivewCount==0?"등록된 한줄평이 없습니다.":paging}
            </td>
           </tr>
	</tfoot>
</table>