<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript">
function login() {
	location.href="<%=cp%>/member/login";
}

function deleteEvent() {
<c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId==dto.userId}">
	var q = "eventNum=${dto.eventnum}&${query}";
    var url = "<%=cp%>/event/delete?" + q;

    if(confirm("위 자료를 삭제 하시 겠습니까 ? "))
  	  location.href=url;
</c:if>    
<c:if test="${sessionScope.member.userId!='admin' && sessionScope.member.userId!=dto.userId}">
  alert("게시물을 삭제할 수  없습니다.");
</c:if>
}

function updateEvent() {
<c:if test="${sessionScope.member.userId==dto.userId}">
	var q = "eventNum=${dto.eventNum}&page=${page}";
    var url = "<%=cp%>/event/update?" + q;

    location.href=url;
</c:if>

<c:if test="${sessionScope.member.userId!=dto.userId}">
   alert("게시물을 수정할 수  없습니다.");
</c:if>
}

function ajaxJSON(url, type, query, fn) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			fn(data);
		}
		,beforeSend:function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return false;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

function ajaxHTML(url, type, query, selector) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,success:function(data) {
			$(selector).html(data);
		}
		,beforeSend:function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return false;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

$(function(){
	listPage(1);
});

function listPage(page) {
	var url = "<%=cp%>/park/listRate";
	var query = "recommendNum=${dto.recommendNum}&pageNo="+page;
	var selector = "#listRate";
	
	ajaxHTML(url, "get", query, selector);
}

function listPage(page) {
	var url="<%=cp%>/event/listReply";
	var query="eventNum=${dto.eventNum}&pageNo="+page;
	
	$.ajax({
		type:"get"
		,url:url
		,data:query
		,success:function(data) {
			$("#listReply").html(data);
		}
	    ,beforeSend :function(jqXHR) {
	    	jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		location.href="<%=cp%>/member/login";
	    		return false;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}


//리플 등록
$(function(){
	$(".btnSendReply").click(function(){
		
		var eventNum="${dto.eventNum}";
		var $tb = $(this).closest("table");
		var content=$tb.find("textarea").val().trim();
		if(! content) {
			$tb.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var query="eventNum="+eventNum+"&content="+content+"&answer=0";
		var url="<%=cp%>/bbs/insertReply";
		$.ajax({
			type:"post"
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data) {
				$tb.find("textarea").val("");
		
				var state=data.state;
				if(state=="true") {
					listPage(1);
				} else if(state=="false") {
					alert("댓글을 추가 하지 못했습니다.");
				}
			}
			,beforeSend : function(jqXHR) {
		        jqXHR.setRequestHeader("AJAX", true);
		    }
		    ,error:function(jqXHR) {
		    	if(jqXHR.status==403) {
		    		login();
		    		return false;
		    	}
		    	console.log(jqXHR.responseText);
		    }
		});
		
	});
});

$(function(){
	$("body").on("click", ".deleteReply", function(){
		if(! confirm("게시물을 삭제하시겠습니까 ? ")) {
		    return false;
		}
		
		var replyNum=$(this).attr("data-replyNum");
		var page=$(this).attr("data-pageNo");
		
		var url="<%=cp%>/bbs/deleteReply";
		var query="replyNum="+replyNum+"&mode=reply";
		
		$.ajax({
			type:"post"
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data) {
				// var state=data.state;
				listPage(page);
			}
			,beforeSend : function(jqXHR) {
		        jqXHR.setRequestHeader("AJAX", true);
		    }
		    ,error:function(jqXHR) {
		    	if(jqXHR.status==403) {
		    		login();
		    		return false;
		    	}
		    	console.log(jqXHR.responseText);
		    }
		});
		
	});
});

</script>

<div class="body-container" style="width: 700px; margin: 20px auto 10px;">
	<div class="body-title">
		<h3><i class="far fa-image"></i> 이벤트 </h3>
	</div>
	
	<div>
		<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			<tr height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
				<td width="50%" align="left" style="padding-left: 20px; font-size: 20px;">
					${list.get(0).subject}
				</td>
				
				<td width="50%" align="right" style="font-size: 15px; font-weight: bold;">
			         날짜&nbsp;&nbsp;${list.get(0).created}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;조회수&nbsp;&nbsp;${list.get(0).hitCount}
			    </td> 
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td width="50%" align="left" style="padding-left: 5px;">
				${sessionScope.member.nickName}
				</td>
				<td width="50%" align="right" style="padding-right: 5px;">
					${list.get(0).content}
				</td>
			</tr>
			
			<tr>
				<td colspan="2" align="left" style="padding: 10px 5px;">
					<c:forEach var="dto" items="${list}">
					<img alt="" src="<%=cp%>/uploads/event/${dto.imageFileName}" style="max-width:100%; height:auto; resize:both;">
					</c:forEach>
				</td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td colspan="2" align="left" style="padding-left: 5px;">
				이전글 :
					<c:if test="${not empty preReadDto}">
						<a href="<%=cp%>/event/article?${query}&eventNum=${preReadDto.eventNum}">${preReadDto.subject}</a>
					</c:if>
				</td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td colspan="2" align="left" style="padding-left: 5px;">
				다음글 :
					<c:if test="${not empty nextReadDto}">
						<a href="<%=cp%>/event/article?${query}&eventNum=${nextReadDto.eventNum}">${nextReadDto.subject}</a>
					</c:if>
				</td>
			</tr>
		</table>
		
		<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
			<tr height="45">
				<td  width="300" align="left">
					<c:if test="${sessionScope.member.userId==dto.userId}">
						<button type="button" class="btn" onclick="updateEvent();">수정</button>
					</c:if>
					<c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
						<button type="button" class="btn" onclick="deleteEvent();">삭제</button>
					</c:if>
				</td>
				
				<td align="right">
					<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/event/list?${query}';">리스트</button>
				</td>
			</tr>
		</table>
	</div>
</div>