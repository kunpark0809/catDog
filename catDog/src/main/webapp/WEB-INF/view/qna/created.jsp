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
		
   		f.action="<%=cp%>/qna/${mode}";

        f.submit();
        
        return true;
   }

</script>

<div class="container-board">
	<div class="body-title">
		<span><i class="fas fa-question-circle"></i>&nbsp;질문과 답변</span>
	</div>

<form name="boardForm" method="post" enctype="multipart/form-data" onsubmit="return submitContents(this);">
  <table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
  <tbody id="qnatb">
  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
      <td width="100" bgcolor="#51321b" style="text-align: center; font-weight: bold; color: white;">분&nbsp;&nbsp;&nbsp;&nbsp;류</td>
      <td style="padding-left:10px;"> 
        <select name="qnaCategoryNum" class="selectField" ${(mode!='created' && (mode!='updateQuestion' || mode=="updateAnswer" || mode=="insertAnswer")) ? "disabled='disabled'":""}>
        	<c:forEach var="vo" items="${listCategory}">
        		<option value="${vo.qnaCategoryNum}" ${vo.qnaCategoryNum==dto.qnaCategoryNum?"selected='selected'":""}>${vo.qnaCategory}</option>
        	</c:forEach>
        </select>
        
        <c:if test="${mode!='created' && mode!='updateQuestion' || mode=='updateAnswer'}">
        	<input type="hidden" name="qnaCategoryNum" value="${dto.qnaCategoryNum}">
        </c:if>
      </td>
  </tr>

  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
      <td width="100" bgcolor="#51321b" style="text-align: center; font-weight: bold; color: white;">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
      <td style="padding-left:10px;"> 
        <input type="text" name="subject" maxlength="100" class="boxTF" style="width: 95%; border-radius:5px;" value="${dto.subject}"
               ${(mode=="insertAnswer" || mode=="updateAnswer") ? "readonly='readonly'":"" }>
      </td>
  </tr>

  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
      <td width="100" bgcolor="#51321b" style="text-align: center; font-weight: bold; color: white;">작성자</td>
      <td style="padding-left:10px;"> 
          ${sessionScope.member.nickName}
      </td>
  </tr>

  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
      <td width="100" bgcolor="#51321b" style="text-align: center; font-weight: bold; color: white;">공개여부</td>
      <td style="padding-left:10px;">
        <input type="radio" name="questionPrivate" value="0" ${empty dto || dto.questionPrivate==0?"checked='checked'":"" }> 공개
        <input type="radio" name="questionPrivate" value="1" ${dto.questionPrivate==1?"checked='checked'":"" }> 비공개
      </td>
  </tr>

  <tr align="left" style="border-bottom: 1px solid #cccccc;"> 
      <td width="100" bgcolor="#51321b" style="text-align: center; font-weight: bold; padding-top:5px; color: white;" valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
      <td valign="top" style="padding:5px 0px 5px 10px;"> 
      	<c:if test="${mode!='insertAnswer' && mode!='updateAnswer'}">
        <textarea id="content" name="content" rows="12" class="boxTA" style="width: 95%;">${dto.content}</textarea>
        </c:if>
        <c:if test="${mode=='insertAnswer' || mode=='updateAnswer'}">
        <textarea id="content" name="content" rows="12" class="boxTA" style="width: 95%;">${dto.content}</textarea>
        </c:if>
      </td>
  </tr>
  
  </table>

  <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
     <tr height="45"> 
      <td align="center" >
	        <button type="submit" class="bts">${(mode=='updateQuestion' || mode=='updateAnswer')?'수정완료':'등록하기'}</button>
	        <button type="reset" class="bts">다시입력</button>
	        <button type="button" class="bts" onclick="javascript:location.href='<%=cp%>/qna/list';">${(mode=='updateQuestion' || mode=='updateAnswer')?'수정취소':'등록취소'}</button>
	         <c:if test="${mode=='updateQuestion' || mode=='updateAnswer'}">
	         	 <input type="hidden" name="qnaNum" value="${dto.qnaNum}">
	        	 <input type="hidden" name="page" value="${page}">
	        </c:if>
	        <c:if test="${mode=='insertAnswer' || mode=='updateAnswer' || mode=='deleteAnswer'}">
	        	<input type="hidden" name="qnaNum" value="${dto.qnaNum}">
	        	<input type="hidden" name="parent" value="${dto.parent}">
	        	<input type="hidden" name="page" value="${page}">
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