<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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


</style>

<script type="text/javascript">
function deleteFreeBoard(bbsNum) {
	<c:if test="${sessionScope.member.userId==dto.userId || fn:indexOf(sessionScope.member.userId,'admin') == 0}">
		var q = "bbsNum=${dto.bbsNum}&${query}";
		var url = "<%=cp%>/freeBoard/delete?"+q;
		
	if(confirm("게시글을 삭제 하시겠습니까 ?")) {
		location.href=url;
	}
	</c:if>
	<c:if test="${sessionScope.member.userId!=dto.userId && fn:indexOf(sessionScope.member.userId,'admin') != 0}">
		alert("게시물을 삭제할 수 없습니다.");
	</c:if>
	}

function updateFreeBoard(bbsNum) {
	<c:if test="${sessionScope.member.userId==dto.userId}">
	var q = "bbsNum=${dto.bbsNum}&page=${page}";
	var url = "<%=cp%>/freeBoard/update?"+q;
	
	location.href=url;
</c:if>

<c:if test="${sessionScope.member.userId!=dto.userId}">
	alert("게시글을 수정할 수 없습니다.");
</c:if>
}

</script>

<script type="text/javascript">
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

function report(){
	$('#report_dialog').dialog({
		  modal: true,
		  height: 300,
		  width: 500,
		  title: '신고하기',
		  close: function(event, ui) {
		  }
	});
	
}

