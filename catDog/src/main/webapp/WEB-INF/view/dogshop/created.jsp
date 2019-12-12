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
	        var f = document.dogshopForm;
			
	        if(f.sortList.value == "0"){
	        	alert("용품분류를 선택하세요. ");
	            f.sortList.focus();
	            return;
	        }
	        
	        if(!f.name.value){
	        	alert("용품명을 입력하세요. ");
	            f.name.focus();
	            return;
	        }
	        
	        if(!f.price.value){
	        	alert("가격을 입력하세요. ");
	            f.price.focus();
	            return;
	        }
	        
	        
	    	var str = f.content.value;
	        if(!str || str=="<p>&nbsp;</p>") {
	            alert("내용을 입력하세요. ");
	            f.content.focus();
	            return;
	        }

	   		f.action="<%=cp%>/dogshop/created";
	   		f.submit();

	        return true;
	    }
	</script>
	<link rel="stylesheet" href="<%=cp%>/resource/css/dogshop.css">
	<div class="body-title">
		<h3><i class="fas fa-chalkboard-teacher"></i> 스터디 질문과 답변 </h3>
	</div>

	<div style="width: 100%">

		<form name="dogshopForm" method="post" enctype="multipart/form-data">
			<table style="width: 100%; border-collapse: collapse; border-spacing: 0">
				<tr>
					<td>분&nbsp;&nbsp;류</td>
					<td>
						<select name="sortList">
							<option value="0">::용품 선택::</option>
							<c:forEach var="sort" items="${sortList}">
								<option value="${sort.smallSortNum}">${sort.sortName}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td>용품명</td>
					<td>
						<input type="text" name="name">
					</td>
				</tr>
				<tr>
					<td>가&nbsp;&nbsp;격</td>
					<td>
						<input type="text" name="price">
					</td>
				</tr>
				<tr>
					<td>본문내용</td>
					<td>
						<textarea rows="12" name="content" id="content" style="width: 80%; height: 270px;"></textarea>
					</td>
				</tr>
				<tr>
					<td>용품 사진</td>
					<td>
						<input type="file" name="upload">
					</td>
				</tr>
			</table>
			<table>
				<tr>
					<td>
						<button type="button" onclick="sendOk();">등록하기</button>
						<button type="reset">다시입력</button>
						<button type="button" onclick="">등록취소</button>
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
		return check();
	} catch(e) {}
}

function setDefaultFont() {
	var sDefaultFont = '돋움';
	var nFontSize = 24;
	oEditors.getById["content"].setDefaultFont(sDefaultFont, nFontSize);
}
</script>