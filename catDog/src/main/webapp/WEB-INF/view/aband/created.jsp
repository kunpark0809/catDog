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
	    	var f= document.abandForm;
			
	        if(!f.speciesSort.value){
	        	alert("애견동물을 선택하세요. ");
	            f.speciesSort.focus();
	            return false;
	        }
			
	        if(!f.sort.value){
	        	alert("카테고리를 선택하세요. ");
	            f.subject.focus();
	            return false;
	        }
	        
	        if(!f.subject.value){
	        	alert("제목을 입력하세요. ");
	            f.subject.focus();
	            return false;
	        }
	        
	        if(!f.addr.value){
	        	alert("장소를 입력하세요. ");
	            f.addr.focus();
	            return false;
	        }
	        
	        if(!f.lostDate.value){
	        	alert("사건날짜를 입력하세요. ");
	            f.lostDate.focus();
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
	    
	   		f.action="<%=cp%>/aband/${mode}";
	   		f.submit();

	        return true;
	    }
	   

	</script>
	<link rel="stylesheet" href="<%=cp%>/resource/css/dogshop.css">
	<div class="container-board">
	<div class="body-title">
		<i class="far fa-sad-tear"></i>&nbsp;유기동물 등록
	</div>

	<div>

		<form name="abandForm" method="post" enctype="multipart/form-data" onsubmit="return submitContents(this);">
			<table style="width: 100%; border-collapse: collapse; border-spacing: 0; border-top: 2px solid #cccccc; margin-top: 30px;">

					<tr style="border-bottom: 1px solid #cccccc;">
					 	<td class="titleTd">분&nbsp;&nbsp;류</td>
						<td style="padding-left: 10px;">
							<select name="sort" class="createdInput">
								<option value="">::카테고리 선택::</option>
								<option value="0" ${dto.sort==0?"selected='selected'":""}>잃어버렸어요</option>
								<option value="1" ${dto.sort==1?"selected='selected'":""}>보호하고있어요</option>
							</select>
							<select name="speciesSort" class="createdInput">
								<option value="">::애견동물 선택::</option>
								<option value="1" ${dto.speciesSort==1?"selected='selected'":""}>강아지</option>
								<option value="0" ${dto.speciesSort==0?"selected='selected'":""}>고양이</option>
							</select>

						</td>
					</tr>
					<tr style="border-bottom: 1px solid #cccccc;">
						<td class="titleTd">제&nbsp;&nbsp;목</td>
						<td style="padding-left: 10px;">
							<input type="text" name="subject" value="${dto.subject}" class="createdInput" width="98%">
						</td>
					</tr>
					<tr style="border-bottom: 1px solid #cccccc;">
						<td class="titleTd">장&nbsp;&nbsp;소</td>
						<td style="padding-left: 10px;">
							<input type="text" name="addr" value="${dto.addr}" class="createdInput" width="98%">
						</td>
					</tr>
					<tr style="border-bottom: 1px solid #cccccc;">
						<td class="titleTd">사건발생날짜</td>
						<td style="padding-left: 10px;">
							<input type="text" name="lostDate" value="${dto.lostDate}" class="createdInput">
						</td>
					</tr>
					<tr align="left" style="border-bottom: 1px solid #cccccc;"> 
				      <td width="120" class="titleTd" valign="top">내&nbsp;&nbsp;용</td>
				      <td valign="top" style="padding:5px 0px 5px 10px;"> 
				        <textarea name="content" id="content" class="boxTA" style="width:98%; height: 270px;">
				        <c:if test="${mode=='update'}">
				        	${dto.content}
				        </c:if>
				        
				        <c:if test="${mode=='created'}">
							
							<strong>특징:</strong> <br><br>
							
							<strong>상세설명:</strong> <br><br>
							
							<strong>문의 방법:</strong> <br><br>				        
				        </c:if>
				        
				        </textarea>
				      </td>
			  		</tr>
					<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
						<td class="titleTd">메인사진</td>
						<td style="padding-left:10px;"> 
							<input type="file" name="upload" class="createdInput" size="53" style="height: 25px; width: 95%; border: none;">
						</td>
					</tr> 
					<c:if test="${mode=='update'}">
					<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
					<td class="titleTd">첨부된 메인사진</td>
					<td style="padding-left:10px;"> 
						<input type="hidden" name="imageFileName" value="${dto.imageFileName}">
						${dto.imageFileName} <strong>&nbsp;&nbsp;(새로운 메인사진을 첨부할 시 해당사진은 삭제됩니다.)</strong> 
					</td>
					</tr> 
				</c:if>
			</table>
			<table style="text-align: center; width: 100%; margin-top: 10px;">
				<tr>
					<td>
						<button type="submit" class="bts">${mode=="update"?"수정하기":"등록하기"}</button>
						<button type="reset" class="bts">다시입력</button>
						<button type="button" class="bts"
							onclick="javascript:location.href='<%=cp%>/aband/list?page=${page}';">${mode=="update"?"수정취소":"등록취소"}</button>
					</td>
				</tr>
			</table>

			<c:if test="${mode=='update'}">
				<input type="hidden" name=lostPetNum value="${dto.lostPetNum}">
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