//게시글 신고 여부
$(function(){
	$(".btnDialogOn").click(function(){
		if(! confirm("게시물을 신고하시겠습니까?")) {
			return false;
		}
		
		var url="<%=cp%>/freeBoard/insertFreeBoardReport";
		var query=$("form[name=reportForm]").serialize();
		
		var fn = function(data){
			var state=data.state;
			if(state=="true") {
				var count = data.freeBoardReportCount;
				$("#freeBoardReportCount").text(count);
			} else if(state=="false") {
				alert("신고는 한번만 가능합니다.");
			}
			$('#report_dialog').dialog("close");
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});

$(function(){
	$(".btnDialogCancel").click(function(){
		$('#report_dialog').dialog("close");
	});
});


//댓글 관련 여부
$(function(){
	listPage(1);
});

function listPage(page) {
	var url = "<%=cp%>/freeBoard/listReply";
	var query = "bbsNum=${dto.bbsNum}&pageNo="+page;
	var selector = "#listReply";
	
	ajaxHTML(url, "get", query, selector);
}


$(function(){
	$(".btnSendReply").click(function(){
		var bbsNum="${dto.bbsNum}";
		var $tb = $(this).closest("table");
		var content=$tb.find("textarea").val().trim();
		if(! content) {
			$tb.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url="<%=cp%>/freeBoard/insertReply";
		var query="bbsNum="+bbsNum+"&content="+content+"&parent=0";
		
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
		if(! confirm("댓글을 삭제하시겠습니까 ? ")) {
		    return false;
		}
		
		var bbsReplyNum=$(this).attr("data-bbsReplyNum");
		var page=$(this).attr("data-pageNo");
		
		var url="<%=cp%>/freeBoard/deleteReply";
		var query="bbsReplyNum="+bbsReplyNum+"&mode=reply";
		
		var fn = function(data) {
			listPage(page);
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});

function listReplyParent(parent) {
	var url="<%=cp%>/freeBoard/listReplyParent";
	var query = {parent:parent};
	var selector = "#listReplyParent"+parent;
	
	ajaxHTML(url, "get", query, selector);
}

function countReplyParent(parent) {
	var url = "<%=cp%>/freeBoard/countReplyParent";
	var query = {parent:parent};
	
	var fn = function(data) {
		var count=data.count;
		var vid="#parentCount"+parent;
		$(vid).html(count);
	};
	
	ajaxJSON(url, "post", query, fn);
}

$(function(){
	$("body").on("click", ".btnReplyParentLayout", function(){
		var $trReplyParent = $(this).closest("tr").next();
		
		var isVisible = $trReplyParent.is(':visible');
		var bbsReplyNum = $(this).attr("data-bbsReplyNum");
		
		if(isVisible) {
			$trReplyParent.hide();
		} else {
			$trReplyParent.show();
			
			listReplyParent(bbsReplyNum);
			
			countReplyParent(bbsReplyNum);
		}
	});
});

$(function(){
	$("body").on("click", ".btnSendReplyParent", function(){
		var bbsNum="${dto.bbsNum}";
		var bbsReplyNum = $(this).attr("data-bbsReplyNum");
		var $td = $(this).closest("td");
		var content=$td.find("textarea").val().trim();
		console.log(bbsReplyNum);
		if(! content) {
			$td.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url="<%=cp%>/freeBoard/insertReply";
		var query="bbsNum="+bbsNum+"&content="+content+"&parent="+bbsReplyNum;
		
		var fn = function(data) {
			$td.find("textarea").val("");
			
			var state=data.state;
			if(state=="true") {
				listReplyParent(bbsReplyNum);
				countReplyParent(bbsReplyNum);
			}
		};
		ajaxJSON(url, "post", query, fn);
	});
});

$(function(){
	$("body").on("click", ".deleteReplyParent", function(){
		if(! confirm("답글을 삭제하시겠습니까 ? "))
			return;
		var bbsReplyNum=$(this).attr("data-bbsReplyNum");
		var parent=$(this).attr("data-parent");
		
		var url="<%=cp%>/freeBoard/deleteReply";
		var query="bbsReplyNum="+bbsReplyNum+"&mode=parent";
		
		var fn = function(data) {
			listReplyParent(parent);
			countReplyParent(parent);
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});


</script>


<div class="body-container" style="width: 700px; margin: 20px auto 10px; text-align: center;">
	<div class="body-title">
		<h3>자유게시판</h3>
	</div>
	
	<div>
		<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			<tr height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
				<td width="50%" align="left" style="padding-left: 5px; font-size: 20px;">
					${dto.subject}
				</td>
				
				<td width="50%" align="right" style="font-size: 15px; font-weight: bold;">
			         날짜&nbsp;&nbsp;${dto.created}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;조회수&nbsp;&nbsp;${dto.hitCount}
			    </td> 
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td width="50%" align="left" style="padding-left: 5px;">
				작성자 : ${dto.nickName}
				</td>
			</tr>
			
			<tr height="35">
				<td width="50%" align="left" style="padding-left: 5px;">
			 	${dto.content}
				</td>
			</tr>
			
		<tr>
			<td align="left">
				<button type="button" onclick="report();">신고</button>
			</td>
		</tr>	
			 
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td colspan="2" align="left" style="padding-left: 5px;">
				이전글 :
					<c:if test="${not empty preReadFreeBoard}">
						<a href="<%=cp%>/freeBoard/article?${query}&bbsNum=${preReadFreeBoard.bbsNum}" style="color: black;">${preReadFreeBoard.subject}</a>
					</c:if>
				</td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td colspan="2" align="left" style="padding-left: 5px;">
				다음글 :
					<c:if test="${not empty nextReadFreeBoard}">
						<a href="<%=cp%>/freeBoard/article?${query}&bbsNum=${nextReadFreeBoard.bbsNum}" style="color: black;">${nextReadFreeBoard.subject}</a>
					</c:if>
				</td>
			</tr>
		</table>
		
		<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
			<tr height="45">
				<td  width="300" align="left">
					<c:if test="${sessionScope.member.userId==dto.userId}">
						<button type="button" class="bts" onclick="updateFreeBoard();">수정</button>
					</c:if>
					  <c:if test="${sessionScope.member.userId==dto.userId || fn:indexOf(sessionScope.member.userId,'admin') == 0}">
						<button type="button" class="bts" onclick="deleteFreeBoard();">삭제</button>
					</c:if>
					
				</td>
				
				<td align="right">
					<button type="button" class="bts" onclick="javascript:location.href='<%=cp%>/freeBoard/list?${query}';">리스트</button>
				</td>
			</tr>
		</table>
	</div>
	
	<div>
		<table style='width: 100%; margin: 15px quto 0px; border-spacing:0px;' >
			<tr height='30'>
				<td align='left'>
					<span style='font-weight: bold;' > 댓글쓰기 </span><span> - 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가 주세요.</span>
				</td>
			</tr>
			<tr>
				<td style='padding: 5px 5px 0px;'>
					<textarea class='boxTA' style='width:99%; height: 70px; '></textarea>
				</td>
			</tr>
			<tr>
				<td align="right">
					<button type='button' class='bts btnSendReply' data-freeBoardNum='10'> 댓글 등록 </button>
				</td>
			</tr>
		</table>
		<div id="listReply"></div>
	</div>
		
	<div id="report_dialog" style="display: none; text-align: left;">
			<strong>신고사유 : 대표적인 사유 1개를 선택해 주세요</strong>
			<br><br>
		<form name="reportForm">
			<input type="hidden" name="reportedPostNum" value="${dto.bbsNum}">
			<input type="hidden" name="reporterNum" value="${sessionScope.member.memberIdx}">
			<input type="hidden" name="reportedNum" value="${dto.num}">
				
				<input type="radio" name="reasonSortNum" value="1" checked="checked">&nbsp;타 웹사이트 홍보<br>
				<input type="radio" name="reasonSortNum" value="2">&nbsp;도색적이고 폭력적인 내용<br>
				<input type="radio" name="reasonSortNum" value="3">&nbsp;욕설 및 모욕적인 언행<br>
				<input type="radio" name="reasonSortNum" value="4">&nbsp;현행법에 저촉되는 행위(불법거래, 저작권 등)<br>
				<input type="radio" name="reasonSortNum" value="5">&nbsp;기타<br>
				
			<div class="btn_box" align="center">
				<button type="button" class="btnDialogCancel">취소</button>
				<button type="button" class="btnDialogOn">신고하기</button>
			</div>
			
		</form>
	</div>
	
	
</div>