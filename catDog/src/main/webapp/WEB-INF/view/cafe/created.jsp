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
</style>

<script type="text/javascript" src="<%=cp%>/resource/se/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
 function check() {
     var f = document.cafeForm;

 	var str = f.placeName.value;
     if(!str) {
         alert("장소 이름을 입력하세요. ");
         f.placeName.focus();
         return false;
     }

     str = f.addr.value;
     if(!str) {
         alert("주소를 입력하세요. ");
         f.addr.focus();
         return false;
     }
     
     str = f.tel.value;
     if(!str) {
         alert("전화번호를 입력하세요. ");
         f.tel.focus();
         return false;
     }

     
 	str = f.content.value;
     if(!str) {
         alert("내용을 입력하세요. ");
         f.content.focus();
         return false;
     }
     
     var mode="${mode}";
     if(mode=="created"||mode=="update" && $f.main.value!="") {
 		if(! /(\.gif|\.jpg|\.png|\.jpeg)$/i.test(f.main.value)) {
 			alert('이미지 파일만 업로드 가능합니다.');
 			f.main.focus();
 			return false;
 		}
 	}
     
   
 	f.action="<%=cp%>/cafe/created";
 	return true;
 }

 
 
</script>



<div class="page-section" id="command" style="text-align: center;">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<p class="section-heading text-uppercase" style="font-size: 45px; font-weight:bold; border-bottom: 3px solid; padding-bottom: 20px;">카페/식당</p>
				</div>
			</div>
    	</div>
    <div>
		<form name="cafeForm" method="post" enctype="multipart/form-data" onsubmit="return submitContents(this);">
			<div class="container" style="color: white;">
			
				
			  <table style="width: 100%; margin: 20px auto 10px; border-spacing: 0px; border-collapse: collapse;">
			  <tbody id="cafeb">
			  
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#51321b" style="text-align: center; font-weight: bold;">장소이름</td>
			      <td style="padding-left:10px;"> 
			        <input type="text" name="placeName" maxlength="100" class="boxTF" style="width: 100%;" value="${dto.placeName}">
			      </td>
			  </tr>
			
			  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#51321b" style="text-align: center; font-weight: bold;">작&nbsp;&nbsp;성&nbsp;&nbsp;자</td>
			      <td style="padding-left:10px; color: #262626">
			           ${sessionScope.member.nickName}
			      </td>
			  </tr>
			  
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#51321b" style="text-align: center; font-weight: bold;">주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</td>
			      <td style="padding-left:10px;"> 
			        <input type="text" name="addr" maxlength="100" class="boxTF" style="width: 100%;" value="${dto.addr}">
			      </td>
			  </tr>
			  
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#51321b" style="text-align: center; font-weight: bold;">전화번호</td>
			      <td style="padding-left:10px;"> 
			        <input type="text" name="tel" maxlength="100" class="boxTF" style="width: 40%;" value="${dto.tel}">
			      </td>
			  </tr>
			
			  <tr align="left" style="border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#51321b" style="text-align: center; padding-top:5px; font-weight: bold;" valign="top">상세정보</td>
			      <td valign="top" style="padding:5px 0px 5px 10px;"> 
			        <textarea name="content" id="content" class="boxTA" style="width: 100%;">${dto.content}</textarea>
			      </td>
			  </tr>
			  
			<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
		    	<td width="100" bgcolor="#51321b" style="text-align: center; font-weight: bold;">본문사진</td>
		    	<td style="padding-left:10px;"> 
		       		<input type="file" name="upload" class="boxTF" size="53" style="height: 25px; color: black;">
		       		${dto.imageFileName}
		      	</td>
		 	</tr>
			</table>
			</div>
			<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			     <tr height="45"> 
			      <td align="center">
			        <button type="submit" class="bts">${mode=='update'?'수정완료':'등록하기'}</button>
			        <button type="reset" class="bts">다시입력</button>
			        <button type="button" class="bts" onclick="javascript:location.href='<%=cp%>/cafe/list';">${mode=='update'?'수정취소':'등록취소'}</button>
			        	<c:if test="${mode=='update'}">
								<input type="hidden" name="recommendNum" value="${dto.recommendNum}">
								<input type="hidden" name="imageFilename" value="${dto.imageFileName}">
								<input type="hidden" name="page" value="${page}">
						</c:if>
			      </td>
			    </tr>
			   </tbody>
			</table>
		</form>
    </div>
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