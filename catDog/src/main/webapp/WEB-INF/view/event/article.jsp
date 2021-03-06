
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

.bts2 {
  background-color: white;
  border: 1px solid;
  border-color: #a9a9a9;
  color: #black;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  height: 70px;
}
</style>
<script type="text/javascript">
function login() {
	location.href="<%=cp%>/member/login";
}

function deleteEvent(eventNum) {
	<c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId=='admin2' || sessionScope.member.userId=='admin3'}">
	var q = "eventNum="+eventNum+"&${query}";
    var url = "<%=cp%>/event/delete?" + q;

    if(confirm("위 게시물을 삭제 하시겠습니까 ? "))
  	  location.href=url;
</c:if>    
<c:if test="${sessionScope.member.userId!='admin' && sessionScope.member.userId!='admin2' && sessionScope.member.userId!='admin3'}">
  alert("게시물을 삭제할 수  없습니다.");
</c:if>
}

function updateEvent(eventNum) {
	<c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId=='admin2' || sessionScope.member.userId=='admin3'}">
	var q = "eventNum="+eventNum+"&page=${page}";
    var url = "<%=cp%>/event/update?" + q;

    location.href=url;
</c:if>

<c:if test="${sessionScope.member.userId!='admin' && sessionScope.member.userId!='admin2' && sessionScope.member.userId!='admin3'}">
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
	var url = "<%=cp%>/event/listReply";
	var query = "eventNum=${list.get(0).eventNum}&pageNo="+page;
	var selector = "#listReply";
	
	ajaxHTML(url, "get", query, selector);
}

