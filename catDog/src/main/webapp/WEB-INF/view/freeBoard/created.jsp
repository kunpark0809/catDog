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

<script type="text/javascript" src="<%=cp%>/resource/se/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
 function check() {
     var f = document.freeBoardForm;

 	var str = f.subject.value;
     if(!str) {
         alert("제목을 입력하세요. ");
         f.subject.focus();
         return false;
     }

 	str = f.content.value;
     if(!str) {
         alert("내용을 입력하세요. ");
         f.content.focus();
         return false;
     }
   
 	f.action="<%=cp%>/freeBoard/${mode}";
 	
 	f.submit();
 }

</script>

<div class="container-board">
	 <div class="body-title">
		<span style="font-family: Webdings">자유게시판</span>
	</div>
	
		<form name="freeBoardForm" method="post" enctype="multipart/form-data" onsubmit="return submitContents(this);">
			<div class="container" style="color: white;">
			
				
			  <table style="width: 100%; margin: 20px auto 10px; border-spacing: 0px; border-collapse: collapse;">
			  <tbody id="freeBoardb">
			
			  
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#51321b" style="text-align: center; font-weight: bold;">제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</td>
			      <td style="padding-left:10px;"> 
			        <input type="text" name="subject" maxlength="100" class="boxTF" style="width: 100%;" value="${dto.subject}">
			      </td>
			  </tr>
			
			<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
					<td width="100" bgcolor="#51321b" style="text-align: center; font-weight: bold;">공지여부</td>
					<td style="padding-left:10px;">
						<input type="checkbox" name="notice" value="1" ${dto.notice==1?"checked='checked'":""}> <label>공지</label>
					</td>
			  </tr>
			
			  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#51321b" style="text-align: center; font-weight: bold;">작&nbsp;&nbsp;성&nbsp;&nbsp;자</td>
			      <td style="padding-left:10px; color: #262626">
			           ${sessionScope.member.nickName}
			      </td>
			  </tr>

			  <tr align="left" style="border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#51321b" style="text-align: center; padding-top:5px; font-weight: bold;" valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;용</td>
			      <td valign="top" style="padding:5px 0px 5px 10px;"> 
			        <textarea name="content" id="content" class="boxTA" style="width: 100%;">${dto.content}</textarea>
			      </td>
			  </tr>
			  
			
			</table>
			</div>
			<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			     <tr height="45"> 
			      <td align="center">
			        <button type="submit" class="bts">${mode=='update'?'수정완료':'등록하기'}</button>
			        <button type="reset" class="bts">다시입력</button>
			        <button type="button" class="bts" onclick="javascript:location.href='<%=cp%>/freeBoard/list';">${mode=='update'?'수정취소':'등록취소'}</button>
			        	<c:if test="${mode=='update'}">
								<input type="hidden" name="bbsNum" value="${dto.bbsNum}">
								<input type="hidden" name="page" value="${page}">
						</c:if>
			      </td>
			    </tr>
			   </tbody>
			</table>
		</form>
    </div>

<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "content",
	sSkinURI: "<%=cp%>/resource/se/SmartEditor2Skin.html",	
	htParams : {bUseToolbar : true,
		fOnBeforeUnload : function(){
			//alert("아싸!");
		}
	}, //boolean
	fOnAppLoad : function(){
		//예제 코드
		//oEditors.getById["content"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
	},
	fCreator: "createSEditor2"
});

function pasteHTML() {
	var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
	oEditors.getById["content"].exec("PASTE_HTML", [sHTML]);
}

function showHTML() {
	var sHTML = oEditors.getById["content"].getIR();
	alert(sHTML);
}
	
function submitContents(elClickedObj) {
	oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
	
	// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("content").value를 이용해서 처리하면 됩니다.
	
	try {
		// elClickedObj.form.submit();
		return check();
	} catch(e) {}
}

function setDefaultFont() {
	var sDefaultFont = '돋움';
	var nFontSize = 24;
	oEditors.getById["content"].setDefaultFont(sDefaultFont, nFontSize);
}
</script>