<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript" src="<%=cp%>/resource/se/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
    function sendOk() {
        var f = document.boardForm;
        

    	var str = f.subject.value;
        if(!str) {
            alert("제목을 입력하세요. ");
            f.subject.focus();
            return;
        }

    	str = f.content.value;
    	console.log(str);
        if(!str) {
            alert("내용을 입력하세요. ");
            f.content.focus();
            return;
        }
		
   		f.action="<%=cp%>/mypage/${mode}";

        f.submit();
        
        return true;
   }

</script>

<div class="body-container" style="width: 830px; margin: 20px auto 0px; border-spacing: 0px;">
	

<form name="boardForm" method="post" enctype="multipart/form-data" onsubmit="return submitContents(this);">
  <table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
  <tbody id="requesttb">

  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
      <td width="100" bgcolor="#eeeeee" style="text-align: center;">작성자</td>
      <td style="padding-left:10px;"> 
          ${sessionScope.member.nickName}
      </td>
  </tr>

  <tr align="left" style="border-bottom: 1px solid #cccccc;"> 
      <td width="100" bgcolor="#eeeeee" style="text-align: center; padding-top:5px;" valign="top">사&nbsp;&nbsp;&nbsp;&nbsp;유</td>
      <td valign="top" style="padding:5px 0px 5px 10px;"> 
        <textarea id="content" name="content" rows="12" class="boxTA" style="width: 95%;">${dto.content}</textarea>
      </td>
  </tr>
  
  </table>

  <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
     <tr height="45"> 
      <td align="center" >
	        <button type="submit" class="btn">$(mode=='refund'?'환불신청':'교환신청'}</button>
	        <button type="reset" class="btn">다시입력</button>
	        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/qna/list';">${mode=='refund'?'환불취소':'교환취소'}</button>
	         <c:if test="${mode=='updateQuestion' || mode=='updateAnswer'}">
	         	 <input type="hidden" name="qnaNum" value="${dto.qnaNum}">
	        	 <input type="hidden" name="pageNo" value="${pageNo}">
	        </c:if>
	        <c:if test="${mode=='insertAnswer' || mode=='updateAnswer' || mode=='deleteAnswer'}">
	        	<input type="hidden" name="qnaNum" value="${dto.qnaNum}">
	        	<input type="hidden" name="parent" value="${dto.qnaNum}">
	        	<input type="hidden" name="pageNo" value="${pageNo}">
	        </c:if>
      </td>
    </tr>
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
		return sendOk();
	} catch(e) {}
}

function setDefaultFont() {
	var sDefaultFont = '돋움';
	var nFontSize = 24;
	oEditors.getById["content"].setDefaultFont(sDefaultFont, nFontSize);
}
</script>