//리플 등록
$(function(){
	$(".btnSendReply").click(function(){
		var eventNum="${list.get(0).eventNum}";
		var $tb = $(this).closest("table");
		var content=$tb.find("textarea").val().trim();
		if(! content) {
			$tb.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url="<%=cp%>/event/insertReply";
		var query="eventNum="+eventNum+"&content="+content+"&answer=0";
		
		var fn = function(data) {
			$tb.find("textarea").val("");
			
			var state=data.state;
			if(state=="true") {
				listPage(1);
			} else if(state=="false") {
				alert("로그인 후 댓글등록이 가능합니다.");
			}
		};
			
		ajaxJSON(url, "post", query, fn);
	});
});

$(function(){
	$("body").on("click", ".deleteReply", function(){
		if(! confirm("게시물을 삭제하시겠습니까 ? ")) {
		    return false;
		}
		
		var eventReplyNum=$(this).attr("data-eventReplyNum");
		var page=$(this).attr("data-pageNo");
		
		var url="<%=cp%>/event/deleteReply";
		var query="eventReplyNum="+eventReplyNum+"&mode=reply";
		
		var fn = function(data) {
			listPage(page);
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});

function listReplyAnswer(answer) {
	var url="<%=cp%>/event/listReplyAnswer";
	var query = {answer:answer};
	var selector = "#listReplyAnswer"+answer;
	
	ajaxHTML(url, "get", query, selector);
}

function countReplyAnswer(answer) {
	var url = "<%=cp%>/event/countReplyAnswer";
	var query = {answer:answer};
	
	var fn = function(data) {
		var count=data.count;
		var vid="#answerCount"+answer;
		$(vid).html(count);
	};
	
	ajaxJSON(url, "post", query, fn);
}

$(function(){
	$("body").on("click", ".btnReplyAnswerLayout", function(){
		var $trReplyAnswer = $(this).closest("tr").next();
		
		var isVisible = $trReplyAnswer.is(':visible');
		var eventReplyNum = $(this).attr("data-eventReplyNum");
		
		if(isVisible) {
			$trReplyAnswer.hide();
		} else {
			$trReplyAnswer.show();
			
			listReplyAnswer(eventReplyNum);
			
			countReplyAnswer(eventReplyNum);
		}
	});
});

$(function(){
	$("body").on("click", ".btnSendReplyAnswer", function(){
		var eventNum="${list.get(0).eventNum}";
		var eventReplyNum = $(this).attr("data-eventReplyNum");
		var $td = $(this).closest("td");
		var content=$td.find("textarea").val().trim();
		if(! content) {
			$td.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url="<%=cp%>/event/insertReply";
		var query="eventNum="+eventNum+"&content="+content+"&answer="+eventReplyNum;
		
		var fn = function(data) {
			$td.find("textarea").val("");
			
			var state=data.state;
			if(state=="true") {
				listReplyAnswer(eventReplyNum);
				countReplyAnswer(eventReplyNum);
			}
		};
		ajaxJSON(url, "post", query, fn);
	});
});

$(function(){
	$("body").on("click", ".deleteReplyAnswer", function(){
		if(! confirm("게시물을 삭제하시겠습니까 ? "))
			return;
		var eventReplyNum=$(this).attr("data-eventReplyNum");
		var answer=$(this).attr("data-answer");
		
		var url="<%=cp%>/event/deleteReply";
		var query="eventReplyNum="+eventReplyNum+"&mode=answer";
		
		var fn = function(data) {
			listReplyAnswer(answer);
			countReplyAnswer(answer);
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});

</script>

<div class="container-board">
	<div class="body-title">
		<span style="font-family: Webdings"><i class="fas fa-cookie-bite"></i> 이벤트</span>
	</div>
	
	<div>
		<table style="width: 100%; margin: 10px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			<tr height="35" style="border-top: 2px solid #D96262; padding-top:20px; padding-bottom:20px; border-bottom: 1px solid #cccccc;">
				<td width="50%" align="left" style="padding-left: 5px; font-size: 20px; padding-top:20px; padding-bottom:20px; border-bottom: 1px solid #cccccc;">
					${list.get(0).subject}
				</td>
				
				<td width="50%" align="right" style="font-size: 15px; font-weight: bold;">
			         날짜&nbsp;&nbsp;${list.get(0).created}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;조회수&nbsp;&nbsp;${list.get(0).hitCount}
			    </td> 
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td width="50%" align="left" style="padding-left: 5px; font-size: 17px;">
				${sessionScope.member.nickName}
				</td>
			</tr>
			
			<tr>
				<td colspan="2" align="center" style="padding: 10px 5px;" valign="top" height="200">
					<c:forEach var="dto" items="${list}">
					<img alt="" src="<%=cp%>/uploads/event/${dto.imageFileName}" style="max-width:100%; height:auto; resize:both;">
					</c:forEach>
				</td>
			</tr>
			
			<tr style="border-bottom: 1px solid #cccccc;">
			  <td colspan="2" align="center" style="padding: 10px 5px;" valign="top" height="50">
			      ${list.get(0).content}
			   </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td colspan="2" align="left" style="padding-left: 5px;">
				이전글 :
					<c:if test="${not empty preReadEvent}">
						<a href="<%=cp%>/event/article?${query}&eventNum=${preReadEvent.eventNum}">${preReadEvent.subject}</a>
					</c:if>
				</td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td colspan="2" align="left" style="padding-left: 5px;">
				다음글 :
					<c:if test="${not empty nextReadEvent}">
						<a href="<%=cp%>/event/article?${query}&eventNum=${nextReadEvent.eventNum}">${nextReadEvent.subject}</a>
					</c:if>
				</td>
			</tr>
		</table>
		
		<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
			<tr height="45">
				<td  width="300" align="left">
					<c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId=='admin2' || sessionScope.member.userId=='admin3'}">
						<button type="button" class="bts" onclick="updateEvent('${list.get(0).eventNum}');">수정</button>
					</c:if>
					<c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId=='admin2' || sessionScope.member.userId=='admin3'}">
						<button type="button" class="bts" onclick="deleteEvent('${list.get(0).eventNum}');">삭제</button>
					</c:if>
				</td>
				
				<td align="right">
					<button type="button" class="bts" onclick="javascript:location.href='<%=cp%>/event/list?${query}';">리스트</button>
				</td>
			</tr>
		</table>
	</div>
	
	<div>
		<table style='width: 100%; margin: 15px quto 0px; border-spacing:0px;' >
			<tr height='30'>
				<td align='left'>
					<span style='font-weight: bold; color: #d96262' > 댓글쓰기 </span><span> - 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가 주세요.</span>
				</td>
			</tr>
			<tr>
				<td style='padding: 5px 5px 0px;'>
					<textarea class='boxTA' style='width:105%; height: 70px; '></textarea>
				</td>
				<td align="right">
					<button type='button' class='bts2 btnSendReply' data-eventNum='10' style='padding: 10px 20px;'> 댓글등록 </button>
				</td>
			</tr>
			
		</table>
		<div id="listReply"></div>
	</div>
</div>