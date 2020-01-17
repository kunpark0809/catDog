<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% 
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/dogshop.css">
<script type="text/javascript">
function deleteBoard() {
	var q = "adoptionNum=${dto.adoptionNum}&${query}";
    var url = "<%=cp%>/adopt/delete?" + q;

    if(confirm("위 게시물을 삭제 하시겠습니까 ? "))
  	  location.href=url;  
}
 
function updateBoard(){
	var q = "adoptionNum=${dto.adoptionNum}&page=${page}";
    var url = "<%=cp%>/adopt/update?" + q;
  	location.href=url;  
}

function updateStatus(){
	var q = "adoptionNum=${dto.adoptionNum}&${query}";
	var url = "<%=cp%>/adopt/updateStatue?"+q;

	if(confirm("해당 게시물을 ${dto.status=='1'?'입양완료':'재입양'}로 변경하시겠습니까?"))
		location.href=url+"&status=${dto.status=='1'?'0':'1'}";
}

</script>

<script type="text/javascript">
function login() {
	location.href="<%=cp%>/member/login";
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



// 페이징 처리
$(function(){
	listPage(1);
});

function listPage(page) {
	var url = "<%=cp%>/adopt/listReply";
	var query = "adoptionNum=${dto.adoptionNum}&pageNo="+page;
	var selector = "#listReply";
	
	ajaxHTML(url, "get", query, selector);
}

// 리플 등록
$(function(){
	$(".btnSendReply").click(function(){
		var adoptionNum="${dto.adoptionNum}";
		var $tb = $(this).closest("table");
		var content=$tb.find("textarea").val().trim();
		if(! content) {
			$tb.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url="<%=cp%>/adopt/insertReply";
		var query="adoptionNum="+adoptionNum+"&content="+content;
		
		var fn = function(data){
			$tb.find("textarea").val("");
			
			var state=data.state;
			if(state=="true") {
				listPage(1);
			} else if(state=="false") {
				alert("댓글을 추가 하지 못했습니다.");
			}
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});


// 댓글 삭제
$(function(){
	$("body").on("click", ".deleteReply", function(){
		if(! confirm("게시물을 삭제하시겠습니까 ? ")) {
		    return false;
		}
		
		var adoptionReplyNum=$(this).attr("data-replyNum");
		var page=$(this).attr("data-pageNo");
		
		var url="<%=cp%>/adopt/deleteReply";
		var query="adoptionReplyNum="+adoptionReplyNum+"&mode=reply";
		
		var fn = function(data){
			var state=data.state;
			listPage(page);
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});

//댓글별 답글 리스트
function listReplyAnswer(parent) {
	var url="<%=cp%>/adopt/listReplyAnswer";
	var query = {parent:parent};
	var selector = "#listReplyAnswer"+parent;
	
	ajaxHTML(url, "get", query, selector);
}

// 댓글별 답글 개수
function countReplyAnswer(parent) {
	var url = "<%=cp%>/adopt/countReplyAnswer";
	var query = {parent:parent};
	
	var fn = function(data){
		var count=data.count;
		var vid="#answerCount"+parent;
		$(vid).html(count);
	};
	
	ajaxJSON(url, "post", query, fn);
}

//답글 버튼(댓글별 답글 등록폼 및 답글리스트)
$(function(){
	$("body").on("click", ".btnReplyAnswerLayout", function(){
		var $trReplyAnswer = $(this).closest("tr").next();
		// var $trReplyAnswer = $(this).parent().parent().next();
		// var $answerList = $trReplyAnswer.children().children().eq(0);
		
		var isVisible = $trReplyAnswer.is(':visible');
		var replyNum = $(this).attr("data-replyNum");
			
		if(isVisible) {
			$trReplyAnswer.hide();
		} else {
			$trReplyAnswer.show();
            
			// 답글 리스트
			listReplyAnswer(replyNum);
			
			// 답글 개수
			countReplyAnswer(replyNum);
		}
	});
	
});
//댓글별 답글 등록
$(function(){
	$("body").on("click", ".btnSendReplyAnswer", function(){
		var adoptionNum="${dto.adoptionNum}";
		var replyNum = $(this).attr("data-replyNum");
		var $td = $(this).closest("td");
		var content=$td.find("textarea").val().trim();
		if(! content) {
			$td.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url="<%=cp%>/adopt/insertReply";
		var query="adoptionNum="+adoptionNum+"&content="+content+"&parent="+replyNum;
		
		var fn = function(data){
			$td.find("textarea").val("");
			
			var state=data.state;
			if(state=="true") {
				listReplyAnswer(replyNum);
				countReplyAnswer(replyNum);
			}
		};
		
		ajaxJSON(url, "post", query, fn);
		
	});
});

// 댓글별 답글 삭제
$(function(){
	$("body").on("click", ".deleteReplyAnswer", function(){
		if(! confirm("게시물을 삭제하시겠습니까 ? "))
		    return;
		
		var adoptionReplyNum=$(this).attr("data-replyNum");
		var answer=$(this).attr("data-answer");
		
		var url="<%=cp%>/adopt/deleteReply";
		var query="adoptionReplyNum="+adoptionReplyNum+"&mode=answer";
		
		var fn = function(data){
			listReplyAnswer(answer);
			countReplyAnswer(answer);
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});

</script>

<div class="wide-container" >
    <div class="body-title">
        <i class="fas fa-hand-holding-heart"></i>&nbsp;입양 게시판
    </div>
    
    <div >
			<table style="width: 100%; margin: 30px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			<tr height="35" style="border-top: 2px solid #d96262; border-bottom: 1px solid #cccccc; ">
			    <td width="50%" align="left" style="padding: 20px 0px; font-size: 20px">
				   ${dto.subject}
			    </td>
			    <td width="50%" align="right" style="padding-right: 5px; font-size: 15px; font-weight: bold;">
			   		 ${dto.created}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;조회&nbsp;&nbsp; ${dto.hitCount}
			    </td>
			</tr>
			
			<tr height="35" >
			    <td colspan="2" align="left" style="padding-left: 5px;">
			      닉네임 : ${dto.nickName}
			    </td>

			</tr>
			
			<tr>
			  <td colspan="2" align="left" style="padding: 10px 5px;" valign="top" height="200">
			      ${dto.content}
			   </td>
			</tr>
			
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
			       이전글 :
			         <c:if test="${not empty preDto}">
			              <a href="<%=cp%>/adopt/article?${query}&adoptionNum=${preDto.adoptionNum}">${preDto.subject}</a>
			        </c:if>
			    </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
			       다음글 :
			         <c:if test="${not empty nextDto}">
			              <a href="<%=cp%>/adopt/article?${query}&adoptionNum=${nextDto.adoptionNum}">${nextDto.subject}</a>
			        </c:if>
			    </td>
			</tr>
			</table>
			
			<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
			<tr height="45">
			    <td width="300" align="left">
			       <c:if test="${sessionScope.member.nickName==dto.nickName}">				    
			          <button type="button" class="bts" onclick="updateBoard();">수정</button>
			          <button type="button" class="bts" onclick="updateStatus();">${dto.status=="1"?"입양완료":"재입양"}</button>
			       </c:if>
			       
			       <c:if test="${fn:indexOf(sessionScope.member.userId,'admin') == 0}">				    
			          <button type="button" class="bts" onclick="deleteBoard();">삭제</button>
			       </c:if>
			    </td>
			
			    <td align="right">
			        <button type="button" class="bts" onclick="javascript:location.href='<%=cp%>/adopt/list?${query}';">리스트</button>
			    </td>
			</tr>
			</table>
    </div>
    
 <div>
		<table style='width: 100%; margin: 15px auto 0px; border-spacing: 0px;'>
			<tr height='30'> 
				 <td align='left' style='font-weight: bold;'  >
				 	${sessionScope.member.nickName}
				 </td>
			</tr>
			<tr>
			   	<td style='padding:5px 5px 0px; width:93%;'>
					<textarea class='boxTA' style='width:100%; height: 70px;'></textarea>
			    </td>
			    <td align='right'>
			        <button type='button' class='btnSendReply' data-num='10' style='padding:10px 20px; margin-left: 5px;'>댓글 등록</button>
			    </td>
			</tr>
		</table>
		     
		<div id="listReply"></div>
    
    </div>
    
</div>
