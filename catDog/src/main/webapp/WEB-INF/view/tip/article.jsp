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
function deleteTip(tipNum) {
	<c:if test="${sessionScope.member.userId==dto.userId || fn:indexOf(sessionScope.member.userId,'admin') == 0}">
	var q = "tipNum=${dto.tipNum}&${query}";
	var url = "<%=cp%>/tip/delete?"+q;
	
	if(confirm("게시글을 삭제 하시겠습니까 ?")) {
		location.href=url;
	}
	</c:if>
	<c:if test="${sessionScope.member.userId!=dto.userId && fn:indexOf(sessionScope.member.userId,'admin') != 0}">
		alert("게시물을 삭제할 수 없습니다.");
	</c:if>
}

function updateTip(tipNum) {
	<c:if test="${sessionScope.member.userId==dto.userId}">
	var q = "tipNum=${dto.tipNum}&page=${page}";
	var url = "<%=cp%>/tip/update?"+q;
	
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

// 게시글 좋아요 여부
$(function(){
	$(".btnSendTipLike").click(function(){
		if(! confirm("게시물에 좋아요를 누르시겠습니까?")) {
			return false;
		}
		
		var url="<%=cp%>/tip/insertTipLike";
		var tipNum="${dto.tipNum}";
		var query = {tipNum:tipNum};
		
		var fn = function(data){
			var state=data.state;
			if(state=="true") {
				var count = data.tipLikeCount;
				$("#tipLikeCount").text(count);
			} else if(state=="false") {
				alert("좋아요는 한번만 가능합니다.");
			}
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});


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
		
		var url="<%=cp%>/tip/insertTipReport";
		var query=$("form[name=reportForm]").serialize();
		
		var fn = function(data){
			var state=data.state;
			if(state=="true") {
				var count = data.tipReportCount;
				$("#tipReportCount").text(count);
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
	var url = "<%=cp%>/tip/listReply";
	var query = "tipNum=${dto.tipNum}&pageNo="+page;
	var selector = "#listReply";
	
	ajaxHTML(url, "get", query, selector);
}


$(function(){
	$(".btnSendReply").click(function(){
		var tipNum="${dto.tipNum}";
		var $tb = $(this).closest("table");
		var content=$tb.find("textarea").val().trim();
		if(! content) {
			$tb.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url="<%=cp%>/tip/insertReply";
		var query="tipNum="+tipNum+"&content="+content+"&parent=0";
		
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
		
		var tipReplyNum=$(this).attr("data-tipReplyNum");
		var page=$(this).attr("data-pageNo");
		
		var url="<%=cp%>/tip/deleteReply";
		var query="tipReplyNum="+tipReplyNum+"&mode=reply";
		
		var fn = function(data) {
			listPage(page);
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});

function listReplyParent(parent) {
	var url="<%=cp%>/tip/listReplyParent";
	var query = {parent:parent};
	var selector = "#listReplyParent"+parent;
	
	ajaxHTML(url, "get", query, selector);
}

function countReplyParent(parent) {
	var url = "<%=cp%>/tip/countReplyParent";
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
		var tipReplyNum = $(this).attr("data-tipReplyNum");
		
		if(isVisible) {
			$trReplyParent.hide();
		} else {
			$trReplyParent.show();
			
			listReplyParent(tipReplyNum);
			
			countReplyParent(tipReplyNum);
		}
	});
});

$(function(){
	$("body").on("click", ".btnSendReplyParent", function(){
		var tipNum="${dto.tipNum}";
		var tipReplyNum = $(this).attr("data-tipReplyNum");
		var $td = $(this).closest("td");
		var content=$td.find("textarea").val().trim();
		console.log(tipReplyNum);
		if(! content) {
			$td.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url="<%=cp%>/tip/insertReply";
		var query="tipNum="+tipNum+"&content="+content+"&parent="+tipReplyNum;
		
		var fn = function(data) {
			$td.find("textarea").val("");
			
			var state=data.state;
			if(state=="true") {
				listReplyParent(tipReplyNum);
				countReplyParent(tipReplyNum);
			}
		};
		ajaxJSON(url, "post", query, fn);
	});
});

$(function(){
	$("body").on("click", ".deleteReplyParent", function(){
		if(! confirm("답글을 삭제하시겠습니까 ? "))
			return;
		var tipReplyNum=$(this).attr("data-tipReplyNum");
		var parent=$(this).attr("data-parent");
		
		var url="<%=cp%>/tip/deleteReply";
		var query="tipReplyNum="+tipReplyNum+"&mode=parent";
		
		var fn = function(data) {
			listReplyParent(parent);
			countReplyParent(parent);
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});


</script>


<div class="container-board">
	<div class="body-title">
		<h3>꿀팁</h3>
	</div>
	
	<div>
		<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			<tr height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
				<td width="50%" align="left" style="padding-left: 5px; font-size: 20px;">
					[${dto.tipCategory}] ${dto.subject}
				</td>
				
				<td width="50%" align="right" style="font-size: 15px; font-weight: bold;">
			         날짜&nbsp;&nbsp;${dto.created}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;조회수&nbsp;&nbsp;${dto.hitCount}
			    </td> 
			</tr>
			
			<tr height="35" style="border-top: 1px solid #cccccc;">
				<td align="left" style="padding-left: 5px; font-size: 20px;">
				작성자 : ${dto.nickName}
				</td>
			</tr>
			
			<tr>
				<td colspan="2" align="center" style="padding: 10px 5px;" valign="top" height="200">
					${dto.content}
				</td>
			</tr>
			
			<tr>
				<td colspan="2" height="40" style="padding-bottom: 15px;" align="center">
					<button type="button" class="bts btnSendTipLike" title="좋아요"><i class="fas fa-hand-point-up"></i>&nbsp;&nbsp;<span id="tipLikeCount">${dto.tipLikeCount}</span></button>
					
				</td>
			</tr>	
			 
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td colspan="2" align="left" style="padding-left: 5px;">
				이전글 :
					<c:if test="${not empty preReadTip}">
						<a href="<%=cp%>/tip/article?${query}&tipNum=${preReadTip.tipNum}" style="color: black;">${preReadTip.subject}</a>
					</c:if>
				</td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td colspan="2" align="left" style="padding-left: 5px;">
				다음글 :
					<c:if test="${not empty nextReadTip}">
						<a href="<%=cp%>/tip/article?${query}&tipNum=${nextReadTip.tipNum}" style="color: black;">${nextReadTip.subject}</a>
					</c:if>
				</td>
			</tr>
		</table>
		
		<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
			<tr height="45">
				<td  width="300" align="left">
					<c:if test="${sessionScope.member.userId==dto.userId}">
						<button type="button" class="bts" onclick="updateTip();">수정</button>
					</c:if>
					  <c:if test="${sessionScope.member.userId==dto.userId || fn:indexOf(sessionScope.member.userId,'admin') == 0}">
						<button type="button" class="bts" onclick="deleteTip();">삭제</button>
					</c:if>
				</td>
				
				<td align="right">
					<button type="button" class="bts" onclick="javascript:location.href='<%=cp%>/tip/list?${query}';">리스트</button>
				</td>
			</tr>
		</table>
	</div>
	
	<div>
		
		<div id="listReply"></div>
		<table style='width: 100%; margin: 15px quto 0px; border-spacing:0px;' >
			<tr>
				<td style='padding: 5px 5px 0px;'>
					<textarea class='boxTA' style='width:90%; height: 70px;'></textarea>
					<b style="float: right;"><button type='button' class='btnSendReply' data-tipNum='10' style="height: 75px;"> 댓글 등록 </button></b>
				</td>
			</tr>
		</table>
	</div>
	
	
		
	<div id="report_dialog" style="display: none; text-align: left;">
			<strong>신고사유 : 대표적인 사유 1개를 선택해 주세요</strong>
			<br><br>
		<form name="reportForm">
			<input type="hidden" name="reportedPostNum" value="${dto.tipNum}">
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