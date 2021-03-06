<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript" src="<%=cp%>/resource/se/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
	function check() {
	    var f = document.boardForm;
	
		var str = f.subject.value;
	    if(!str) {
	        alert("제목을 입력하세요. ");
	        f.subject.focus();
	        return false;
	    }
	
	    str = f.content.value;
	    if(!str || str=="<p>&nbsp;</p>") {
	        f.content.focus();
	        return false;
	    }
	
		f.action="<%=cp%>/notice/${mode}";
		f.submit();
	
	    return true;
	}
	
	 $(function(){
	    	$("form input[name=upload]").change(function(){
	    		if(! $(this).val()) return;
	    		
	    		var b=false;
	    		$("form input[name=upload]").each(function(){
	    			if(! $(this).val()) {
	    				b=true;
	    				return;
	    			}
	    		});
	    		if(b) return false;
	    			
	    		var $tr = $(this).closest("tr").clone(true); // 이벤트도 복제
	    		$tr.find("input").val("");
	    		$("#noticetb").append($tr);
	    	});
	    });

	    <c:if test="${mode=='update'}">
	    	function deleteFile(noticeFileNum) {
	    		var url="<%=cp%>/notice/deleteFile";
	    		$.post(url, {noticeFileNum:noticeFileNum}, function(data){
	    			$("#fileTr"+noticeFileNum).remove();
	    		}, "json");
	    	}
	    </c:if>
</script>

<div class="container-board">
    <div class="body-title">
		<span><i class="fas fa-exclamation-triangle"></i>&nbsp;공지사항</span>
	</div>
    
    <div>
			<form name="boardForm" method="post" onsubmit="return submitContents(this);" enctype="multipart/form-data">
			  <table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			  <tbody id="noticetb">
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#51321b" style="text-align: center; font-weight: bold; color: white;">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
			      <td style="padding-left:10px;"> 
			        <input type="text" name="subject" maxlength="100" class="boxTF" style="width: 95%; border-radius:5px;" value="${dto.subject}">
			      </td>
			  </tr>
			  
			  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
				<td width="100" bgcolor="#51321b" style="text-align: center; font-weight: bold; color: white;">공지여부</td>
				<td style="padding-left:10px;">
					<input type="checkbox" name="notice" value="1" ${dto.notice==1?"checked='checked'":""}> <label>공지</label>
				</td>
			  </tr>
			
			  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#51321b" style="text-align: center; font-weight: bold; color: white;">작성자</td>
			      <td style="padding-left:10px;"> 
			          ${sessionScope.member.nickName}
			      </td>
			  </tr>
			
			  <tr align="left" style="border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#51321b" style="text-align: center; font-weight: bold; padding-top:5px; color: white;" valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
			      <td valign="top" style="padding:5px 0px 5px 10px;"> 
			        <textarea name="content" id="content" class="boxTA" style="width:98%; height: 270px;">${dto.content}</textarea>
			      </td>
			  </tr>
			  
			  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
			      <td width="100" bgcolor="#51321b" style="text-align: center; font-weight: bold; color: white;">첨&nbsp;&nbsp;&nbsp;&nbsp;부</td>
			      <td style="padding-left:10px;"> 
			          <input type="file" name="upload" class="boxTF" size="53" style="width: 95%; height: 25px;">
			       </td>
			  </tr>
			  </tbody>
			  
			<c:if test="${mode=='update'}">
				<c:forEach var="vo" items="${listFile}">
					<tr id="fileTr${vo.noticeFileNum}" align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
						<td width="100" bgcolor="#51321b" style="text-align: center; font-weight: bold; color: white;">첨부된파일</td>
						<td style="padding-left:10px;">
							<a href="javascript:deleteFile('${vo.noticeFileNum}')"><i class="far fa-trash-alt"></i></a>&nbsp;${vo.originalFileName}
						</td>
					</tr>
				</c:forEach>			
			</c:if>
			  
			  </table>
			
			  <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			     <tr height="45"> 
			      <td align="center" >
			        <button type="submit" class="bts">${mode=='update'?'수정완료':'등록하기'}</button>
			        <button type="reset" class="bts">다시입력</button>
			        <button type="button" class="bts" onclick="javascript:location.href='<%=cp%>/notice/list';">${mode=='update'?'수정취소':'등록취소'}</button>
					<c:if test="${mode=='update'}">
						<input type="hidden" name="noticeNum" value="${dto.noticeNum}">
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
			// alert(" Ok !!!");
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
    
</div>
