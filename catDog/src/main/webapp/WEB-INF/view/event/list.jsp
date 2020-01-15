<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String cp=request.getContextPath();
%>

<style type="text/css">
.imgLayout{
	width: 200px;
	height: 400px;
	padding: 10px 5px 10px;
	margin: 5px;
	border: 1px solid #DAD9FF;
	cursor: pointer;
}
.subject {
     width:200px;
     height:20px;
     line-height:25px;
     margin:5px auto;
     border-top: 1px solid #DAD9FF;
     display: inline-block;
     white-space:nowrap;
     overflow:hidden;
     text-overflow:ellipsis;
     cursor: pointer;
}
.ui-dialog-titlebar{
   background: none;
    color: black;
    border: none;
    border-bottom: 1px solid #e4e4e4;
    border-radius: 0px;
}
.ui-dialog .ui-dialog-titlebar {
    padding-left: 0px;
}
.ui-dialog{
   padding: 5px 20px;
   border-radius: 0px;
   position: fixed;
   
}
.dialog_cancel{
   background: white;
   color:#262626;
   border: 1px solid #d8d8d8;
   width: 25%;
   padding: 5px 0px;
}

.dialog_submit{
   background: #D96262;
   color: white;
   border: 1px solid #D96262;
   width: 25%;
   padding: 5px 0px;
}

</style>

<script type="text/javascript">

$(document).ready(function(){
	var info="${sort}";
	
	if(info=="ing"){
		$(".ing").css("font-weight","bold");
	}else{
		$(".end").css("font-weight","bold");
	}
});

function searchList() {
	var f=document.searchForm;
	f.submit();
}

function article() {
	var url="${articleUrl}&eventNum="+$("input[name=eventNum]").val();
	location.href=url;
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


function eventDetail(eventNum){
	var url = "<%=cp%>/event/eventDetail";
	var query = "eventNum="+eventNum;
	
	var fn=function(data) {
		var list = data.list;
		$("#eventSubject").text(list[0].subject);
		$("#eventImg").attr("src", "<%=cp%>/uploads/event/"+list[0].imageFileName);
		$("input[name=eventNum]").val(list[0].eventNum);
	}
	
	ajaxJSON(url, "get", query, fn);
	
	$('#eventDetail_dialog').dialog({
		  modal: true,
		  height: 750,
		  width: 1000,
		  bottom: 120,
		  title: '이벤트',
		  close: function(event, ui) {
		  },
		  open: function(event, ui) {
			  $(".ui-dialog-titlebar-close", $(this).parent()).hide();
		  }
	});
	
}
	
	
$(function(){
	$(".btnDialogCancel").click(function(){
		$('#eventDetail_dialog').dialog("close");
	});
});

</script>

<div class="container-board">
	<div class="body-title">
		<span style="font-family: Webdings"><i class="fas fa-cookie-bite"></i></i> 이벤트</span>
	</div>
	
	<div>
		<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
			<tr height="35">
				<td align="left" width="50%">
					전체 게시글 <span style="color: #D96262;">${dataCount}</span> 건 / 총 <span style="color: #D96262;">${total_page}</span> 페이지
				</td>
				<td align="right">
					&nbsp;
				</td>
				<td style="text-align: right; width: 50%; color: #51321b;">
					<a class="ing" href="<%=cp%>/event/list?sort=ing">진행중인 이벤트&nbsp;</a>&nbsp;|&nbsp;
					<a class="end" href="<%=cp%>/event/list?sort=end">종료된 이벤트</a>
				</td>
			</tr>
		</table>
		
		<table style="width: 100%; margin: 0px auto; border-spacing: 0px; height: 500px;">
			<c:forEach var="dto" items="${list}" varStatus="status">
				<c:if test="${status.index==0}">
					<tr>
				</c:if>
				<c:if test="${status.index!=0 && status.index%4==0}">
					<c:out value="</tr><tr>" escapeXml="false"/>
				</c:if>
				<td width="240" align="center">
					<div class="imgLayout">
						<img src="<%=cp%>/uploads/event/${dto.imageFileName}" width="200" 
						height="340" border="0" onclick="eventDetail('${dto.eventNum}')">
						<span class="subject" onclick="eventDetail('${dto.eventNum}')" >
						${dto.subject}
						</span>
						<span class="subject" onclick="eventDetail('${dto.eventNum}');" >
						${dto.startDate}&nbsp;~&nbsp;${dto.endDate}
						</span>
					</div>
				</td>
			</c:forEach>
			
			<c:set var="n" value="${list.size()}"/>
			<c:if test="${n>0&&n%4!=0}">
				<c:forEach var="i" begin="${n%4+1}" end="4" step="1">
					<td width="210">
						<div class="imgLayout">&nbsp;</div>
					</td>
				</c:forEach>
			</c:if>
			
			<c:if test="${n!=0 }">
				<c:out value="</tr>" escapeXml="false"/>
			</c:if>
		</table>
		
		<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			<tr height="35">
				<td align="center">
					${dataCount==0?"등록된 게시물이 없습니다.":paging}
				</td>
			</tr>
		</table>
		
		<table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
			<tr height="40">
				<td align="left" width="100">
					<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/event/list';">새로고침</button>
				</td>
				<td align="center">
					<form name="searchForm" action="<%=cp%>/event/list" method="post">
						<select name="condition" class="selectField">
							<option value="all" ${condition=="all"?"selected='selected'":""}>모두</option>
							<option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
							<option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
							<option value="userName" ${condition=="userName"?"selected='selected'":""}>작성자</option>
							<option value="created" ${condition=="created"?"selected='selected'":""}>등록일</option>
						</select>
						<input type="text" name="keyword" value="${keyword}" class="boxTF">
						<button type="button" class="btn" onclick="searchList()">검색</button>
					</form>
				</td>
				<td align="right" width="100">
				<c:if test="${fn:indexOf(sessionScope.member.userId,'admin') == 0}">
					<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/event/created';">등록하기</button>
				</c:if>
				</td>
			</tr>
		</table>
	</div>
	
	<div id="eventDetail_dialog" style="display: none; text-align: left; border-top-width: 50px;">
		<input type="hidden" name="eventNum">
			<img id="eventImg" alt="" src="">
				
			<div class="btn_box" align="center" style="padding-top: 20px;">
				<button type="button" class="btnDialogCancel dialog_cancel">취소</button>
				<button type="button" class="dialog_submit" onclick="article();">상세보기</button>
			</div>
			
		</form>
	</div>
	
</div>