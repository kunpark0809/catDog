<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String cp=request.getContextPath();
%>

<style type="text/css">
.textDate {
	font-weight: 500;
	cursor: pointer;
	display: block;
	color: #333333;
}
</style>

<script type="text/javascript">

function sendOk() {
	var f = document.eventForm;

    var str = f.subject.value;
    if(!str) {
    	alert("제목을 입력하세요. ");
        f.subject.focus();
        return;
    }
	
    str = f.startDate.value;
    if(!str) {
         alert("시작일을 입력하세요. ");
         f.startDate.focus();
         return;
    }
    
    str = f.endDate.value;
    if(!str) {
         alert("종료일을 입력하세요. ");
         f.endDate.focus();
         return;
    }
    
    str = f.content.value;
    if(!str) {
         alert("내용을 입력하세요. ");
         f.content.focus();
         return;
    }

     var mode="${mode}";
     if(mode=="created"||mode=="update" && f.upload.value!="") {
    	if(! /(\.gif|\.jpg|\.png|\.jpeg)$/i.test(f.mainUpload.value)) {
    		alert('이미지 파일만 가능합니다.(bmp 파일은 불가) !!!');
    		f.mainUpload.focus();
    		return;
    	}
     }
     
     f.action="<%=cp%>/event/${mode}";

	  f.submit();
}

$(function(){
	$("body").on("change", "input[name=upload]", function(){
		if(! $(this).val()) {
			return;
		}
		
		var b=false;
		$("input[name=upload]").each(function(){
			if(! $(this).val()) {
				b=true;
				return false;
			}
		});
		
		if(b) return;
		
		var $tr, $td, $input;
		
		$tr=$("<tr align='left' height='40' style='border-bottom: 1px solid #cccccc;'>");
	      $td=$("<td>", {width:"100", bgcolor:"#262626", style:"text-align: center;", html:"본문사진"});
	      $tr.append($td);
	      $td=$("<td style='padding-left:10px; color: #262626;'>");
	      $input=$("<input>", {type:"file", name:"upload", class:"boxTF", style:"width: 95%; height: 25px;"});
	      $td.append($input);
	      $tr.append($td);
	    
	      $("#eventb").append($tr);
	});
});


$(function() {
		$("form input[name=startDate]").datepicker({showMonthAfterYear:true});
		$("form input[name=endDate]").datepicker({showMonthAfterYear:true});
});

</script>

<div class="body-container" style="width: 700px; margin: 20px auto 10px;">
	<div class="body-title">
		<h3><i class="far fa-image"></i> 이벤트 </h3>
	</div>
	
	<div>
		<form name="eventForm" method="post" enctype="multipart/form-data">
			<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			<tbody id="eventb">
				<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
					<td width="100" bgcolor="#eeeeee" style="text-align: center;">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
					<td style="padding-left:10px;">
						<input type="text" name="subject" maxlength="100" class="boxTF" style="width: 95%;" value="${list.get(0).subject}">
					</td>
				</tr>
				
				<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
					<td width="100" bgcolor="#eeeeee" style="text-align: center;">작&nbsp;성&nbsp;자</td>
					<td style="padding-left:10px;">
						${sessionScope.member.nickName}
					</td>
				</tr>
				
				<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
					<td width="100" bgcolor="#eeeeee" style="text-align: center;">시&nbsp;작&nbsp;일</td>
					<td style="padding-left:10px;">
						<p style="margin-top: 1px; margin-bottom: 5px;">
						<input type="text" name="startDate" maxlength="10" class="boxTF" readonly="readonly" style="width: 20%; text-align: center; background: #ffffff;">
						</p>
					</td>
				</tr>
				
				<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
					<td width="100" bgcolor="#eeeeee" style="text-align: center;">종&nbsp;료&nbsp;일</td>
					<td style="padding-left:10px;">
						<input type="text" name="endDate" maxlength="10" class="boxTF" readonly="readonly" style="width: 20%; text-align: center; background: #ffffff;">
					</td>
				</tr>
				
				<tr align="left" style="border-bottom: 1px solid #cccccc;">
					<td width="100" bgcolor="#eeeeee" style="text-align: center; padding-top:5px;" valign="top">설&nbsp;&nbsp;&nbsp;&nbsp;명</td>
					<td valign="top" style="padding:5px 0px 5px 10px;">
						<textarea name="content" rows="12" class="boxTA" style="width: 95%;">${list.get(0).content}</textarea>
					</td>
				</tr>
				<c:if test="${mode=='created'}">	
					<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
						<td width="100" bgcolor="#eeeeee" style="text-align: center;">썸네일사진</td>
						<td style="padding-left:10px;">
							<input type="file" name="mainUpload" class="boxTF" size="53" style="height: 25px;" >
							${image.imageFileName}
						</td>
					</tr>
					<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
				    	<td width="100" bgcolor="#eeeeee" style="text-align: center; font-weight: bold;">본문사진</td>
				    	<td style="padding-left:10px;"> 
				       		<input type="file" name="upload" class="boxTF" size="53" style="height: 25px;">
				       		${image.imageFileName}
				      	</td>
				 	</tr>
				</c:if>	
				
				<c:forEach var="image" items="${list}">
					<c:if test="${fn:indexOf(image.imageFileName,'main') >= 0}">
						<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
							<td width="100" bgcolor="#eeeeee" style="text-align: center;">썸네일사진</td>
							<td style="padding-left:10px;">
								<input type="file" name="mainUpload" class="boxTF" size="53" style="height: 25px;" >
								${image.imageFileName}
							</td>
						</tr>
					</c:if>
					<c:if test="${fn:indexOf(image.imageFileName,'main') < 0}">
						<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
					    	<td width="100" bgcolor="#eeeeee" style="text-align: center; font-weight: bold;">본문사진</td>
					    	<td style="padding-left:10px;"> 
					       		<input type="file" name="upload" class="boxTF" size="53" style="height: 25px;">
					       		${image.imageFileName}
					      	</td>
					 	</tr>
					 	
					</c:if>
				</c:forEach>
			</tbody>
			</table>
			
			<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
				<tr height="45">
					<td align="center">
						<button type="button" class="btn" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}</button>
						<button type="reset" class="btn">다시입력</button>
						<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/event/list';">${mode=='update'?'수정취소':'등록취소'}</button>
							<c:if test="${mode=='update'}">
								<input type="hidden" name="eventNum" value="${list.get(0).eventNum}">
								<input type="hidden" name="imageFilename" value="${dto.imageFileName}">
								<input type="hidden" name="page" value="${page}">
							</c:if>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>s