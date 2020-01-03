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
	        var f = document.dogshopForm;
			
	        if(f.smallSortNum.value == "0"){
	        	alert("용품분류를 선택하세요. ");
	            f.smallSortNum.focus();
	            return false;
	        }
	        
	        if(!f.name.value){
	        	alert("용품명을 입력하세요. ");
	            f.name.focus();
	            return false;
	        }
	        
	        if(!f.price.value){
	        	alert("가격을 입력하세요. ");
	            f.price.focus();
	            return false;
	        }
	        
	        
	        var str = f.content.value;
		    if(!str || str=="<p>&nbsp;</p>") {
		    	alert("내용 입력하세요 ");
		        f.content.focus();
		        return false;
		    }

	        var mode="${mode}";
	        

	        if(mode=="created"||mode=="update" && $f.main.value!="") {
	    		if(! /(\.gif|\.jpg|\.png|\.jpeg)$/i.test(f.main.value)) {
	    			alert('이미지 파일만 가능합니다.(bmp 파일은 불가) !!!');
	    			f.main.focus();
	    			return false;
	    		}
	    	}
	    
	   		f.action="<%=cp%>/dogshop/created";
	   		f.submit();

	        return true;
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
		  	      $td=$("<td>", {width:"100", bgcolor:"#eeeeee", style:"text-align: center;", html:"추가사진"});
		  	      $tr.append($td);
		  	      $td=$("<td style='padding-left:10px;'>");
		  	      $input=$("<input>", {type:"file", name:"upload", class:"boxTF", style:"width: 95%; height: 25px;"});
		  	      $td.append($input);
		  	      $tr.append($td);
		  	    
		  	      $("#dogshopb").append($tr);
		  	  });
		  });
	</script>
	<link rel="stylesheet" href="<%=cp%>/resource/css/dogshop.css">
	<div class="shin_body">
	<div class="body-title">
		<h3><i class="fas fa-chalkboard-teacher"></i> DogShop 용품등록 </h3>
	</div>

	<div>

		<form name="dogshopForm" method="post" enctype="multipart/form-data" onsubmit="return submitContents(this);">
			<table style="width: 100%; border-collapse: collapse; border-spacing: 0">
			<tbody id="dogshopb">
					<tr>
						<td>분&nbsp;&nbsp;류</td>
						<td>
							<select name="smallSortNum">
								<option value="0">::용품 선택::</option>
								<c:forEach var="sort" items="${sortList}">
									<option value="${sort.smallSortNum}" ${dto.smallSortNum==sort.smallSortNum?"selected='selected'":""}>${sort.sortName}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td>용품명</td>
						<td>
							<input type="text" name="name" value="${dto.name}">
						</td>
					</tr>
					<tr>
						<td>가&nbsp;&nbsp;격</td>
						<td>
							<input type="text" name="price" value="${dto.price}">
						</td>
					</tr>
					<tr align="left" style="border-bottom: 1px solid #cccccc;"> 
				      <td width="100" bgcolor="#eeeeee" style="text-align: center; padding-top:5px;" valign="top">본문내용</td>
				      <td valign="top" style="padding:5px 0px 5px 10px;"> 
				        <textarea name="content" id="content" class="boxTA" style="width:98%; height: 270px;">${dto.content}</textarea>
				      </td>
			  		</tr>
			  		
			  		<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
					<td width="100">메인사진</td>
					<td style="padding-left:10px;"> 
						<input type="file" name="main" class="boxTF" size="53" style="height: 25px; width: 95%;">
					</td>
					</tr> 
					<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
					<td width="100">추가사진</td>
					<td style="padding-left:10px;"> 
						<input type="file" name="upload" class="boxTF" size="53" style="height: 25px; width: 95%;">
					</td>
					</tr> 
				</tbody>
			</table>
			<table>
				<tr>
					<td>
						<button type="submit">${mode=="update"?"수정하기":"등록하기"}</button>
						<button type="reset">다시입력</button>
						<button type="button" onclick="javascript:location.href='<%=cp%>/dogshop/list?smallSortNum=${smallSortNum}&page=${page}';">${mode=="update"?"수정취소":"등록취소"}</button>
					</td>
				</tr>
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