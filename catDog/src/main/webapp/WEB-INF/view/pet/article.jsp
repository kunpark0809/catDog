<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String cp=request.getContextPath();
%>
<style type="text/css">
.btn {
	width:70px;
    background-color: #262626;
    border: none;
    color:#ffffff;
    padding: 10px 0;
    text-align: center;
    display: inline-block;
    font-size: 15px;
    margin: 4px;
    border-radius:10px;
}

.btn2 {
	width:50px;
    background-color: white;
    border: 1px dashed #262626;
    color:#262626;
    padding: 5px 0;
    text-align: center;
    display: inline-block;
    font-size: 15px;
    margin: 4px;
    border-radius:10px;
}

</style>

<script type="text/javascript">
function login() {
	location.href="<%=cp%>/member/login";
}

function deletePet(myPetNum) {
	<c:if test="${sessionScope.member.userId=='userId' || sessionScope.member.userId=='admin' || sessionScope.member.userId=='admin2' || sessionScope.member.userId=='admin3'}">
	var q = "myPetNum="+myPetNum+"&${query}";
    var url = "<%=cp%>/pet/delete?" + q;

    if(confirm("위 게시물을 삭제 하시겠습니까 ? "))
  	  location.href=url;
</c:if>    
<c:if test="${sessionScope.member.userId!='userId' && sessionScope.member.userId!='admin' && sessionScope.member.userId!='admin2' && sessionScope.member.userId!='admin3'}">
  alert("게시물을 삭제할 수 없습니다.");
</c:if>
}

function updatePet(myPetNum) {
	<c:if test="${sessionScope.member.userId==dto.userId}">
		var q = "myPetNum=${dto.myPetNum}&page=${page}";
	    var url = "<%=cp%>/pet/update?" + q;

	    location.href=url;
	</c:if>

	<c:if test="${sessionScope.member.userId!=dto.userId }">
	   alert("게시물을 수정할 수 없습니다.");
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

// 게시글 공감 여부
$(function(){
	$(".btnSendPetLike").click(function(){
		if(! confirm("게시물에 좋아요를 누르시겠습니까?")) {
			return false;
		}
		
		var url="<%=cp%>/pet/insertPetLike";
		var myPetNum="${dto.myPetNum}";
		var query = {myPetNum:myPetNum};
		
		var fn = function(data){
			var state=data.state;
			if(state=="true") {
				var count = data.petLikeCount;
				$("#petLikeCount").text(count);
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

$(function(){
	$(".btnDialogCanecl").click(function(){
		$('#report_dialog').dialog("close");
	});
});

$(function(){
	$(".btnDialogOn").click(function(){
		if(! confirm("해당 게시글을 신고하시겠습니까?")) {
			return false;
		}
		var url="<%=cp%>/pet/insertPetReport";
		var reportNum="${dto.reportNum}";
		var query = {reportNum:reportNum};
		
		var fn = function(data){
			var state=data.state;
			if(state=="true") {
				var count = data.petReportCount;
				$("#petReportCount").text(count);
			} else if(state=="false") {
				alert("신고는 한번만 가능합니다.");
			}
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});

</script>


<div class="body-container" style="width: 700px; margin: 20px auto 10px; text-align: center;">
	<div class="body-title">
		<h3>내새끼자랑</h3>
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
				이름 : ${dto.nickName}
				</td>
			</tr>
			
			<tr>
				<td colspan="2" align="center" style="padding: 10px 5px;">
					<img src="<%=cp%>/uploads/pet/${dto.imageFileName}" style="max-width:100%; height:auto; resize:both;">
				</td>
			</tr>
			
			<tr>
				<td colspan="2" height="40" style="padding-bottom: 15px;" align="center">
					<button type="button" class="btn btnSendPetLike" title="좋아요"><i class="fas fa-hand-point-up"></i>&nbsp;&nbsp;<span id="petLikeCount">${dto.petLikeCount}</span></button>
				</td>
			</tr>
			
		<tr>
			<td align="right" width="100%">
				<button type="button" class="btn2" onclick="report();">신고</button>
			</td>
		</tr>	
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td colspan="2" align="left" style="padding-left: 5px;">
				이전글 :
					<c:if test="${not empty preReadPet}">
						<a href="<%=cp%>/pet/article?${query}&myPetNum=${preReadPet.myPetNum}">${preReadPet.subject}</a>
					</c:if>
				</td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td colspan="2" align="left" style="padding-left: 5px;">
				다음글 :
					<c:if test="${not empty nextReadPet}">
						<a href="<%=cp%>/pet/article?${query}&myPetNum=${nextReadPet.myPetNum}">${nextReadPet.subject}</a>
					</c:if>
				</td>
			</tr>
		</table>
		
		<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
			<tr height="45">
				<td  width="300" align="left">
					<c:if test="${sessionScope.member.userId==dto.userId}">
						<button type="button" class="btn" onclick="updatePet('${dto.myPetNum}');">수정</button>
					</c:if>
					<c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin' || sessionScope.member.userId=='admin2' || sessionScope.member.userId=='admin3'}">
						<button type="button" class="btn" onclick="deletePet('${dto.myPetNum}');">삭제</button>
					</c:if>
				</td>
				
				<td align="right">
					<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/pet/list?${query}';">리스트</button>
				</td>
			</tr>
		</table>
	</div>
	
		
	<div id="report_dialog" style="display: none; text-align: left;">
			<strong>신고사유 : 대표적인 사유 1개를 선택해 주세요</strong>
			<br><br>
		<form>
			<input type="radio" name="report" value="1"/>&nbsp;타 웹사이트 홍보<br>
			<input type="radio" name="report" value="2"/>&nbsp;도색적이고 폭력적인 내용<br>
			<input type="radio" name="report" value="3"/>&nbsp;욕설 및 모욕적인 언행<br>
			<input type="radio" name="report" value="4"/>&nbsp;현행법에 저촉되는 행위(불법거래, 저작권 등)<br>
			<input type="radio" name="report" value="5"/>&nbsp;기타<br>
			
				<div class="btn_box" align="center">
					<button type="button" class="btnDialogCanecl">취소</button>
					<button type="button" class="btnDialogOn" onclick="javascript:location.href='<%=cp%>/pet/list';">신고하기</button>
				</div>
		</form>
	</div>
	
	
</div>