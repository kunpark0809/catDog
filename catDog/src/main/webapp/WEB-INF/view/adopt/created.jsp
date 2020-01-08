<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%> 
	<script type="text/javascript" src="<%=cp%>/resource/se/js/HuskyEZCreator.js" charset="utf-8"></script>
	<script type="text/javascript">
	function ajaxJSON(url, type, query, fn){
		$.ajax({
			type:type
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data){
				fn(data);
			}
		, beforeSend:function(jqXHR){
			jqXHR.setRequestHeader("AJAX",true);
		}
		,error:function(jqXHR){
			if(jqXHR.status==403){
				login();
				return false;
			}
			console.log(jqXHR.resqonseText);
		}
		});
	}
	
	   function check() {
	    	var f= document.adoptForm;
			
	        if(!f.speciesSort.value){
	        	alert("애견동물을 선택하세요. ");
	            f.speciesSort.focus();
	            return false;
	        }

	        if(!f.subject.value){
	        	alert("제목을 입력하세요. ");
	            f.subject.focus();
	            return false;
	        }
	        
	        var str = f.content.value;
		    if(!str || str=="<p>&nbsp;</p>") {
		    	alert("내용 입력하세요 ");
		        f.content.focus();
		        return false;
		    }

	        var mode="${mode}";
	        

	        if(mode=="created"||mode=="update" && $f.upload.value!="") {
	    		if(! /(\.gif|\.jpg|\.png|\.jpeg)$/i.test(f.upload.value)) {
	    			alert('이미지 파일만 가능합니다.(bmp 파일은 불가) !!!');
	    			f.upload.focus();
	    			return false;
	    		}
	    	}
	    
	   		f.action="<%=cp%>/adopt/${mode}";
	   		f.submit();

	        return true;
	    }
	   

	</script>
	<link rel="stylesheet" href="<%=cp%>/resource/css/dogshop.css">
	<div class="shin_body">
	<div class="body-title">
		<h3><i class="fas fa-chalkboard-teacher"></i> 입양 등록 </h3>
	</div>

	<div>

		<form name="adoptForm" method="post" enctype="multipart/form-data" onsubmit="return submitContents(this);">
			<table style="width: 100%; border-collapse: collapse; border-spacing: 0">

					<tr>
						<td>분&nbsp;&nbsp;류</td>
						<td>
							<select name="speciesSort">
								<option value="">::애견동물 선택::</option>
								<option value="1" ${dto.speciesSort==1?"selected='selected'":""}>강아지</option>
								<option value="0" ${dto.speciesSort==0?"selected='selected'":""}>고양이</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>제목</td>
						<td>
							<input type="text" name="subject" value="${dto.subject}">
						</td>
					</tr>
					<tr align="left" style="border-bottom: 1px solid #cccccc;"> 
				      <td width="120" bgcolor="#eeeeee" style="text-align: center; padding-top:5px;" valign="top">내&nbsp;&nbsp;용</td>
				      <td valign="top" style="padding:5px 0px 5px 10px;"> 
				        <textarea name="content" id="content" class="boxTA" style="width:98%; height: 270px;">
				        <c:if test="${mode=='update'}">
				        	${dto.content}
				        </c:if>
				        
				        <c:if test="${mode=='created'}">
						    <strong>이름:</strong> <br><br>
							
							<strong>성별:</strong> <br><br>
							
							<strong>나이:</strong> <br><br>
							
							<strong>몸무게:</strong> <br><br>
							
							<strong>접종:</strong> <br><br>
							
							<strong>성격:</strong> <br><br>
							
							<strong>입양 문의:</strong> <br><br>				        
				        </c:if>
				        
				        </textarea>
				      </td>
			  		</tr>
					<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
						<td width="120">메인사진</td>
						<td style="padding-left:10px;"> 
							<input type="file" name="upload" class="boxTF" size="53" style="height: 25px; width: 95%;">
						</td>
					</tr> 
					<c:if test="${mode=='update'}">
					<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
					<td width="120">첨부된 메인사진</td>
					<td style="padding-left:10px;"> 
						<input type="hidden" name="imageFileName" value="${dto.imageFileName}">
						${dto.imageFileName} <strong>&nbsp;&nbsp;(새로운 메인사진을 첨부할 시 해당사진은 삭제됩니다.)</strong> 
					</td>
					</tr> 
				</c:if>
			</table>
			<table>
				<tr>
					<td>
						<button type="submit">${mode=="update"?"수정하기":"등록하기"}</button>
						<button type="reset">다시입력</button>
						<button type="button" onclick="javascript:location.href='<%=cp%>/adopt/list?page=${page}';">${mode=="update"?"수정취소":"등록취소"}</button>
					</td>
				</tr>
			</table>
			
			<c:if test="${mode=='update'}">
				<input type="hidden" name=adoptionNum value="${dto.adoptionNum}">
			</c:if>
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