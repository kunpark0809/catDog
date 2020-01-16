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
<link rel="stylesheet" href="/css/jquery.datetimepicker.css" type="text/css" />
<script type="text/javascript" src="/js/jquery.datetimepicker.js"></script>
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
     if(mode=="created"||mode=="update" && f.mainUpload.value!="") {
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
	      $td=$("<td>", {width:"100", bgcolor:"#51321b", style:"text-align: center; color: white; font-weight: bold;", html:"본문사진"});
	      $tr.append($td);
	      $td=$("<td style='padding-left:10px; color: white;'>");
	      $input=$("<input>", {type:"file", name:"upload", class:"boxTF", style:"width: 95%; height: 25px; color: #000000; font-weight: bold;"});
	      $td.append($input);
	      $tr.append($td);
	    
	      $("#eventb").append($tr);
	});
});

<c:if test="${mode=='update'}">
function deleteFile(eventPicNum) {
		var url="<%=cp%>/event/update/deleteFile";
		$.post(url, {eventPicNum:eventPicNum}, function(data){
			$("#f"+eventPicNum).remove();
		}, "json");
}
</c:if>

/* $(function() {
		$("form input[name=startDate]").datepicker({showMonthAfterYear:true});
		$("form input[name=endDate]").datepicker({showMonthAfterYear:true});
		
		$
});
 */
 $( function() {
    $("input[name='startDate']").datepicker( {
        onClose : function( selectedDate ) {  // 날짜를 설정 후 달력이 닫힐 때 실행
                      if( selectedDate != "" ) {
                          // yyy의 minDate를 xxx의 날짜로 설정
                          $("input[name='endDate']").datepicker("option", "minDate", selectedDate);
                      }
                  }
    } );

    $("input[name='endDate']").datepicker( {
        onClose : function( selectedDate ) {  // 날짜를 설정 후 달력이 닫힐 때 실행
                      if( selectedDate != "" ) {
                          // xxx의 maxDate를 yyy의 날짜로 설정
                          $("input[name='startDate']").datepicker("option", "maxDate", selectedDate);
                      }
                  }
    } );
} );

</script>

<div class="container-board">
	<div class="body-title">
		<span style="font-family: Webdings"><i class="fas fa-cookie-bite"></i> 이벤트</span>
	</div>
	
	<div>
		<form name="eventForm" method="post" enctype="multipart/form-data">
			<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			<tbody id="eventb">
				<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
					<td width="100" bgcolor="#51321b" style="text-align: center; font-weight: bold; color: white;">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
					<td style="padding-left:10px;">
						<input type="text" name="subject" maxlength="100" class="boxTF" style="width: 95%;" value="${list.get(0).subject}">
					</td>
				</tr>
				
				<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc; font-weight: bold;">
					<td width="100" bgcolor="#51321b" style="text-align: center; color: white;">작&nbsp;성&nbsp;자</td>
					<td style="padding-left:10px;">
						${sessionScope.member.nickName}
					</td>
				</tr>
				
				<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
					<td width="100" bgcolor="#51321b" style="text-align: center; font-weight: bold; color: white;">시&nbsp;작&nbsp;일</td>
					<td style="padding-left:10px;">
						<p style="margin-top: 1px; margin-bottom: 5px;">
						<input type="text" name="startDate" maxlength="10" class="boxTF" readonly="readonly" style="width: 20%; text-align: center; background: #ffffff;">
						</p>
					</td>
				</tr>
				
				<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
					<td width="100" bgcolor="#51321b" style="text-align: center; font-weight: bold; color: white;">종&nbsp;료&nbsp;일</td>
					<td style="padding-left:10px;">
						<input type="text" name="endDate" maxlength="10" class="boxTF" readonly="readonly" style="width: 20%; text-align: center; background: #ffffff;">
					</td>
				</tr>
				
				<tr align="left" style="border-bottom: 1px solid #cccccc;">
					<td width="100" bgcolor="#51321b" style="text-align: center; padding-top:5px; font-weight: bold; color: white;" valign="top">설&nbsp;&nbsp;&nbsp;&nbsp;명</td>
					<td valign="top" style="padding:5px 0px 5px 10px;">
						<textarea name="content" rows="12" class="boxTA" style="width: 95%;">${list.get(0).content}</textarea>
					</td>
				</tr>  
				<c:if test="${mode=='created'}">	
					<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
						<td width="100" bgcolor="#51321b" style="text-align: center; font-weight: bold; color: white;">썸네일사진</td>
						<td style="padding-left:10px;">
							<input type="file" name="mainUpload" class="boxTF" size="53" style="height: 25px; font-weight: bold;" >
							${image.imageFileName}
						</td>
					</tr>
					<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
				    	<td width="100" bgcolor="#51321b" style="text-align: center; font-weight: bold; color: white;">본문사진</td>
				    	<td style="padding-left:10px;"> 
				       		<input type="file" name="upload" class="boxTF" size="53" style="height: 25px; font-weight: bold;">
				       		${image.imageFileName}
				      	</td>
				 	</tr>
				</c:if>	
				
				<c:forEach var="image" items="${list}">
					<c:if test="${fn:indexOf(image.imageFileName,'main') >= 0}">
						<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
							<td width="100" bgcolor="#51321b" style="text-align: center; font-weight: bold; color: white;">썸네일사진</td>
							<td style="padding-left:10px;">
								<input type="file" name="mainUpload" class="boxTF" size="53" style="height: 25px;">
								${image.imageFileName}
							</td>
						</tr>
					</c:if>
					<c:if test="${fn:indexOf(image.imageFileName,'main') < 0}">
						<tr id="f${image.eventPicNum}" align="left" height="40" style="border-bottom: 1px solid #cccccc;">
					    	<td width="100" bgcolor="#51321b" style="text-align: center; font-weight: bold; color: white;">본문사진</td>
					    	<td style="padding-left:10px;"> 
					       		<input type="file" name="upload" class="boxTF" size="53" style="height: 25px; font-weight: bold;">
					       			<a href="javascript:deleteFile('${image.eventPicNum}');"><i class="far fa-trash-alt"></i></a> 
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
						<button type="button" class="bts" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}</button>
						<button type="reset" class="bts">다시입력</button>
						<button type="button" class="bts" onclick="javascript:location.href='<%=cp%>/event/list';">${mode=='update'?'수정취소':'등록취소'}</button>
							<c:if test="${mode=='update'}">
								<input type="hidden" name="eventNum" value="${list.get(0).eventNum}">
								<input type="hidden" name="eventPicNum" value="${list.get(0).eventPicNum}">
								<input type="hidden" name="imageFilename" value="${list.get(0).imageFileName}">
								<input type="hidden" name="page" value="${page}">
							</c:if>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>s