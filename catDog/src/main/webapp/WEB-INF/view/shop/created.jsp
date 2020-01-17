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
	        var f = document.shopForm;
			
	        if(f.bigSortNum.value == "all"){
	        	alert("애견동물을 선택하세요. ");
	            f.bigSortNum.focus();
	            return false;
	        }
	        
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
	    
	   		f.action="<%=cp%>/shop/${mode}";
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
		  	    
		  	      $("#shopb").append($tr);
		  	  });
		  });
	   
	   function changeBigSort(){
		   var bigSortNum = $("select[name=bigSortNum]").val();
		   $("select[name=smallSortNum] option").remove();
		   $("select[name=smallSortNum]").append("<option value='0'>::용품 선택::</option>");
		
		   if(bigSortNum=="all"){
			   return;
		   }
		   
		   var url = "<%=cp%>/shop/smallSort";
		   var query = "bigSortNum="+bigSortNum;
		   var fn = function(data){
			   $.each(data.smallSortList,function(idx, item){
				   $("select[name=smallSortNum]").append("<option value="+item.smallSortNum+">"+item.sortName+"</option>");
			   });
		   };
		   ajaxJSON(url,"get",query,fn);
	   };
	   
	   
	   <c:if test="${mode=='update'}">
		   	function deleteFile(picNum){
		   		if(confirm("삭제 후 복구 불가합니다. 정말 삭제 하시겠습니까?")){
		   			var query = "picNum="+picNum;
			   		var url="<%=cp%>/shop/deleteFile";
			   		var fn = function(data){
			   			$("#fileTr"+picNum).remove();
			   		}
			   		ajaxJSON(url, "post", query, fn);
		   		}
		   	};
	   </c:if>
	   

	</script>
	<link rel="stylesheet" href="<%=cp%>/resource/css/dogshop.css">
	<div class="wide-container">
	<div class="body-title">
		<i class="fas fa-cash-register"></i> 용품등록 
	</div>

	<div>

		<form name="shopForm" method="post" enctype="multipart/form-data" onsubmit="return submitContents(this);">
			<table style="width: 100%; border-collapse: collapse; border-spacing: 0; border-top: 2px solid #cccccc; margin-top: 30px;">

					
			<tbody id="shopb">
					<tr style="border-bottom: 1px solid #cccccc;">
						<td class="titleTd">분&nbsp;&nbsp;류</td>
						<td style="padding-left: 10px;">
							<select name="bigSortNum" onchange="changeBigSort();" class="createdInput">
								<option value="all">::애견동물 선택::</option>
								<c:forEach var="sort" items="${bigSortList}">
									<option value="${sort.bigSortNum}" ${dto.bigSortNum==sort.bigSortNum?"selected='selected'":""}>${sort.sortName}</option>
								</c:forEach>
							</select>
							<select name="smallSortNum" class="createdInput">
								<option value="0">::용품 선택::</option>
								<c:forEach var="sort" items="${smallSortList}">
									<option value="${sort.smallSortNum}" ${dto.smallSortNum==sort.smallSortNum?"selected='selected'":""}>${sort.sortName}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr style="border-bottom: 1px solid #cccccc;">
						<td class="titleTd">용품명</td>
						<td style="padding-left: 10px;">
							<input type="text" name="name" value="${dto.name}" class="createdInput" width="98%">
						</td>
					</tr>
					<tr style="border-bottom: 1px solid #cccccc;">
						<td class="titleTd">가&nbsp;&nbsp;격</td>
						<td style="padding-left: 10px;">
							<input type="text" name="price" value="${dto.price}" class="createdInput">
						</td>
					</tr>
					<tr align="left" style="border-bottom: 1px solid #cccccc;"> 
				      <td width="120" bgcolor="#eeeeee" style="text-align: center; padding-top:5px;" valign="top" class="titleTd">본문내용</td>
				      <td valign="top" style="padding:5px 0px 5px 10px;"> 
				        <textarea name="content" id="content" class="boxTA" style="width:98%; height: 270px;">${dto.content}</textarea>
				      </td>
			  		</tr>
			  		
			  		<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
					<td width="120" class="titleTd">메인사진</td>
					<td style="padding-left:10px;"> 
						<input class="createdInput" type="file" name="main" class="boxTF" size="53" style="height: 25px; width: 95%; border: none;">
					</td>
					</tr> 
					<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
					<td width="120" class="titleTd">본문사진</td>
					<td style="padding-left:10px;"> 
						<input  class="createdInput" type="file" name="upload" class="boxTF" size="53" style="height: 25px; width: 95%; border: none;">
					</td>
					</tr> 
				</tbody>
				<c:if test="${mode=='update'}">
					<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
					<td width="120" class="titleTd">첨부된 메인사진</td>
					<td style="padding-left:10px;" > 
						<input type="hidden" name="imageFileName" value="${dto.imageFileName}">
						${dto.imageFileName} <strong>&nbsp;&nbsp;(새로운 메인사진을 첨부할 시 해당사진은 삭제됩니다.)</strong> 
					</td>
					</tr> 
				<c:forEach var="pic" items="${picList}">
					<tr align="left" id="fileTr${pic.productPicNum}" height="40" style="border-bottom: 1px solid #cccccc;">
					<td width="120" class="titleTd">첨부된 본문사진</td>
					<td style="padding-left:10px;"> 
						<a href="javascript:deleteFile('${pic.productPicNum}')"><i class="far fa-trash-alt"></i></a>&nbsp;${pic.imageFileName}
					</td>
					</tr> 
				</c:forEach>
				</c:if>
			</table>
			<table style="text-align: center; width: 100%; margin-top: 10px;">
				<tr>

					<td>
						<button type="submit" class="bts">${mode=="update"?"수정하기":"등록하기"}</button>
						<button type="reset" class="bts">다시입력</button>
						<button type="button" class="bts" onclick="javascript:location.href='<%=cp%>/shop/list?bigSortNum=${bigSortNum}&smallSortNum=${smallSortNum}&page=${page}';">${mode=="update"?"수정취소":"등록취소"}</button>
					</td>
				</tr>
			</table>
			
			<c:if test="${mode=='update'}">
				<input type="hidden" name="productNum" value="${dto.productNum}">
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